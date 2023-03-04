#!/bin/sh

set -ex
S_IP=$1
TOKEN=$2

# Install required packages
apk add --update --no-cache curl


echo "Installing k3s agent..."
curl -sfL https://get.k3s.io | K3S_URL="https://${S_IP}:6443" K3S_TOKEN="${TOKEN}" K3S_KUBECONFIG_MODE=644 sh -
rc-service k3s-agent status
echo -e [+] "\e[32mK3s agent installed successfully!\e[0m"
