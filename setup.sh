#!/bin/bash
# configure NIC devices

PUBLIC_IP_ADDRESS=$(ifconfig | grep 'inet 192.' | cut -d: -f2 | awk '{ print $2}')

# Update then install required packages
sudo apt update
sudo apt upgrade
sudo apt install -y python3 python3-dev python3-venv python-pip apache2 apache2-dev git

# Clone repo from github
git clone https://github.com/StevTheDev/AboutMe.git

# Create venv
python3 -m venv /home/stev/AboutMe/venv
source /home/stev/AboutMe/venv/bin/activate

# Update pip and install python dependencies
pip install --upgrade pip
pip install -r /home/stev/AboutMe/requirements.txt

# Generate Django Secret Key
sudo python3 /home/stev/AboutMe/write_config.py
sudo chgrp :www-data /home/stev/AboutMe/aboutme_django_config.yaml
sudo chmod 640 /home/stev/AboutMe/aboutme_django_config.yaml

# Update settings.py for production
sed -i "/DEBUG/c\\DEBUG = False" /home/stev/AboutMe/aboutme/aboutme/settings.py
sed -i "/ALLOWED_HOSTS/c\\ALLOWED_HOSTS=[\'$PUBLIC_IP_ADDRESS\']" /home/stev/AboutMe/aboutme/aboutme/settings.py

# Initialize Django
python /home/stev/AboutMe/aboutme/manage.py migrate
python /home/stev/AboutMe/aboutme/manage.py createsuperuser

# Configure mod_wsgi
mod_wsgi-express module-config > wsgi.load
sudo mv wsgi.load /etc/apache2/mods-available/wsgi.load

# Create apache config file for site
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/aboutme-django.conf

# Write to aboutme-django.conf above closing </VirtualHost> tag:
#
#	Alias /static /home/stev/AboutMe/aboutme/static
#    <Directory /home/stev/AboutMe/aboutme/static>
#        Require all granted
#    </Directory>
#
#    Alias /media /home/stev/AboutMe/aboutme/media
#    <Directory /home/stev/AboutMe/aboutme/media>
#        Require all granted
#    </Directory>
#
#    <Directory /home/stev/AboutMe/aboutme>
#        <Files wsgi.py>
#            Require all granted
#        </Files>
#    </Directory>
#
#    WSGIScriptAlias / /home/stev/AboutMe/aboutme/aboutme/wsgi.py
#    WSGIDaemonProcess aboutme_django python-home=/home/stev/AboutMe/venv python-path=/home/stev/AboutMe/aboutme
#    WSGIProcessGroup aboutme_django

sudo chgrp :www-data /home/stev/AboutMe/aboutme

sudo chgrp :www-data /home/stev/AboutMe/aboutme/db.sqlite3
sudo chmod 660 AboutMe/aboutme/db.sqlite3

sudo chgrp -R :www-data /home/stev/AboutMe/aboutme/media/
sudo chmod -R 660 aboutme/media

sudo chgrp -R :www-data /home/stev/AboutMe/venv/
sudo chmod -$ 750 /home/stev/AboutMe/venv/

a2dismod wsgi && a2enmod wsgi
a2ensite aboutme-django

ufw allow http, ssh
ufw enable