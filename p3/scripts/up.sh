#!/bin/bash


#namespaces

kubectl apply -f /home/vagrant/iot/p3/confs/argoCD/namespace.yml
kubectl apply -f /home/vagrant/iot/p3/confs/argoCD/argocd.depl.yml


# kubectl apply -f /home/vagrant/iot/p3/confs/dev/namespace.yml -n dev
# kubectl apply -f /home/vagrant/iot/p3/confs/dev/deployment.yml -n dev
kubectl apply -f /home/vagrant/iot/p3/confs/ingress.yml -n dev