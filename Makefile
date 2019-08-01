.PHONY: create-cluster get-cluster-credential set-admin-permisions install-helm tiller service-namespace deploy-services

TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

create-cluster:
	gcloud container clusters create akililab \
		--cluster-version latest \
		--zone us-west1-c \
		--num-nodes 4 \
		--enable-autoscaling \
		--min-nodes 1 \
		--max-nodes 4 \
		--node-locations us-west1-c,us-central1-a,us-central1-b,us-central1-f \
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

service-namespace:
	kubectl create ns service
	kubectl label ns service istio-injection=enabled

deploy-services:
	helm upgrade --install apigateway ./helm/apigateway --namespace service
	helm upgrade --install balance ./helm/balance --namespace service
	# Comment for now as the transcation is not build yet.
	# helm upgrade --install transaction ./transaction --namespace transaction 