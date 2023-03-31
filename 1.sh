#!/bin/bash
gcloud auth revoke --all

while [[ -z "$(gcloud config get-value core/account)" ]]; 
do echo "waiting login" && sleep 2; 
done

while [[ -z "$(gcloud config get-value project)" ]]; 
do echo "waiting project" && sleep 2; 
done

PROJECT_ID=$(gcloud config list project --format "value(core.project)")

sed -i "s/PROJECT_ID/$PROJECT_ID/g" instance.tf

gcloud auth application-default login

rm terraform.tfstate
rm -r .terraform/
terraform init
terraform apply -auto-approve

sed -i "s/$PROJECT_ID/PROJECT_ID/g" instance.tf
