#!/bin/bash

# Set the desired providers
export PROVIDER={all,google,aws,kubernetes}

# Download Terraformer
curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.21/terraformer-all-darwin-amd64

# Change the execution flag for the desired providers
chmod +x terraformer-all-darwin-amd64

# Copy the providers to the /usr/local/bin folder
mkdir -p /usr/local/bin/terraformer
sudo mv terraformer-all-darwin-amd64 /usr/local/bin/terraformer/terraformer-all-darwin-amd64

####### Test

# import k8s namepaces
terraformer import kubernetes --resources=namespaces