#!/bin/sh
# entrypoint.sh

# 确保存储目录存在
mkdir -p /etc/data/hysteria2/cert/

# 💡 如果证书不存在，则在运行时现场生成
if [ ! -f /etc/data/hysteria2/cert/hy2.key ]; then
    echo "证书不存在，正在生成自签名证书..."
    openssl genrsa -out /etc/data/hysteria2/cert/hy2.key 2048
    openssl req -new -x509 -key /etc/data/hysteria2/cert/hy2.key -out /etc/data/hysteria2/cert/hy2.crt -days 36500 -subj "/C=HK/ST=Hong Kong/L=Hong Kong/O=ooyy/OU=www.xxx/CN=://ooyy.com"
else
    echo "检测到已有证书，跳过生成。"
fi

envsubst "\${PORT} \${PASSWORD}" < /ser.yml.template > /etc/data/hysteria2/server.yml
curl -s ip.sb
openssl x509 -fingerprint -sha256 -noout -in /etc/data/hysteria2/cert/hy2.crt | awk -F'=' '{print "pinSHA256=" $2 }'
exec "$@"
