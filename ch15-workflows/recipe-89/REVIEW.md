# Review instructions

## What Important means here

Reserve Important for findings that would break behavior, leak data,
or block a rollback. Style and naming suggestions are Nit at most.

## Cap the nits

Report at most five Nits per review. If you found more, say "plus N
similar items" in the summary instead of posting them inline.

## Always check

- New API routes have an integration test
- Log lines do not include email addresses or user IDs
- Database queries are scoped to the caller's tenant
