#!/bin/bash

# Update then install required packages
echo "Installing Software Requirements"
sudo apt update
sudo apt upgrade -y
sudo apt install -y python3 python3-dev python3-venv python-pip apache2 apache2-dev git
echo "Done."

# Clone repo from github
echo "Cloning repo from github"
git clone https://github.com/StevTheDev/AboutMe.git
echo "Done."

# Create venv
echo "Setting Up Virtual Environment"
python3 -m venv /home/stev/AboutMe/venv

# Update pip and install python dependencies
/home/stev/AboutMe/venv/bin/pip install --upgrade pip
/home/stev/AboutMe/venv/bin/pip install -r /home/stev/AboutMe/requirements.txt
echo "Done."

# Generate Django Secret Key
echo "Generating Django Secret Key"
sudo /home/stev/AboutMe/venv/bin/python3 /home/stev/AboutMe/config/write_django_secrets.py
sudo chgrp www-data /home/stev/AboutMe/config/django_secrets.yaml
sudo chmod 640 /home/stev/AboutMe/config/django_secrets.yaml
echo "Done."

# Update settings.py for production
echo "Updating settings.py for production"
sed -i "/DEBUG/c\\DEBUG = False" /home/stev/AboutMe/aboutme/aboutme/settings.py

PUBLIC_IP_ADDRESS=$(ifconfig | grep 'inet 192.' | cut -d: -f2 | awk '{ print $2}')
sed -i "/ALLOWED_HOSTS/c\\ALLOWED_HOSTS=[\'$PUBLIC_IP_ADDRESS\']" /home/stev/AboutMe/aboutme/aboutme/settings.py
echo "Done."

# Initialize Django
echo "Initializing Django"
sudo /home/stev/AboutMe/venv/bin/python3 /home/stev/AboutMe/aboutme/manage.py migrate
sudo /home/stev/AboutMe/venv/bin/python3 /home/stev/AboutMe/aboutme/manage.py createsuperuser
sudo /home/stev/AboutMe/venv/bin/python3 /home/stev/AboutMe/aboutme/manage.py collectstatic
echo "Done."

# Initialize and Configure mod_wsgi
echo "Initializing mod_wsgi"
a2enmod wsgi
/home/stev/AboutMe/venv/bin/mod_wsgi-express module-config > wsgi.load
sudo mv wsgi.load /etc/apache2/mods-available/wsgi.load
echo "Done."

# Create apache config file for site
echo "Initializing apache config"
sudo mv /home/stev/AboutMe/config/aboutme-django-apache.conf /etc/apache2/sites-available/aboutme-django.conf
echo "Done."

echo "Configuring Permissions"
sudo chgrp www-data /home/stev/AboutMe/aboutme
sudo chgrp www-data /home/stev/AboutMe/aboutme/db.sqlite3
sudo chmod 660 AboutMe/aboutme/db.sqlite3
mkdir /home/stev/AboutMe/aboutme/media
sudo chgrp -R www-data /home/stev/AboutMe/aboutme/media
sudo chmod -R 770 /home/stev/AboutMe/aboutme/media
sudo chgrp -R www-data /home/stev/AboutMe/venv/
sudo chmod -R 770 /home/stev/AboutMe/venv/
echo "Done."

echo "Enable WSGI"
sudo a2dismod wsgi 
sudo /home/stev/AboutMe/venv/bin/python3 /home/stev/AboutMe/aboutme/manage.py runmodwsgi --setup-only --port=80 \
    --user www-data --group www-data \
    --server-root=/etc/mod_wsgi-express-80
sudo a2enmod wsgi
echo "Done."

echo "Enabling Apache Site"
sudo a2ensite aboutme-django.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2
echo "Done."

echo "Configuring SSH"
sudo mv /home/stev/AboutMe/config/sshd_config /etc/ssh/
mkdir /home/stev/.ssh
mv /home/stev/AboutMe/config/authorized_keys /home/stev/.ssh/
chmod -w /home/stev/.ssh/authorized_keys
sudo systemctl restart ssh
echo "Done."

echo "Activating Firewall"
sudo ufw allow http
sudo ufw allow ssh
sudo ufw enable
echo "Done."

echo "Setup Complete"
