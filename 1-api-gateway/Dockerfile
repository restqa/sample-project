FROM kong:2.0

ARG KONG_CONFIG_FILE=kong.yml

COPY . /opt/app-root
#RUN cd /opt/app-root/plugins/kong-forward-proxy &&  luarocks make --local

RUN cat /opt/app-root/$KONG_CONFIG_FILE

ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/opt/app-root/kong.yml
#ENV KONG_PLUGINS=forward-proxy,correlation-id
ENV KONG_LOG_LEVEL=info
#ENV KONG_LUA_PACKAGE_PATH=/kong-plugins/?.lua

RUN kong config -v parse /opt/app-root/$KONG_CONFIG_FILE

USER kong

