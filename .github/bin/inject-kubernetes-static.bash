#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025-2026 Kaptain contributors (Fred Cooke)
#
# pre-package-prepare hook helper for vendor-envoy-gateway
#
# Copies human-authored manifests from src/kubernetes-static/ into the helm
# processing H-validated/ output dir so they end up in src/kubernetes/
# alongside the rendered helm output after vendor-helm-render-validate.
set -euo pipefail

STATIC_DIR="src/kubernetes-static"
TARGET_DIR="${OUTPUT_SUB_PATH}/helm-processing/H-validated"

if [[ ! -d "${STATIC_DIR}" ]]; then
  echo "No static manifests dir at ${STATIC_DIR}, skipping"
  exit 0
fi

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "ERROR: Target dir not found: ${TARGET_DIR}"
  exit 1
fi

shopt -s nullglob
FILES=("${STATIC_DIR}"/*.yaml)
if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No .yaml files in ${STATIC_DIR}, skipping"
  exit 0
fi

echo "Copying ${#FILES[@]} static manifest(s) from ${STATIC_DIR} to ${TARGET_DIR}:"
for file in "${FILES[@]}"; do
  echo "  $(basename "${file}")"
  cp "${file}" "${TARGET_DIR}/"
done
