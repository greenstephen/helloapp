#!/usr/bin/env bash
# Run the AppCore test suite in the official Swift container - reproducible,
# needs no local toolchain. Use if the native toolchain is broken or missing.
set -euo pipefail
cd "$(dirname "$0")/.."
IMAGE="${SWIFT_IMAGE:-swift:6.3.3-noble}"
exec docker run --rm \
  -v "$(pwd)":/work \
  -v appcore-build:/work/Packages/AppCore/.build \
  -w /work/Packages/AppCore \
  "$IMAGE" swift test "$@"
