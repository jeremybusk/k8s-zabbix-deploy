# Troubleshooting.

## Slowness
- high %iowait

Expose api
````
microk8s.kubectl port-forward -n pgo svc/postgres-operator 8443:8443
```

Run some commands
```
pgo create cluster hippo
pgo show cluster -n pgo --all
pgo show user hippo --show-system-accounts
```
