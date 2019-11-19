FROM alpine/helm:2.16.0

ENV HELM_HOME /root/.helm

RUN apk update \
    && apk add bash git curl wget \
    && rm -rf /var/cache/apk/*

RUN helm init --client-only

RUN helm plugin install --debug https://github.com/instrumenta/helm-conftest

RUN curl -L https://github.com/instrumenta/conftest/releases/download/v0.15.0/conftest_0.15.0_Linux_x86_64.tar.gz | tar xzv -C /tmp && \
    mv /tmp/conftest /usr/local/bin/conftest && \
    rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
