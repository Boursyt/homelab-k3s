# databases

In-cluster names for the two PostgreSQL instances on the NAS.

| File | Content |
|---|---|
| `service-postgres.yaml` | `postgres.databases.svc.cluster.local:5432`: private instance (through PgBouncer) |
| `endpointslice-postgres-nas.yaml` | points it to the NAS, port 5432 |
| `service-postgres-public.yaml` | `postgres-public.databases.svc.cluster.local:5432`: public instance, for public services only |
| `endpointslice-postgres-public-nas.yaml` | points it to the NAS, port 5433 |
