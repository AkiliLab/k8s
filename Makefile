.PHONY: select-compute-region set-resources networking

TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

select-compute-region:
	gcloud config set compute/region us-west1
	gcloud config set compute/zone us-west1-a

networking:
	gcloud compute networks create akililabs --subnet-mode custom
	gcloud compute networks subnets create kubernetes \
		  --network akililabs \
		  --range 10.240.0.1/24