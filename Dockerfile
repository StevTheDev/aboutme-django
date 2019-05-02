FROM python:3-alpine

WORKDIR /aboutme-django/

COPY . /aboutme-django/

RUN pip install --no-cache-dir -r requirements.txt 

EXPOSE 8000

CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
