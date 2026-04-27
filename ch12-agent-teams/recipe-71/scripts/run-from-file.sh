#!/usr/bin/env bash
set -euo pipefail

claude --agents "$(cat agents-config.json)" -p "doc-extractor で src/api 配下のドキュメントを抽出してください。"
