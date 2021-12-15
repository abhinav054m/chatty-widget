#!/bin/sh
cd /usr/share/nginx/html
find /usr/share/nginx/html  -type f | LC_ALL=C xargs sed -i 's|'http://localhost:7979'|'"$API_URL"'|g'
find /usr/share/nginx/html  -type f | LC_ALL=C xargs sed -i 's|'socket_path_to_change'|'"$SOCKET_PATH"'|g'
nginx -g 'daemon off;'