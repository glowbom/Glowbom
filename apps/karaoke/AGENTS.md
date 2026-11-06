# Karaoke agent guide

This file applies to work inside `apps/karaoke/`. It supplements `apps/AGENTS.md`.

## Purpose

Karaoke is a small React, TypeScript, and Vite app with an optional Tauri desktop
wrapper. Keep it focused, understandable, and usable without the rest of the
repository.

## Before making changes

1. Read `README.md`, `PROJECT.md`, and `package.json`.
2. Inspect the relevant source and tests before editing.
3. Preserve project-file and export formats unless the task explicitly changes them.
4. Keep user files local unless the app clearly documents an external service.

## Implementation rules

- Prefer small, typed components and descriptive names.
- Keep application logic separate from presentation when practical.
- Reuse existing patterns and dependencies before adding new ones.
- Add or update tests when behavior changes.
- Keep instructions understandable for people without specialist knowledge.
- Avoid unrelated rewrites.

## Verification

```bash
npm install
npm test
npm run build
```

Use `npm run dev` for browser testing and `npm run tauri dev` for desktop testing
when the required Rust and platform tools are available. Report any check that
could not be run and explain why.

## Commits

Every build must end with exactly one conventional commit one-liner: a single
line in Conventional Commits format, such as `feat(karaoke): add background
controls` or `docs(karaoke): explain the project`. Generate this one-liner every
time there is a build, even when no commit is created.

Do not stage files or create commits unless the user explicitly requests it for
that specific change. By default, the user stages and commits changes manually.