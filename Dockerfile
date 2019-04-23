FROM python:3

WORKDIR /AboutMe/

COPY . /AboutMe/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

CMD [ "uwsgi", "/AboutMe/uWSGI.ini"]
