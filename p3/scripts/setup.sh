#!/bin/bash
set -e

if [ -z "$(which docker)" ]; then
    echo "Installing docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    echo [+] Docker installed successfully!
    rm get-docker.sh
else
    echo [+] Docker already installed.
    sleep 0.2
fi

if [ -z "$(which k3d)" ]; then
    echo "Installing k3d and kubectl..."
    wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | sudo bash
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
    echo 'alias k=kubectl' >>~/.bashrc
    echo 'source <(kubectl completion bash)' >>~/.bashrc
    echo 'source <(kubectl completion bash)' >>/root/.bashrc
    kubectl completion bash >/etc/bash_completion.d/kubectl



    echo [+] K3d and kubectl installed successfully!
else
    echo [+] K3d already installed.
    sleep 0.2
fi

if [ -z "$(k3d cluster list | grep iot)" ];then
    echo "Creating k3d cluster..."
    k3d cluster create  --port 8888:8888@loadbalancer  --port 80:80@loadbalancer iot
    echo [+] K3d cluster created successfully!
else
    echo [+] K3d cluster already created.
    sleep 0.2
fi

