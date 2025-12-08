# 使用 Alpine Linux 作为基础镜像，轻量且适合容器
FROM openlistteam/openlist:latest

# 设置环境变量以确保终端支持彩色输出（可选）
ENV TERM=xterm-256color
ENV TZ=Asia/Shanghai

VOLUME ["/data", "/data/hysteria2/"] 

USER root

# 复制 supervisord 配置文件和自定义脚本
COPY supervisord.conf ser.yml.template entrypoint.sh /

# 更新包索引并安装 supervisor 和 nginx
RUN apk update && \
    apk add --no-cache vim  openssl envsubst wget bash gettext tzdata ca-certificates curl supervisor sqlite && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    wget https://github.com/apernet/hysteria/releases/download/app%2Fv2.6.5/hysteria-linux-amd64 --output-document=/usr/bin/hysteria-linux-amd64 && \
    mkdir -p /var/log/supervisor /data/hysteria2/ /var/log/supervisor/ /var/log/openlist/  /var/run/ /var/log/hysteria2/ &&\
    chmod +x /usr/bin/hysteria-linux-amd64 && \
    openssl genrsa -out /hy2.key 2048 && \
    openssl req -new -x509 -key /hy2.key -out /hy2.crt -days 36500 -subj "/C=HK/ST=Hong Kong/L=Hong Kong/O=ooyy/OU=www.xxx/CN=www.ooyy.com" && \
    chmod +x /entrypoint.sh 

# 暴露 openlist 5244 5245 supervisord 9001 的默认端口
EXPOSE 5244 9001 

# 设置入口点
ENTRYPOINT ["/entrypoint.sh"]

# 设置容器启动时运行的命令
CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
