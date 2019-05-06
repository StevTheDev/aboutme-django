#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback
USER_ID=1000

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -g $USER_ID -o -c "" -m uwsgi
export HOME=/home/uwsgi

exec /usr/local/bin/gosu uwsgi "$@"
