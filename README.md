# k8s

Contains all kubernetes deployment configuration for database and services.

## Micro-service services

Create services for all microservices `balance`, `transactions` and `api-gateway`

```sh
$ kubectl apply -f srv-services.yaml
$ kubectl apply -f gateway-services.yaml
```
