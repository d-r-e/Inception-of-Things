#!/bin/bash
set -e 

# await for k3s to be ready
echo [Inception-Of-Things] "Waiting for k3s to be ready..."
while [ -z "$(kubectl get nodes | grep master)" ]; do
    sleep 1
done




kubectl apply -f /vagrant/confs/app1.yaml
echo [Inception-Of-Things] "App1 deployed successfully."
kubectl apply -f /vagrant/confs/app2.yaml
echo [Inception-Of-Things] "App2 deployed successfully."
kubectl apply -f /vagrant/confs/app3.yaml
echo [Inception-Of-Things] "App3 deployed successfully."
kubectl apply -f /vagrant/confs/ingress.yaml
echo -e [Inception-Of-Things] "Ingress deployed successfully!" 