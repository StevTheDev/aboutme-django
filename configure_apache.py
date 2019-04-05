import os

# Write to aboutme-django.conf above closing </VirtualHost> tag:
config_lines = [
    '\tAlias /static /home/stev/AboutMe/aboutme/static\n',
    '\t<Directory /home/stev/AboutMe/aboutme/static>\n',
    '\t\tRequire all granted\n',
    '\t</Directory>\n',
    '\tAlias /media /home/stev/AboutMe/aboutme/media\n',
    '\t<Directory /home/stev/AboutMe/aboutme/media>\n',
    '\t\tRequire all granted\n',
    '\t</Directory>\n',
    '\t<Directory /home/stev/AboutMe/aboutme>\n',
    '\t\t<Files wsgi.py>\n',
    '\t\t\tRequire all granted\n',
    '\t\t</Files>\n',
    '\t</Directory>\n',
    '\tWSGIScriptAlias / /home/stev/AboutMe/aboutme/aboutme/wsgi.py\n',
    '\tWSGIDaemonProcess aboutme_django python-home=/home/stev/AboutMe/venv python-path=/home/stev/AboutMe/aboutme\n',
    '\tWSGIProcessGroup aboutme_django\n',
]

config_path = os.path.join('/','etc','apache2','sites-available','aboutme-django.conf')
lines = open(config_path).readlines()

split = lines.index('</VirtualHost>\n')

lines = lines[:split].extend(config_lines).extend(lines[split:])

with open(config_path,'w') as config_file:
    for line in lines:
        config_file.write(line)
