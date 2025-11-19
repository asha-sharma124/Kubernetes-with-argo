#!/bin/bash

echo "Cleaning up previous deployment..."
kubectl delete namespace piggymetrics --ignore-not-found=true
sleep 15

echo "Deploying PiggyMetrics to Kubernetes..."

# Deploy infrastructure
kubectl apply -f 01-namespace.yaml
kubectl apply -f 02-configmap.yaml
kubectl apply -f 03-mongodb-statefulsets.yaml
kubectl apply -f 04-mongodb-services.yaml
kubectl apply -f 05-rabbitmq.yaml

echo "Waiting for MongoDB instances to be ready..."
kubectl wait --for=condition=ready pod -l app=auth-mongodb -n piggymetrics --timeout=300s
kubectl wait --for=condition=ready pod -l app=account-mongodb -n piggymetrics --timeout=300s
kubectl wait --for=condition=ready pod -l app=statistics-mongodb -n piggymetrics --timeout=300s
kubectl wait --for=condition=ready pod -l app=notification-mongodb -n piggymetrics --timeout=300s

echo "Deploying config service..."
kubectl apply -f 06-config-service.yaml

echo "Waiting for config service to be ready..."
kubectl wait --for=condition=available deployment/config-service -n piggymetrics --timeout=300s

# Wait for config service to be actually serving requests
echo "Waiting for config service to serve requests..."
sleep 30

echo "Deploying registry..."
kubectl apply -f 07-registry.yaml

echo "Waiting for registry to be ready..."
kubectl wait --for=condition=available deployment/registry-service -n piggymetrics --timeout=300s

# Wait for registry to be ready
sleep 60

echo "Deploying microservices..."
kubectl apply -f 08-auth-service.yaml
echo "Waiting for auth service to be ready..."
kubectl wait --for=condition=ready pod -l app=auth-service -n piggymetrics --timeout=300s

kubectl apply -f 09-account-service.yaml
echo "Waiting for account service to be ready..."
kubectl wait --for=condition=ready pod -l app=account-service -n piggymetrics --timeout=300s
kubectl apply -f 10-statistics-service.yaml
kubectl apply -f 11-notification-service.yaml

echo "Waiting for microservices to start..."
sleep 90s

echo "Deploying gateway and monitoring..."
kubectl apply -f 12-gateway.yaml

kubectl apply -f 13-monitoring.yaml
kubectl apply -f 14-turbine-stream.yaml

echo "Deployment complete!"
echo ""
echo "Check status:"
echo "kubectl get pods -n piggymetrics"
echo ""
echo "Get gateway port:"
echo "kubectl get svc gateway -n piggymetrics"