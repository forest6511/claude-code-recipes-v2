---
name: python-style
description: Internal Python coding style for this repo
paths: "**/*.py, !**/migrations/**"
---

For all Python files:
- Use type hints on every public function
- Sort imports with isort (stdlib → third-party → local)
- Prefer `pathlib.Path` over `os.path`
