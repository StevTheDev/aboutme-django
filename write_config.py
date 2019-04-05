import os, yaml, string, secrets

config_path = os.path.join('/','etc','aboutme_django_config.yml')
charset = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)'

with open(config_path, 'w') as config_file:
    config_file.write(f'    SECRET_KEY: {"".join(secrets.choice(charset) for i in range(50))}\n')
