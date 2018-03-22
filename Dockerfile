FROM alpine:3.7

ENV TAG=v10.3.9

RUN apk upgrade --no-cache && \
    apk add --no-cache \
      vim \
      sudo \
      git \
      ruby ruby-bundler ruby-rdoc ruby-rake ruby-bigdecimal ruby-irb \
      nodejs \
      postgresql-client \
      tzdata \
      procps \
      nginx \
      patch \
      dcron \
      logrotate

COPY assets /home/git/assets/

RUN adduser -s /bin/sh -g 'GitLab' -D git; \
    chown -R git:git /home/git; \
    ash -ex /home/git/assets/build/install.sh

ENTRYPOINT ["/home/git/assets/runtime/docker-entrypoint.sh"]

EXPOSE 80/tcp 443/tcp

VOLUME ["/home/git/data","/var/log","/etc/gitlab/"]
