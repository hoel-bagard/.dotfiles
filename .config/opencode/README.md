# OpenCode Configuration

See [the configuration docs](https://opencode.ai/docs/config) for explanations.

## Models

The configuration assumes access to GitHub Copilot, and makes use of Anthropic's Opus and Sonnet models.

If the above cannot be used, then the free Big Pickle model can be used instead.

## Agents

The agents in [agents](./agent/) have been created using the `opencode agent create` command, then manually improved.

There are 3 main agents:

- Tech Lead for programming tasks
- Japanese for Japanese checks and translation
- Research for quick questions

The Tech Lead further delegates tasks to these agents:

- architect-designer
- code-reviewer
- test-writer
- best-practices
- implementation-specialist
- requirements-clarifier
