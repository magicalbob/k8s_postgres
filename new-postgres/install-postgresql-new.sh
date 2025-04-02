#!/usr/bin/env bash

# Create the namespace first
kubectl create namespace postgresql-new

# Then apply the PostgreSQL configuration
kubectl apply -f postgresql-new.yml

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

# Check that the StorageClass was created
kubectl get storageclass longhorn-postgres
