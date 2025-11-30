# Service Startup Timing Configuration

## Current Configuration (6-minute startup)

All application services now configured for 6-minute startup time:

### Readiness Probe
- **initialDelaySeconds: 360** (6 minutes - waits before first check)
- **periodSeconds: 10** (checks every 10 seconds)
- **failureThreshold: 6** (allows 1 more minute of failures)
- **Total wait time: 7 minutes max**

### Liveness Probe  
- **initialDelaySeconds: 420** (7 minutes - prevents restart during startup)
- **periodSeconds: 30** (checks every 30 seconds after)
- **failureThreshold: 3** (allows 90 seconds of failures)

## What This Means

✅ Pods will NOT be marked as ready until 6 minutes have passed
✅ Kubernetes will NOT restart pods during the first 7 minutes
✅ ArgoCD will show "Progressing" for 6 minutes, then "Healthy"
✅ No more premature restarts

## Apply Changes

```bash
cd /home/auriga/kubernetes/piggymetrics
git add kubernetes-manifests/
git commit -m "Configure probes for 6-minute startup time"
git push origin main
```

Then sync in ArgoCD UI.

## Services Updated
- auth-service
- account-service  
- statistics-service
- notification-service
- gateway
