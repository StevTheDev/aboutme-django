FROM python:3

WORKDIR /aboutme-django/

COPY . .

RUN pip install --no-cache-dir -r requirements.txt 

EXPOSE 8080

CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
