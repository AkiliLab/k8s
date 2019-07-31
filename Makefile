.PHONY: create-cluster get-cluster-credential set-admin-permisions install-helm apigateway-namespace deploy-services

TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

create-cluster:
	gcloud container clusters create akililab \
		--cluster-version latest \
		--num-nodes 4 \
		--zone us-west1-c \
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
	# create service account for tiller
	kubectl --namespace kube-system create serviceaccount tiller
	# Bind role
	kubectl create clusterrolebinding tiller-cluster-rule \
 		--clusterrole=cluster-admin --serviceaccount=kube-system:tiller

apigateway-namespace:
	kubectl create ns apigateway
	kubectl label ns apigateway istio-injection=enabled

deploy-services:
	helm upgrade --install apigateway ./helm/apigateway --namespace apigateway
	helm upgrade --install balance ./helm/balance --namespace balance
	# Comment for now as the transcation is not build yet.
	# helm upgrade --install transaction ./transaction --namespace transaction 