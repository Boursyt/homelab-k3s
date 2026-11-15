#!/bin/sh
set -eu
arch=${TARGETARCH:-$(dpkg --print-architecture)}
case "$arch" in amd64) uvarch=x86_64 ;; arm64) uvarch=aarch64 ;; *) echo "unsupported arch $arch" >&2; exit 1 ;; esac
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
dl() { curl -fsSL --retry 3 -o "$2" "$1"; }

dl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${arch}/kubectl" /usr/local/bin/kubectl
dl "https://get.helm.sh/helm-${HELM_VERSION}-linux-${arch}.tar.gz" "$tmp/helm.tgz"
tar -xzf "$tmp/helm.tgz" -C "$tmp" && mv "$tmp/linux-${arch}/helm" /usr/local/bin/helm
dl "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${arch}.zip" "$tmp/tf.zip"
unzip -q -o "$tmp/tf.zip" terraform -d /usr/local/bin
dl "https://go.dev/dl/go${GO_VERSION}.linux-${arch}.tar.gz" "$tmp/go.tgz"
tar -xzf "$tmp/go.tgz" -C /usr/local
dl "https://github.com/fluxcd/flux2/releases/download/v${FLUX_VERSION}/flux_${FLUX_VERSION}_linux_${arch}.tar.gz" "$tmp/flux.tgz"
tar -xzf "$tmp/flux.tgz" -C /usr/local/bin flux
dl "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.${arch}" /usr/local/bin/sops
dl "https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-linux-${arch}.tar.gz" "$tmp/age.tgz"
tar -xzf "$tmp/age.tgz" -C "$tmp" && mv "$tmp/age/age" "$tmp/age/age-keygen" /usr/local/bin/
dl "https://github.com/astral-sh/uv/releases/download/${UV_VERSION}/uv-${uvarch}-unknown-linux-gnu.tar.gz" "$tmp/uv.tgz"
tar -xzf "$tmp/uv.tgz" -C "$tmp" && mv "$tmp/uv-${uvarch}-unknown-linux-gnu/uv" "$tmp/uv-${uvarch}-unknown-linux-gnu/uvx" /usr/local/bin/
chmod 755 /usr/local/bin/kubectl /usr/local/bin/helm /usr/local/bin/terraform /usr/local/bin/flux /usr/local/bin/sops /usr/local/bin/age /usr/local/bin/age-keygen /usr/local/bin/uv /usr/local/bin/uvx
