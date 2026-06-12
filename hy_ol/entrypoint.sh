#!/bin/sh
envsubst "\${PORT} \${PASSWORD}" < /ser.yml.template > /data/hysteria2/server.yml
curl -s ip.sb
openssl x509 -fingerprint -sha256 -noout -in /hy2.crt | awk -F'=' '{print "pinSHA256=" $2 }'
exec "$@"
