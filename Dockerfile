FROM python:3

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

USER uwsgi:uwsgi

WORKDIR /aboutme-django/

COPY . .

RUN python -m venv venv && \
    .\venv\bin\activate.sh && \
    pip install --no-cache-dir -r requirements.txt && \
    python ./aboutme/manage.py collectstatic

EXPOSE 8080

CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
