.PHONY: create-cluster get-cluster-credential set-admin-permisions install-helm tiller deploy-services

TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

create-cluster:
	gcloud beta container clusters create akililab \
		--addons=HorizontalPodAutoscaling,HttpLoadBalancing,Istio \
		--machine-type=n1-standard-1 \
		--cluster-version=latest --zone=us-west1-a \
		--enable-stackdriver-kubernetes --enable-ip-alias \
		--enable-autoscaling --min-nodes=1 --max-nodes=10 \
		--enable-autorepair \
		--scopes cloud-platform \
		--project akililab-pay

get-cluster-credential:
	gcloud container clusters get-credentials akililab \
		--zone us-west1-c \
		--project akililab-pay

set-admin-permisions:
	kubectl create clusterrolebinding cluster-admin-binding \
		--clusterrole=cluster-admin \
		--user=$(gcloud config get-value core/account)

install-helm:
	helm init --history-max 200

tiller:
	# create service account for tiller
	kubectl --namespace kube-system create serviceaccount tiller
	# Bind role
	kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
	# Upgrade to current version
	helm init --service-account tiller --upgrade
deploy-consul:
	# WIP

deploy-ambassador:
	kubectl apply -f https://www.getambassador.io/yaml/ambassador/ambassador-rbac.yaml
	kubectl apply -f ambassador-service.yaml

consul-apigateway-mapping:
	kubectl apply -f apigateway-consul.yaml

deploy-services:
	helm upgrade --install apigateway ./helm/apigateway --namespace service
	helm upgrade --install balance ./helm/balance --namespace service
	# Comment for now as the transcation is not build yet.
	# helm upgrade --install transaction ./transaction --namespace transaction 