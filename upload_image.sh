#!/bin/bash

# Define variables
# Replace <GITHUB_USERNAME> with your actual GitHub username or organization name
GH_USER="regysaputra"
IMAGE_NAME="shipping-service"
TAG="latest"
REGISTRY="ghcr.io"

# Build the Docker image for shipping-service
# -t sets the name and tag for the image
docker build -t $IMAGE_NAME .

# Tag the image for GitHub Packages (GHCR)
# This creates an alias of the image with the registry-specific path
docker tag $IMAGE_NAME $REGISTRY/$GH_USER/$IMAGE_NAME:$TAG

# Push the image to GitHub Packages
# Ensure you are logged in to GHCR before running this script:
# echo $GITHUB_TOKEN | docker login ghcr.io -u $GH_USER --password-stdin
docker push $REGISTRY/$GH_USER/$IMAGE_NAME:$TAG
