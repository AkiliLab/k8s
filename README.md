# k8s

Contains all kubernetes deployment configuration for database and services.

## Prerequisites
- Have Helm client and tiller configured in your cluster. Refer [here](https://docs.helm.sh/using_helm/#installing-helm)
- You need to have a Kubernetes cluster up and running.

## Istio Installation
1. Download [istio](https://istio.io/docs/setup/kubernetes/#downloading-the-release)
2. [Install](https://istio.io/docs/setup/kubernetes/install/helm/#option-1-install-with-helm-via-helm-template) Istio to your k8s clusters
3. Enable Istion Injection
    ```sh
    $ make service-namespace
    ```
## Deploy Micro-service services

Create services for all microservices `balance`, `transactions` and `apigateway`

```sh
$ make deploy-services
```
