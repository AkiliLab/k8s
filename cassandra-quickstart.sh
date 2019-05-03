#!/bin/bash
kubectl apply -f cassandra-service.yaml
kubectl apply -f cassandra-storageclass.yaml
kubectl apply -f cassandra-statefulset.yaml
kubectl get nodes
kubectl get svc cassandra