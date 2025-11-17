# PiggyMetrics Kubernetes Deployment

This directory contains Kubernetes manifests to deploy the PiggyMetrics microservices application.

## Prerequisites

- Kind cluster running
- kubectl configured to connect to your Kind cluster

## Quick Start

1. Make the deployment script executable:
   ```bash
   chmod +x deploy.sh cleanup.sh
   ```

2. Deploy the application:
   ```bash
   ./deploy.sh
   ```

3. Wait for all pods to be ready:
   ```bash
   kubectl get pods -n piggymetrics -w
   ```

4. Get the gateway service port:
   ```bash
   kubectl get svc gateway -n piggymetrics
   ```

5. Access the application in your browser:
   ```
   http://localhost:<NodePort>
   ```

## Services

- **Gateway**: Main entry point (NodePort service)
- **Config Service**: Centralized configuration
- **Registry**: Service discovery (Eureka)
- **Auth Service**: Authentication and authorization
- **Account Service**: Account management
- **Statistics Service**: Statistics and analytics
- **Notification Service**: Email notifications
- **Monitoring**: Application monitoring (NodePort service)
- **Turbine Stream**: Real-time monitoring streams
- **RabbitMQ**: Message broker
- **MongoDB**: Database (4 instances for different services)

## Monitoring

Access monitoring dashboard:
```bash
kubectl get svc monitoring -n piggymetrics
```
Then visit `http://localhost:<NodePort>` for the monitoring service.

## Troubleshooting

1. Check pod status:
   ```bash
   kubectl get pods -n piggymetrics
   ```

2. View logs:
   ```bash
   kubectl logs -f deployment/gateway -n piggymetrics
   ```

3. Describe problematic pods:
   ```bash
   kubectl describe pod <pod-name> -n piggymetrics
   ```

## Cleanup

To remove all resources:
```bash
./cleanup.sh
```

## Architecture

The application follows a microservices architecture with:
- API Gateway for routing
- Service Registry for discovery
- Config Server for centralized configuration
- Individual databases per service
- Message queue for async communication