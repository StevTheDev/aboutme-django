#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback
USER_ID=1000

groupadd -g 1000
useradd -u 1000 -g 1000 uwsgi

exec /usr/local/bin/gosu uwsgi "$@"
