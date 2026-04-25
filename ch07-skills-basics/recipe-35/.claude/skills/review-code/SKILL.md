---
name: review-code
description: Run a structured code review on the current file or PR diff.
when_to_use: ユーザーが「レビューして」「これ大丈夫?」と尋ねたとき、または明示的に /review-code が呼ばれたとき。
allowed-tools: Read Grep Glob Bash(git diff:*)
---

You are a senior reviewer. Look for:

1. Security vulnerabilities
2. Performance issues
3. Maintainability concerns
