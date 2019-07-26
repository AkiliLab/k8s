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

firewall-setup:
	# allow internal communication for all protocols
	gcloud compute firewall-rules create akililabs-allow-internal \
		--allow tcp,udp,icmp \
		--network akililabs \
		--source-ranges 10.240.0.1/24,10.200.0.1/16
	# firewall rule that allows external SSH, ICMP, and HTTPS:
	gcloud compute firewall-rules create akililabs-allow-external \
		--allow tcp:22,tcp:6443,icmp \
		--network akililabs \
		--source-ranges 0.0.0.0/0

create-public-ip:
	gcloud compute addresses create akililabs \
  		--region $(gcloud config get-value compute/region)