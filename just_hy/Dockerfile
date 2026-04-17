FROM alpine:latest

RUN apk add --no-cache openssl wget  bash gettext tzdata curl ca-certificates

ENV TZ=Asia/Shanghai
COPY hy_ol/ser.yml.template /

WORKDIR /data

RUN wget https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 --output-document=/usr/bin/hysteria-linux-amd64 && \
    chmod +x /usr/bin/hysteria-linux-amd64 && \
    openssl genrsa -out /hy2.key 2048 && \
    openssl req -new -x509 -key /hy2.key -out /hy2.crt -days 36500 -subj "/C=HK/ST=Hong Kong/L=Hong Kong/O=ooyy/OU=www.xxx/CN=www.ooyy.com" && \
    echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'envsubst "\${PORT} \${PASSWORD}" < /ser.yml.template > /data/server.yml' >> /entrypoint.sh && \
    echo 'curl -s ip.sb' >> /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    rm -rf /var/cache/apk/* 

# 设置入口点
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/hysteria-linux-amd64","server","-c","/data/server.yml"]
