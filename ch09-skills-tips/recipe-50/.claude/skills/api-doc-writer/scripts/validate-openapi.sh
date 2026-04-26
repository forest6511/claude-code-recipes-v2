#!/usr/bin/env bash
# OpenAPI スキーマを redocly でバリデーションする
# 使い方: validate-openapi.sh <openapi.yaml>

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <openapi.yaml>" >&2
  exit 1
fi

SPEC="$1"

if ! command -v npx >/dev/null 2>&1; then
  echo "npx not found" >&2
  exit 1
fi

npx --yes @redocly/cli@latest lint "$SPEC"
