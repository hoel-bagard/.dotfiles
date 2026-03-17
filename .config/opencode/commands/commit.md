---
description: Create a commit with a descriptive message
agent: commit
model: github-copilot/claude-sonnet-4.6
---

Review the staged changes and create a commit:

!`git status`

!`git diff --cached`

Write a clear, conventional commit message that:

- Starts with a type (feat, fix, refactor, docs, test, chore)
- Has a concise subject line (50 chars max)
- Optionally includes a body explaining WHY the change was made

Then create the commit.
