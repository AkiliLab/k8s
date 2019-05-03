# k8s

Contains all kubernetes deployment configuration for database and services.

## Cassandra

A cloud native deployment of cassandra database using k8s dynamically using pd-ssd.

> https://developer.ibm.com/patterns/deploy-a-scalable-apache-cassandra-database-on-kubernetes/

```sh
$ kubectl apply -f cassandra-service.yaml
$ kubectl apply -f cassandra-storageclass.yaml
$ kubectl create -f cassandra-statefulset.yaml
```

> Delete pv

```sh
$ grace=$(kubectl get po cassandra-0 -o=jsonpath='{.spec.terminationGracePeriodSeconds}') \
  && kubectl delete statefulset -l app=cassandra \
  && echo "Sleeping $grace" \
  && sleep $grace \
  && kubectl delete pvc -l app=cassandra
OR $ kubectl delete statefulset,pvc,pv,svc -l app=cassandra
```
