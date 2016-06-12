FROM gavinmroy/alpine-rabbitmq-autocluster:3.6.2-0.6.0

# So we can tweak things and adjust the hostname - we use gosu in entrypoint
# script to run as rabbit user created in base docker image
USER 0

RUN apk add --no-cache su-exec
    
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
