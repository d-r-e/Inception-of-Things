#!/bin/bash
set -e 


sudo k3s kubectl apply -f /vagrant/confs/app1.yaml
echo [Inception-Of-Things] "App1 deployed successfully."
sudo k3s kubectl apply -f /vagrant/confs/app2.yaml
echo [Inception-Of-Things] "App2 deployed successfully."
sudo k3s kubectl apply -f /vagrant/confs/app3.yaml
echo [Inception-Of-Things] "App3 deployed successfully."
sudo k3s kubectl apply -f /vagrant/confs/ingress.yaml
echo -e [Inception-Of-Things] "Ingress deployed successfully!" 