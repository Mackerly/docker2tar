# 使用 Alpine Linux 作为基础镜像，轻量且适合容器
FROM openlistteam/openlist:latest

# 设置环境变量以确保终端支持彩色输出（可选）
ENV TERM=xterm-256color
ENV TZ=Asia/Shanghai

# 复制 supervisord 配置文件和自定义脚本
COPY hy_ol/ser.yml.template hy_ol/entrypoint.sh /

VOLUME ["/data", "/data/hysteria2/"] 

USER root

# 更新包索引并安装 supervisor 和 nginx
RUN apk update && \
    apk add --no-cache vim  openssl envsubst wget bash gettext tzdata ca-certificates curl runit sqlite && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    wget https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 --output-document=/usr/bin/hysteria-linux-amd64 && \
    chmod +x /usr/bin/hysteria-linux-amd64 && \
    openssl genrsa -out /hy2.key 2048 && \
    openssl req -new -x509 -key /hy2.key -out /hy2.crt -days 36500 -subj "/C=HK/ST=Hong Kong/L=Hong Kong/O=ooyy/OU=www.xxx/CN=www.ooyy.com" && \
    mkdir -p /etc/service/hysteria /etc/service/openlist && \
    echo '#!/bin/sh' > /etc/service/hysteria/run && \
    echo 'exec /usr/bin/hysteria-linux-amd64 server -c /data/hysteria2/server.yml' >> /etc/service/hysteria/run && \
    chmod +x /etc/service/hysteria/run && \
    echo '#!/bin/sh' > /etc/service/openlist/run && \
    echo 'exec /opt/openlist/openlist server' >> /etc/service/openlist/run && \
    chmod +x /etc/service/openlist/run && \
    chmod +x /entrypoint.sh 

# 暴露 iopenlist 5244 5245 supervisord 9001 的默认端口
EXPOSE 5244  9001

# 设置入口点
ENTRYPOINT ["/entrypoint.sh"]

# 设置容器启动时运行的命令
CMD ["runsvdir", "-P", "/etc/service"]
