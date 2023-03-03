#!/bin/bash
set -euo pipefail
## Get virtualbox and vagrant ready on a debian based system

if [ -z "$(which virtualbox)" ]; then
    echo "Installing virtualbox"∫
    wget https://download.virtualbox.org/virtualbox/7.0.6/virtualbox-7.0_7.0.6-155176~Debian~bullseye_amd64.deb -O /tmp/virtualbox.deb
    dpkg -i /tmp/virtualbox.deb
else
    echo -e "\e[32mVirtualbox already installed\e[0m"
fi


# Install vagrant 
if [ -z "$(which vagrant)" ]; then
    echo "Installing vagrant"
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update && apt install vagrant
else
    echo -e "\e[32mVagrant already installed\e[0m"
fi


# Install k8s

if [ -z "$(which kubectl)" ]; then
    echo "Installing kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
else
    echo -e "\e[32mKubectl already installed\e[0m"
fi


# clean up
rm -f /tmp/virtualbox.deb || true

