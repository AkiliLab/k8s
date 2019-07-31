.PHONY: deploy-services

TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

deploy-services:
	helm upgrade --install apigateway ./apigateway --namespace apigateway
	helm upgrade --install balance ./balance --namespace balance
	# Comment for now as the transcation is not build yet.
	# helm upgrade --install transaction ./transaction --namespace transaction 