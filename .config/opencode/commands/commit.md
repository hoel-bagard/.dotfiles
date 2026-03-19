---
description: Commit changes
subtask: true
model: github-copilot/claude-sonnet-4.6
---

Stage the changes and create a commit:

!`git status`

!`git diff`

Write a clear, conventional commit message that:

- Starts with a type (feat, fix, refactor, docs, test, chore)
- Has a concise subject line (50 chars max)
- Optionally includes a body explaining WHY the change was made

Then create the commit. Make sure to always use GPG signing, if an error occurs and you cannot sign the commit, stop and inform the user.
