#!/usr/bin/env bash

# Install Longhorn using Helm
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace

# Wait for Longhorn to be ready
kubectl -n longhorn-system rollout status deployment/longhorn-ui
kubectl -n longhorn-system rollout status deployment/longhorn-driver-deployer

# Create a StorageClass for PostgreSQL with high performance settings
cat <<EOF | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: longhorn-postgres
provisioner: driver.longhorn.io
allowVolumeExpansion: true
parameters:
  numberOfReplicas: "3"
  staleReplicaTimeout: "30"
  fromBackup: ""
  fsType: "ext4"
EOF
