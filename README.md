# Vendor Envoy Gateway

Vendored Envoy Gateway helm chart rendered to plain kubernetes manifests using
the `kubernetes-app-vendor-helm-rendered` build type.

The helm chart is fetched from `oci://docker.io/envoyproxy/gateway-helm` at build
time, rendered via `helm template`, and processed through the standard pipeline
(split, map, transform, label, validate). The output is committed plain manifests
in `src/kubernetes/` with no helm runtime dependency.


## Upstream

- Project: https://gateway.envoyproxy.io/
- Chart: `oci://docker.io/envoyproxy/gateway-helm`
- Version tracked in: `src/config/VendorHelmRenderedVersion`


## Versioning

Upstream chart version (e.g. `v1.3.0`) stored in `src/config/VendorHelmRenderedVersion`.
Our packaging version appends an increment: `1.3.0.1`, `1.3.0.2`, etc.


## Structure

- `src/config/VendorHelmRenderedVersion` - upstream chart version
- `src/vendor-helm-rendered/values-*.yaml` - version-specific helm values overrides
- `src/vendor-helm-rendered/transforms-global/` - yq transforms applied to all files
- `src/vendor-helm-rendered/transforms/` - per-file yq transforms
- `src/kubernetes/` - final committed output (plain manifests)
