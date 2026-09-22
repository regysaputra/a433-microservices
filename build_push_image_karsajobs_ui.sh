#!/usr/bin/env bash
# Stop on failed commands, unset variables, or failures within pipelines.
set -euo pipefail

# Usage: DOCKER_USERNAME=your-docker-username GITHUB_USERNAME=your-github-username \
#   bash build_push_image_karsajobs_ui.sh
# Provide a GitHub personal access token (classic) with write:packages when prompted.
# Require a Docker username for the local image name.
: "${DOCKER_USERNAME:?Set DOCKER_USERNAME to your Docker username}"

# Require a GitHub username for authentication and the package namespace.
: "${GITHUB_USERNAME:?Set GITHUB_USERNAME to your GitHub username}"

# Resolve the provided Dockerfile relative to this script.
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Set the requested local image name and latest tag.
local_image="${DOCKER_USERNAME}/karsajobs-ui:latest"

# Set the GitHub Container Registry image name with a lowercase namespace.
registry_image="ghcr.io/${GITHUB_USERNAME,,}/karsajobs-ui:latest"

# Build the local image using the provided Dockerfile and current directory.
docker build --file Dockerfile --tag "$local_image" .

# Add the registry tag required to publish the image to GitHub Packages.
docker tag "$local_image" "$registry_image"

# Accept an existing token or prompt without echoing it.
if [[ -z "${GITHUB_TOKEN:-}" ]]; then
    # Read the token without displaying the entered characters.
    read -r -s -p 'GitHub token: ' GITHUB_TOKEN
    # Move to a new line after the hidden token input.
    printf '\n'
fi

# Pass the token through standard input to log in to GitHub Container Registry.
printf '%s' "$GITHUB_TOKEN" | docker login ghcr.io \
    --username "$GITHUB_USERNAME" --password-stdin

# Remove the token variable from this shell after authentication.
unset GITHUB_TOKEN

# Push the tagged image to GitHub Packages.
docker push "$registry_image"