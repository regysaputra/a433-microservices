#!/bin/sh
docker build -t item-app:v1 .
docker images
docker tag item-app:v1 ghcr.io/regysaputra/item-app:v1
echo "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" | docker login ghcr.io -u regysaputra --password-stdin
docker push ghcr.io/regysaputra/item-app:v1