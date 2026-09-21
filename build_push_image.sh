#!/usr/bin/env bash
set -euo pipefail

# Usage: GITHUB_USERNAME=your-username bash build_push_image.sh
: "${GITHUB_USERNAME:?Set GITHUB_USERNAME to your GitHub username}"
IMAGE="ghcr.io/${GITHUB_USERNAME,,}/item-app:v1"

# Use the Dockerfile and build context next to this script.
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

# 1. Build the image.
docker build -t item-app:v1 .

# 2. List local images.
docker images

# 3. Tag the image for GitHub Packages (GitHub Container Registry).
docker tag item-app:v1 "$IMAGE"

# 4. Log in to GitHub Container Registry (ghcr.io)
docker login ghcr.io --username "$GITHUB_USERNAME"

# 5. Push the image to GitHub Packages.
docker push "$IMAGE"
