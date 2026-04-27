#!/usr/bin/env bash
# 使い方: merge-agents.sh agent1 agent2 ...
set -euo pipefail

dir="$(dirname "$0")/../agents.d"
files=()
for name in "$@"; do
  files+=("$dir/$name.json")
done

jq -s 'add' "${files[@]}"
