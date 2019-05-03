# k8s

Contains all kubernetes deployment configuration for database and services.

## Cassandra

```sh
$ kubectl apply -f cassandra-service.yaml
$ kubectl apply -f cassandra-storageclass.yaml
$ kubectl create -f cassandra-statefulset.yaml
```

> Delete pv

```sh
grace=$(kubectl get po cassandra-0 -o=jsonpath='{.spec.terminationGracePeriodSeconds}') \
  && kubectl delete statefulset -l app=cassandra \
  && echo "Sleeping $grace" \
  && sleep $grace \
  && kubectl delete pvc -l app=cassandra
```
