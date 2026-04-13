#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025-2026 Kaptain contributors (Fred Cooke)
#
# pre-package-prepare hook for vendor-envoy-gateway
#
# Fixes upstream probe configuration (https://github.com/envoyproxy/gateway/issues/8719):
#   - Adds startupProbe so kubernetes waits for the container to be ready
#   - Removes initialDelaySeconds from liveness and readiness probes (startup probe handles this)
#
set -euo pipefail

DEPLOYMENT="${OUTPUT_SUB_PATH}/helm-processing/H-validated/deployment-envoy-gateway.yaml"

if [[ ! -f "${DEPLOYMENT}" ]]; then
  echo "ERROR: Deployment file not found: ${DEPLOYMENT}"
  exit 1
fi

echo "Adding startupProbe and removing initialDelaySeconds from probes..."

yq eval -i '
  .spec.template.spec.containers[0].startupProbe = {
    "httpGet": {"path": "/healthz", "port": 8081},
    "periodSeconds": 1,
    "failureThreshold": 30
  } |
  del(.spec.template.spec.containers[0].livenessProbe.initialDelaySeconds) |
  del(.spec.template.spec.containers[0].readinessProbe.initialDelaySeconds)
' "${DEPLOYMENT}"

echo "Probe configuration updated"
