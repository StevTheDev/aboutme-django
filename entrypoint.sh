#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

groupadd -g 1000 uwsgi
useradd -u 1000 -g 1000 uwsgi
chown -R uwsgi:uwsgi /aboutme-django/aboutme/media/

exec /usr/local/bin/gosu uwsgi "$@"
