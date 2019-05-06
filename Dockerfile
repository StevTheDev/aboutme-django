FROM python:3

WORKDIR /aboutme-django/

COPY . .

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && chmod +x /usr/local/bin/gosu

EXPOSE 8080

ENTRYPOINT [ "aboutme-django/entrypoint.sh" ]

RUN pip install --no-cache-dir -r requirements.txt && \
    python ./aboutme/manage.py collectstatic && \
    chown -R :uwsgi /aboutme-django/aboutme/

CMD [ "uwsgi", "/aboutme-django/config/uWSGI.ini"]
