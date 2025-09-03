#!/bin/bash
set -e
export readonly ARCH=${1:-amd64}
mkdir -p tars

RetryPullImageInterval=1000
RetrySleepSeconds=15

retryPullImage() {
    local image=$1
    local retry=0
    set +e
    while [ $retry -lt $RetryPullImageInterval ]; do
        sealos pull --policy=always --platform=linux/"${ARCH}" $image >/dev/null && break
        retry=$(($retry + 1))
        echo "retry pull image $image, retry times: $retry"
        sleep $RetrySleepSeconds
    done
    set -e
}

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

mkdir -p tars

for img in "${!images[@]}"; do
  echo "=== Pulling $img ==="
  retryPullImage "$img"

  tar_name=${images[$img]}
  echo "=== Saving $img to tars/$tar_name ==="
  sealos save -o "tars/$tar_name" "$img"
done
