# Working with Apps

This file applies to everything inside `apps/`.

## Purpose

Apps are small tools first built for our own work and shared when they may help other people. Keep each app focused, understandable, and usable without the rest of the repository.

## Default stack

- Use React, TypeScript, and Vite for new app interfaces.
- Add Tauri when an app benefits from desktop packaging, local files, native dialogs, offline use, or full-screen presentation.
- Use a different stack only when the product clearly needs it, such as Godot for a game, SwiftUI for an Apple-only app, Jetpack Compose for an Android-only app, or Flutter for a mobile-first cross-platform app.
- Do not rewrite a working app only to standardize its stack.

## Before making changes

1. Read the app's `README.md` and `package.json`.
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

For JavaScript apps, use the commands defined by that app. The common workflow is:

```bash
npm install
npm test
npm run build
```

Use `npm run dev` for browser testing. If the app uses Tauri, use `npm run tauri dev` for desktop testing when the required Rust and platform tools are available.

Report any check that could not be run and explain why.

## Documentation

Every app should have a README that explains:

- what the app does;
- how to use it;
- how to run, test, and build it;
- which technologies it uses;
- how local projects or data are stored;
- where the important source files live.

## Commits

Do not stage files or create commits unless the user explicitly requests it for that specific change. By default, the user stages and commits changes manually.

After completing and verifying a requested change, provide a focused commit message using the Conventional Commits format, such as `feat(karaoke): add background controls` or `docs(apps): clarify setup instructions`.

Keep the suggested commit scoped to files that belong to the requested change, and preserve unrelated or pre-existing worktree changes.
