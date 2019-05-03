# k8s

Contains all kubernetes deployment configuration for database and services.

## Cassandra

```sh
$ kubectl apply -f cassandra-service.yaml
$ kubectl apply -f local-volumes.yaml
$ kubectl create -f cassandra-statefulset.yaml
```
