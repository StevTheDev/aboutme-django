FROM python:3

WORKDIR /aboutme-django/

COPY . .

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
USER uwsgi:uwsgi

RUN pip install --no-cache-dir -r requirements.txt && \
    python ./aboutme/manage.py collectstatic

EXPOSE 8080

CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
