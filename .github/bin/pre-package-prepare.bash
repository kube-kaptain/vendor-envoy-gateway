#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025-2026 Kaptain contributors (Fred Cooke)
#
# pre-package-prepare hook for vendor-envoy-gateway
#
# Composes multiple prepare steps into the single entrypoint that
# KaptainPM.yaml's prePackagePrepare field expects.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"${SCRIPT_DIR}/fix-upstream-probes.bash"
"${SCRIPT_DIR}/inject-kubernetes-static.bash"
