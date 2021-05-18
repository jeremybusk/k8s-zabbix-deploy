# Troubleshooting.

## Slowness
- high %iowait

https://access.crunchydata.com/documentation/postgres-operator/latest/quickstart/


https://access.crunchydata.com/documentation/postgres-operator/latest/

https://access.crunchydata.com/documentation/postgres-operator/4.6.2/architecture/high-availability/

https://www.crunchydata.com/developers/download-postgres/containers/postgres-operator



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

```
pgo create cluster hacluster --replica-count=2 --pod-anti-affinity=preferred --pgbouncer
```
