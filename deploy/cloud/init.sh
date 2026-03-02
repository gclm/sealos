#!/bin/bash
set -e

REGISTRY_DOMAIN="${REGISTRY_DOMAIN:-ghcr.io}"
REPOSITORY_OWNER="${REPOSITORY_OWNER:-labring}"
IMAGE_TAG="${IMAGE_TAG:-latest}"

image_ref() {
  echo "${REGISTRY_DOMAIN}/${REPOSITORY_OWNER}/$1:${IMAGE_TAG}"
}

declare -A images=(
  # controllers
  ["$(image_ref sealos-cloud-user-controller)"]="user.tar"
  ["$(image_ref sealos-cloud-terminal-controller)"]="terminal.tar"
  ["$(image_ref sealos-cloud-app-controller)"]="app.tar"
  ["$(image_ref sealos-cloud-resources-controller)"]="monitoring.tar"
  ["$(image_ref sealos-cloud-account-controller)"]="account.tar"
  ["$(image_ref sealos-cloud-license-controller)"]="license.tar"

  # frontends
  ["$(image_ref sealos-cloud-desktop-frontend)"]="frontend-desktop.tar"
  ["$(image_ref sealos-cloud-terminal-frontend)"]="frontend-terminal.tar"
  ["$(image_ref sealos-cloud-applaunchpad-frontend)"]="frontend-applaunchpad.tar"
  ["$(image_ref sealos-cloud-dbprovider-frontend)"]="frontend-dbprovider.tar"
  ["$(image_ref sealos-cloud-costcenter-frontend)"]="frontend-costcenter.tar"
  ["$(image_ref sealos-cloud-template-frontend)"]="frontend-template.tar"
  ["$(image_ref sealos-cloud-license-frontend)"]="frontend-license.tar"
  ["$(image_ref sealos-cloud-cronjob-frontend)"]="frontend-cronjob.tar"
  ["$(image_ref sealos-cloud-kubepanel-frontend)"]="frontend-kubepanel.tar"

  # services
  ["$(image_ref sealos-cloud-database-service)"]="database-service.tar"
  ["$(image_ref sealos-cloud-account-service)"]="account-service.tar"
  ["$(image_ref sealos-cloud-launchpad-service)"]="launchpad-service.tar"
  ["$(image_ref sealos-cloud-job-init-controller)"]="job-init.tar"
  ["$(image_ref sealos-cloud-job-heartbeat-controller)"]="job-heartbeat.tar"
)

mkdir -p images/shim

echo ""  > images/shim/allImage.txt

for img in "${!images[@]}"; do
  echo "=== Pulling $img ==="
  echo "$img" >> images/shim/allImage.txt
  while ! sealos registry save --registry-dir=registry --images="$img"; do
    echo "Failed to pull $img, retrying..."
    sleep 5
  done
done
