#!/bin/sh
docker build -t item-app:v1 .
docker images
docker tag item-app:v1 ghcr.io/regysaputra/item-app:v1
echo $PASSWORD_GITHUB_PACKAGES | docker login ghcr.io -u regysaputra --password-stdin
docker push ghcr.io/regysaputra/item-app:v1