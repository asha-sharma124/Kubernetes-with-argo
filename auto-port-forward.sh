#!/bin/bash

# Auto-restart port-forward script
echo "Starting auto port-forward for gateway..."

while true; do
    echo "$(date): Starting port-forward to gateway service..."
    kubectl port-forward svc/gateway 7070:80 -n piggymetricss
    
    echo "$(date): Port-forward stopped, restarting in 3 seconds..."
    sleep 3
done