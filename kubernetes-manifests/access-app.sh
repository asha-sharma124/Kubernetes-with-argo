#!/bin/bash



kubectl port-forward svc/gateway 7070:80 -n piggymetrics &

kubectl port-forward -n argocd service/argocd-server 8443:443 &

kubectl port-forward svc/argo-server -n argo 2746:2746 &