#!/bin/bash

PROJECT_ID=$(gcloud config list project --format "value(core.project)")

sed -i "s/PROJECT_ID/$PROJECT_ID/g" instance.tf

terraform init
terraform apply -auto-approve
