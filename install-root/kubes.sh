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
curl -fsSLo kubectx "https://github.com/ahmetb/kubectx/releases/download/v${kubectx_version}/kubectx"
echo "e887e4e2b3dd4c94d0ecdb84270fb4fac2e65c4d5b0ee461e688fb8089fd4900  kubectx"  | sha256sum --check
install kubectx /usr/local/bin
popd && rm -rf "$tmp_dir"

# kubens
echo "Install kubens"
kubens_version=0.9.4
tmp_dir=$(mktemp -d) && pushd "$tmp_dir"
curl -fsSLo kubens "https://github.com/ahmetb/kubectx/releases/download/v${kubens_version}/kubens"
echo "509c97c0882e688ae8fad8aa13524cc7c003e4883db447a905bdb47d64c13bdc  kubens"  | sha256sum --check
install kubens /usr/local/bin
popd && rm -rf "$tmp_dir"

# k3d
echo "Install k3d"
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
