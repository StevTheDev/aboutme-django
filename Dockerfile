FROM python:3-alpine

WORKDIR /aboutme-django/

COPY . /aboutme-django/

RUN pip install --no-cache-dir -r requirements.txt 

EXPOSE 52520

CMD [ "uwsgi", "/config/uWSGI.ini"]
