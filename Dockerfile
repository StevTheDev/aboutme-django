FROM python:3

WORKDIR /aboutme-django/

COPY . .

RUN pip install --no-cache-dir -r requirements.txt 

EXPOSE 8080

CMD [ "python", "/aboutme-django/aboutme/manage.py", "makemigrations"]
CMD [ "python", "/aboutme-django/aboutme/manage.py", "migrate"]
CMD [ "python", "/aboutme-django/aboutme/manage.py", "collectstatic"]
CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
