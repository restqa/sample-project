FROM kong:2.0

ARG KONG_CONFIG_FILE=kong.yml

RUN echo $KONG_CONFIG_FILE

COPY . /opt/app-root

RUN cat /opt/app-root/$KONG_CONFIG_FILE

ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/opt/app-root/$KONG_CONFIG_FILE
ENV KONG_LOG_LEVEL=info

RUN kong config -v parse /opt/app-root/$KONG_CONFIG_FILE

USER kong

