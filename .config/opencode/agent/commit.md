---
description: Stage and commit changes
mode: subagent
model: github-copilot/claude-sonnet-4.6
temperature: 0.1
permission:
  "*": ask
  edit: deny
  read: allow
  bash:
    "*": ask
    "git add *": allow
    "git commit *": allow
    "git diff *": allow
    "git log *": allow
    "git status": allow
    "grep *": allow
    "ls *": allow
    "cat *": allow
---

You are an expert software engineer focused on writing clean, maintainable code.
