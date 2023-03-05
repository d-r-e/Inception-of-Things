#!/bin/sh

set -e
source /vagrant/.env
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" K3S_TOKEN="$K3S_TOKEN" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -s -

echo 'alias k="sudo k3s kubectl"' >> /home/vagrant/.bashrc

sudo echo "127.0.0.1" app1.com >> /etc/hosts
sudo echo "127.0.0.1" app2.com >> /etc/hosts
sudo echo "127.0.0.1" app3.com >> /etc/hosts

echo -e [Inception-Of-Things] "Hosts file updated successfully."
alias k="sudo k3s kubectl"
echo -e [Inception-Of-Things] "Alias k=kubectl added to ~/.bashrc"

sleep 10

k apply -f /vagrant/confs/app1.yaml
echo [Inception-Of-Things] "App1 deployed successfully."
k apply -f /vagrant/confs/app2.yaml
echo [Inception-Of-Things] "App2 deployed successfully."
k apply -f /vagrant/confs/app3.yaml
echo [Inception-Of-Things] "App3 deployed successfully."
k apply -f /vagrant/confs/ingress.yaml
echo -e [Inception-Of-Things] "Ingress deployed successfully!"