FROM nginx

COPY ./uwsgi-proxy.conf /etc/nginx/nginx.conf

RUN apt-get update && \
    apt-get install -y certbot python-certbot-nginx && \
    certbot --nginx certonly

CMD ["nginx", "-g", "daemon off;"]
