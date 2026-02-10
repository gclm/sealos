#!/bin/bash
set -e
readonly ARCH=${1:-amd64}
mkdir -p charts tars

RetryPullImageInterval=3
RetryPullFileInterval=3
RetrySleepSeconds=3

retryPullFile() {
  local file=$1
  local output=$2
  local retry=0
  local retryMax=3
  set +e
      while [ $retry -lt $RetryPullFileInterval ]; do
          curl -L "$file" --create-dirs -o "$output" >/dev/null && break
          retry=$(($retry + 1))
          echo "retry pull file $file, retry times: $retry"
          sleep $RetrySleepSeconds
      done
      set -e
      if [ $retry -eq $retryMax ]; then
          echo "pull file $file failed"
          exit 1
      fi
}

retryPullImage() {
    local image=$1
    local retry=0
    local retryMax=3
    set +e
    while [ $retry -lt $RetryPullImageInterval ]; do
        sealos pull --policy=always --platform=linux/"${ARCH}" $image >/dev/null && break
        retry=$(($retry + 1))
        echo "retry pull image $image, retry times: $retry"
        sleep $RetrySleepSeconds
    done
    set -e
    if [ $retry -eq $retryMax ]; then
        echo "pull image $image failed"
        exit 1
    fi
}

# Download MinIO Operator Helm chart
OPERATOR_VERSION="5.0.6"
OPERATOR_URL="https://raw.githubusercontent.com/minio/operator/master/helm-releases/operator-${OPERATOR_VERSION}.tgz"
if [ ! -f "charts/operator-${OPERATOR_VERSION}.tgz" ]; then
  echo "Downloading MinIO Operator Helm chart..."
  retryPullFile "${OPERATOR_URL}" "charts/operator-${OPERATOR_VERSION}.tgz"
fi

retryPullImage ghcr.io/gclm/sealos-cloud-objectstorage-controller:latest
retryPullImage ghcr.io/gclm/sealos-cloud-objectstorage-frontend:latest
retryPullImage ghcr.io/gclm/sealos-cloud-minio-service:latest
retryPullFile https://dl.min.io/client/mc/release/linux-amd64/mc ./etc/minio-binaries/mc

sealos save -o tars/objectstorage-controller.tar ghcr.io/gclm/sealos-cloud-objectstorage-controller:latest
sealos save -o tars/objectstorage-frontend.tar ghcr.io/gclm/sealos-cloud-objectstorage-frontend:latest
sealos save -o tars/objectstorage-service.tar ghcr.io/gclm/sealos-cloud-minio-service:latest
