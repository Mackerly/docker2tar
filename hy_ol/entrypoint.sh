#!/bin/sh
envsubst "\${PORT} \${PASSWORD}" < /ser.yml.template > /data/hysteria2/server.yml
curl -s ip.sb
exec "$@"
