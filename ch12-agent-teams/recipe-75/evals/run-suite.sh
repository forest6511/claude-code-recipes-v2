#!/usr/bin/env bash
set -euo pipefail
SUITE="${1:-regression}"
K="${K:-3}"
for task_yaml in evals/suites/$SUITE/*.yaml; do
  task_id=$(basename "$task_yaml" .yaml)
  for i in $(seq 1 "$K"); do
    bash evals/run-trial.sh "$task_id"
  done
  python3 evals/aggregate.py "$task_id"
done
