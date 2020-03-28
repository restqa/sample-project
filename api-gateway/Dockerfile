FROM nginx:alpine

ARG NGINX_CONFIG_FILE=${NGINX_CONFIG_FILE:-nginx.conf}

RUN echo $NGINX_CONFIG_FILE

COPY $NGINX_CONFIG_FILE /etc/nginx/nginx.conf

RUN cat /etc/nginx/nginx.conf


