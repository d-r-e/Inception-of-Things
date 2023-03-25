#!/bin/sh

set -e
# source /vagrant/.env
# echo Configuring k3s with token: $K3S_TOKEN
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - --node-ip "192.168.56.110" --node-name darodrigS

echo 'alias k="sudo k3s kubectl"' >> /root/.bashrc

sudo echo "127.0.0.1" app1.com >> /etc/hosts
sudo echo "127.0.0.1" app2.com >> /etc/hosts
sudo echo "127.0.0.1" app3.com >> /etc/hosts

echo -e [Inception-Of-Things] "Hosts file updated successfully."
alias k="sudo k3s kubectl"
sudo echo 'alias k="sudo k3s kubectl"' >> /root/.bashrc
sudo echo 'alias k="sudo k3s kubectl"' >> /home/vagrant/.bashrc
echo -e [Inception-Of-Things] "Alias k=kubectl added to ~/.bashrc"

sleep 10

