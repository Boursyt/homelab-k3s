FROM codercom/code-server:4.146.0

USER root
ARG TARGETARCH
ARG KUBECTL_VERSION=v1.37.2
ARG HELM_VERSION=v4.3.2
ARG TERRAFORM_VERSION=1.17.2
ARG GO_VERSION=1.27.4
ARG FLUX_VERSION=2.10.0
ARG SOPS_VERSION=v3.13.3
ARG AGE_VERSION=v1.3.2
ARG UV_VERSION=0.13.8

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl git jq unzip openssh-client make less procps python3 \
 && rm -rf /var/lib/apt/lists/*

COPY install-tools.sh /tmp/install-tools.sh
RUN KUBECTL_VERSION=$KUBECTL_VERSION HELM_VERSION=$HELM_VERSION TERRAFORM_VERSION=$TERRAFORM_VERSION GO_VERSION=$GO_VERSION \
    FLUX_VERSION=$FLUX_VERSION SOPS_VERSION=$SOPS_VERSION AGE_VERSION=$AGE_VERSION UV_VERSION=$UV_VERSION TARGETARCH=$TARGETARCH \
    /tmp/install-tools.sh && rm /tmp/install-tools.sh

ENV PATH=/usr/local/go/bin:/home/coder/go/bin:$PATH
USER 1000
