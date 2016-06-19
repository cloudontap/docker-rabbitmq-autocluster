FROM gavinmroy/alpine-rabbitmq-autocluster:3.6.2-0.6.1

RUN 0
RUN apk-install curl
USER rabbitmq

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/lib/rabbitmq/sbin/rabbitmq-server"]
