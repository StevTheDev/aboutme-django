FROM python:3

WORKDIR /aboutme-django/

COPY . .

RUN pip install --no-cache-dir -r requirements.txt && \
    python ./aboutme/manage.py collectstatic && \
    python ./aboutme/manage.py makemigrations && \
    python ./aboutme/manage.py migrate

EXPOSE 8080

CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
