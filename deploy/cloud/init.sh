#!/bin/bash
set -e

declare -A images=(
  # controllers
  ["ghcr.io/gclm/sealos-cloud-user-controller:latest"]="user.tar"
  ["ghcr.io/gclm/sealos-cloud-terminal-controller:latest"]="terminal.tar"
  ["ghcr.io/gclm/sealos-cloud-app-controller:latest"]="app.tar"
  ["ghcr.io/gclm/sealos-cloud-resources-controller:latest"]="monitoring.tar"
  ["ghcr.io/gclm/sealos-cloud-account-controller:latest"]="account.tar"
  ["ghcr.io/gclm/sealos-cloud-license-controller:latest"]="license.tar"

  # frontends
  ["ghcr.io/gclm/sealos-cloud-desktop-frontend:latest"]="frontend-desktop.tar"
  ["ghcr.io/gclm/sealos-cloud-terminal-frontend:latest"]="frontend-terminal.tar"
  ["ghcr.io/gclm/sealos-cloud-applaunchpad-frontend:latest"]="frontend-applaunchpad.tar"
  ["ghcr.io/gclm/sealos-cloud-dbprovider-frontend:latest"]="frontend-dbprovider.tar"
  ["ghcr.io/gclm/sealos-cloud-costcenter-frontend:latest"]="frontend-costcenter.tar"
  ["ghcr.io/gclm/sealos-cloud-template-frontend:latest"]="frontend-template.tar"
  ["ghcr.io/gclm/sealos-cloud-license-frontend:latest"]="frontend-license.tar"
  ["ghcr.io/gclm/sealos-cloud-cronjob-frontend:latest"]="frontend-cronjob.tar"

  # services
  ["ghcr.io/gclm/sealos-cloud-database-service:latest"]="database-service.tar"
  ["ghcr.io/gclm/sealos-cloud-account-service:latest"]="account-service.tar"
  ["ghcr.io/gclm/sealos-cloud-launchpad-service:latest"]="launchpad-service.tar"
  ["ghcr.io/gclm/sealos-cloud-job-init-controller:latest"]="job-init.tar"
  ["ghcr.io/gclm/sealos-cloud-job-heartbeat-controller:latest"]="job-heartbeat.tar"
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