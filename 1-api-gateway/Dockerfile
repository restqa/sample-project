FROM kong:2.0

COPY kong.yml /

RUN cat /kong.yml

ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/kong.yml

RUN kong config -v parse /kong.yml


USER kong

