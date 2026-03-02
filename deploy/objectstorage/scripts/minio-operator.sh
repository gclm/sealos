#!/usr/bin/env bash
set -e

function install_minio_operator() {
  OPERATOR_VERSION="5.0.6"
  OPERATOR_CHART="charts/operator-${OPERATOR_VERSION}.tgz"

  echo "Installing MinIO Operator..."

  # Check if chart exists
  if [ ! -f "${OPERATOR_CHART}" ]; then
    echo "Error: MinIO Operator Helm chart not found at ${OPERATOR_CHART}"
    echo "Please ensure the chart is included in the cluster image."
    exit 1
  fi

  # Check if operator already installed
  if kubectl get namespace minio-system >/dev/null 2>&1; then
    echo "MinIO Operator namespace already exists, checking deployment..."
    if kubectl get deployment minio-operator -n minio-system >/dev/null 2>&1; then
      echo "MinIO Operator already installed, skipping..."
      return 0
    fi
  fi

  # Install Operator
  echo "Installing MinIO Operator from local chart: ${OPERATOR_CHART}"
  helm install --namespace minio-system --create-namespace minio-operator "${OPERATOR_CHART}"

  # Wait for Operator to be ready
  echo "Waiting for MinIO Operator to be ready..."
  kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=operator -n minio-system --timeout=300s

  echo "MinIO Operator installed successfully."
}

install_minio_operator
