#!/bin/bash

set -ex
S_IP=$1
TOKEN=$2
# This script is run on the server node for the alpine vagrant machine
# install curl and ping
apk add --update --no-cache curl

if [ -z "$(which k3s)" ]; then
    echo "Installing and setting k3s up..."
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip $S_IP --write-kubeconfig-mode=644" K3S_TOKEN="${2}" K3S_KUBECONFIG_MODE="644" sh - 
    service k3s status >/dev/null 2>&1 && echo -e [+] "\e[32mK3s service started successfully!\e[0m" || echo -e [+] "\e[31mK3s service failed to start!\e[0m"
    echo -e [+] "\e[32mK3s installed successfully!\e[0m"   
else
    echo -e [+] "\e[32mK3s already installed.\e[0m"
fi

