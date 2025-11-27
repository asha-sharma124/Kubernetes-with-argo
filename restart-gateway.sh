#!/bin/bash

# Kill any process using port 7070
sudo fuser -k 7070/tcp 2>/dev/null

# Wait a moment
sleep 2

# Start new port-forward
kubectl port-forward svc/gateway 7070:80 -n piggymetricss