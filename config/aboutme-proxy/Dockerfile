FROM nginx

WORKDIR /aboutme-proxy/

COPY ./uwsgi-proxy.conf /etc/nginx/nginx.conf

COPY ./entrypoint.sh /aboutme-proxy/entrypoint.sh

RUN chmod +x /aboutme-proxy/entrypoint.sh

ENTRYPOINT [ "/aboutme-proxy/entrypoint.sh" ]

CMD ["nginx", "-g", "daemon off;"]