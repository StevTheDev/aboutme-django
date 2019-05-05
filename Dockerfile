FROM python:3-alpine

WORKDIR /aboutme-django/

COPY . .

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi && \
    pip install --no-cache-dir -r requirements.txt && \
    python ./aboutme/manage.py collectstatic && \
    chown -R :uwsgi /aboutme-django/aboutme/

EXPOSE 8080

USER uwsgi:uwsgi
CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
