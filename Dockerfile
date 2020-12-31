# Dockerfile: hombre-fail2ban

FROM hombrelab/hombre-alpine AS builder

RUN apk add --no-cache \
    git \
    build-base \
    && git clone --branch 0.11.2 https://github.com/fail2ban/fail2ban.git

FROM hombrelab/hombre-python

ARG version

LABEL version="${version}"
LABEL description="Customized Fail2ban Docker image"
LABEL maintainer="Hombrelab <me@hombrelab.com>"
LABEL inspiration="getting things done my way"

COPY --from=builder /fail2ban /fail2ban

RUN cd /fail2ban \
    && python setup.py install \
    && cd / \
    && mkdir -p /usr/local/etc/fail2ban \
    && cp -rp /etc/fail2ban /usr/local/etc \
    && rm -rfv /tmp/*

COPY ./app/init.sh /entrypoint.sh

RUN chmod 755 -v /entrypoint.sh \
    && mkdir -v /entrypoint.d

VOLUME ["/fail2ban/config", "/var/lib/fail2ban"]

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["fail2ban-server", "-f", "-x", "start"]

HEALTHCHECK --interval=30s --timeout=5s CMD fail2ban-client ping || exit 1
