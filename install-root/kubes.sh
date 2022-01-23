#!/usr/bin/env bash

set -euo pipefail

# kubectl
echo "Install kubectl"

curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y kubectl

# helm
echo "Install helm"
curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# k9s
echo "Install k9s"
k9s_version=0.25.18
tmp_dir=$(mktemp -d) && pushd "$tmp_dir"
curl -fsSLo k9s.tar.gz "https://github.com/derailed/k9s/releases/download/v${k9s_version}/k9s_Linux_x86_64.tar.gz"
echo "d288aacc368ab6b243fc9e7ecd17b53fa34a813509c2dc3023171085db83cf9d  k9s.tar.gz"  | sha256sum --check
tar -zxf k9s.tar.gz
install k9s /usr/local/bin
popd && rm -rf "$tmp_dir"

# kubectx
echo "Install kubectx"
kubectx_version=0.9.4
tmp_dir=$(mktemp -d) && pushd "$tmp_dir"
curl -fsSLo kubectx.tar.gz "https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/kubectx_v${kubectx_version}_linux_x86_64.tar.gz"
echo "db5a48e85ff4d8c6fa947e3021e11ba4376f9588dd5fa779a80ed5c18287db22  kubectx.tar.gz"  | sha256sum --check
tar -zxf kubectx.tar.gz
install kubectx /usr/local/bin
popd && rm -rf "$tmp_dir"

# kubens
echo "Install kubens"
kubens_version=0.9.4
tmp_dir=$(mktemp -d) && pushd "$tmp_dir"
curl -fsSLo kubens.tar.gz "https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/kubens_v${kubens_version}_linux_x86_64.tar.gz"
echo "8b3672961fb15f8b87d5793af8bd3c1cca52c016596fbf57c46ab4ef39265fcd  kubens.tar.gz"  | sha256sum --check
tar -zxf kubens.tar.gz
install kubens /usr/local/bin
popd && rm -rf "$tmp_dir"

# k3d
echo "Install k3d"
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
