FROM nginx:mainline-alpine-slim
MAINTAINER ifeng <https://t.me/HiaiFeng>
EXPOSE 80
USER root

RUN apk update && apk add --no-cache supervisor wget unzip curl

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /opt/alist /opt/alist/data
COPY config.json /opt/alist/data/
COPY data.db /opt/alist/data/
COPY data.db-shm /opt/alist/data/
COPY data.db-wal /opt/alist/data/
COPY entrypoint.sh /opt/alist/

# Dockerfile 层优化方案
RUN chmod a+x /opt/alist/entrypoint.sh
    
ENTRYPOINT [ "/opt/alist/entrypoint.sh" ]
