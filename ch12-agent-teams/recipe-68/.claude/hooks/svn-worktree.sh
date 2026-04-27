#!/usr/bin/env bash
set -e

# 非 git VCS の場合、リポジトリディレクトリ配下に作る前提が崩れるため、
# Claude Code 標準の <repo>/.claude/worktrees/ ではなく、ユーザーホーム配下に作成する
input=$(cat)
name=$(echo "$input" | jq -r '.name')
dir="$HOME/.claude/worktrees/$name"

svn checkout https://svn.example.com/repo/trunk "$dir" >&2
echo "$dir"
