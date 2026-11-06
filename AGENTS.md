# Glowbom repository agent guide

This file applies to work anywhere in this repository. App-specific guidance in
`apps/AGENTS.md` and `apps/<app>/AGENTS.md` supplements it.

## Purpose

Glowbom is a collection of small apps and product resources. Keep changes
focused, understandable, and scoped to the requested task.

## Commits

Do not stage files or create commits unless the user explicitly requests it for
that specific change. By default, the user stages and commits changes manually.

Every build must end with exactly one conventional commit one-liner: a single
line in Conventional Commits format, such as `docs: clarify the public repo role`
or `feat(karaoke): add background controls`. Generate this one-liner every time
there is a build, even when no commit is created.

Keep the suggested commit scoped to files that belong to the requested change,
and preserve unrelated or pre-existing worktree changes.
