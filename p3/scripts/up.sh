#!/bin/bash


#namespaces

kubectl apply -f /home/vagrant/iot/p3/confs/argoCD/namespace.yml -n argocd
kubectl config set-context --current --namespace=argocd
echo [+] Namespace created successfully!
sleep 1

kubectl apply -f /home/vagrant/iot/p3/confs/argoCD/install.yml -n argocd
echo [+] ArgoCD deployment created successfully!

kubectl wait -n argocd --for=condition=Ready pods --all
echo [+] ArgoCD pods are ready!
kubectl apply -f /home/vagrant/iot/p3/confs/argoCD/ingress.yml -n argocd
echo [+] ArgoCD ingress created successfully!

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
echo [+] ArgoCD service created successfully!
sleep 0.2

# kubectl port-forward svc/argocd-server -n argocd 8080:443
echo 127.0.0.1 argocd.local >> /etc/hosts

echo "Changin default password..."
kubectl -n argocd patch secret argocd-secret \
-p '{"stringData": {
    "admin.password" : "$2b$12$gGm7jnNGfgadK0ZD03Ysheyrs1AZ/ETh/0T5rlcCiQAFLIryxGt3O",
    "admin.passwordMtime" : "'$(date +%FT%T%Z)'"
}}'
echo [+] Default password changed successfully!
sleep 0.2

echo "ArgoCD is ready to use!"

kubectl apply -f /home/vagrant/iot/p3/confs/argoCD/repo.yml -n argocd

# kubectl apply -f /home/vagrant/iot/p3/confs/dev/namespace.yml -n dev
# kubectl apply -f /home/vagrant/iot/p3/confs/dev/deployment.yml -n dev