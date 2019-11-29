FROM alpine/helm:2.16.1

ARG CONFTEST_VERSION="0.15.0"
ARG TERRAFORM_VERSION="0.12.16"

ENV HELM_HOME=/root/.helm

RUN apk add --no-cache \
    git \
    curl \
    bash \
    jq \
    coreutils \
    ca-certificates

RUN helm init --client-only && \
    helm plugin install --debug https://github.com/instrumenta/helm-conftest

RUN curl -L https://github.com/instrumenta/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz | tar xzv -C /tmp && \
    mv /tmp/conftest /usr/local/bin/conftest && \
    rm -rf /tmp/*

RUN curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip | unzip -d /usr/local/bin/ - && \
    chmod +x /usr/local/bin/terraform

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
