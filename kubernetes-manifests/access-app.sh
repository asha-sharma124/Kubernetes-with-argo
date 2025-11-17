#!/bin/bash

echo "Starting port-forward to access PiggyMetrics..."
echo "The application will be available at: http://localhost:8080"
echo "Press Ctrl+C to stop"

kubectl port-forward svc/gateway 7070:80 -n piggymetrics &

kubectl port-forward -n argocd service/argocd-server 8443:443 &