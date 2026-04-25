---
name: deploy
description: Deploy the application to production
disable-model-invocation: true
context: fork
---

Deploy procedure:

1. Run the test suite (`npm test`)
2. Build the application (`npm run build`)
3. Push to the deployment target (`flyctl deploy`)
