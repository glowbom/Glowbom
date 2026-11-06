# Karaoke project guide

This document explains what the Karaoke app is, how it is built, and where its
important code lives. It is meant for contributors, reviewers, and anyone who
wants to understand or extend the project without specialist music software
knowledge.

## What the app does

Karaoke turns any song into a simple karaoke experience. A user:

1. **Adds audio.** The normal song with vocals is required; an instrumental
   version is optional and is used for the final sing-along.
2. **Adds lyrics.** Lyrics are pasted one line per row. Optional Latin and
   Cyrillic pronunciation guides and translations can be added row by row.
   Existing LRC, SRT, or TTML files can be opened instead of pasting.
3. **Sets the timing.** The song plays while the user holds the Space bar when a
   lyric line begins and releases it when the line ends. The app advances to the
   next line automatically. Mistakes can be undone.
4. **Sings.** The player shows the active line, optional pronunciation guides and
   translations, supports guide vocals or instrumental, speed changes, background
   switching, and full screen.

Finished lyrics can be downloaded as LRC, SRT, or TTML files. Work can be saved
as a single `.karaoke` project file and reopened later.

## Technology

- React 19, TypeScript, and Vite for the web interface.
- Tauri 2 for optional desktop packaging and native file dialogs.
- Vitest and Testing Library for tests.
- Lucide React for icons.

The app runs in a browser by default and gains native file dialogs when wrapped
by Tauri.

## Screens and workflow

The application is a small state machine in `src/App.tsx`. Screens are:

- `home` - create a new karaoke or open a saved project.
- `setup` - enter title and artist, add audio, paste lyrics and optional
  pronunciation/translation guides, choose a background, import timed lyrics.
- `timing` - play the song and tap each lyric line with the Space bar.
- `player` - sing along, export files, save or open projects.

State is held in `App` and passed down to screen components. There is no external
state library.

## Important source files

| File | Purpose |
| --- | --- |
| `src/App.tsx` | Screens, workflow, and application state. |
| `src/components.tsx` | Reusable buttons, file pickers, audio transport, lyric stage, player. |
| `src/types.ts` | Shared TypeScript types for cues, assets, and projects. |
| `src/lib/lyrics.ts` | LRC, SRT, and TTML import/export and lyric support text handling. |
| `src/lib/project.ts` | Project serialization, parsing, and browser downloads. |
| `src/lib/desktop.ts` | Tauri detection and native file/fullscreen helpers. |
| `src/lib/player.ts` | Player helper logic, including opening title timing. |
| `src/lib/clipboard.ts` | Rich-text clipboard normalization that preserves stanza breaks. |
| `src/styles.css` | Visual design. |
| `src-tauri/` | Desktop app wrapper and Tauri configuration. |

## Data model

A project is a `KaraokeProject` (see `src/types.ts`):

- `format` is always `"karaoke-project"` and `version` is `1`.
- Song metadata: `title`, `artist`.
- Text: `lyrics`, plus optional `latinPronunciations`, `cyrillicPronunciations`,
  and `translations`.
- `cues`: an array of `KaraokeCue` objects, each with `id`, `text`, optional
  pronunciation/translation fields, and `startMs`/`endMs` timings in milliseconds.
- Media stored inline: `vocalAudio` (required), `instrumentalAudio` (optional),
  and `backgroundImage` (optional). Each is a `ProjectAsset` with `name`,
  `mimeType`, and `dataUrl`.
- `backgroundMode`: `"photo"`, `"stage"`, or `"gray"`.
- `createdAt` and `updatedAt` ISO timestamps.

Because audio and images are embedded as data URLs, project files can be large.

## Supported lyric formats

`src/lib/lyrics.ts` handles:

- **LRC** - timestamped lines such as `[00:01.20]First line`.
- **SRT** - numbered blocks with `start --> end` ranges.
- **TTML** - XML with `begin`, `end`, or `dur` attributes.

Imported timing is preserved when pronunciation guides or translations are added
or edited. Exports only include the standard lyric text and timing; optional
guides and translations stay inside the project file.

## Saving and loading

- `serializeProject` writes pretty-printed JSON.
- `parseProject` validates the format, version, title, vocal audio, and cues.
- In the browser, files are downloaded and opened through hidden file inputs.
- Under Tauri, `src/lib/desktop.ts` uses native save/open dialogs and the
  filesystem plugin.

The project extension is `.karaoke`.

## Privacy and storage

All audio, images, lyrics, and timing stay on the user's computer. The app does
not upload files to a service. Users are responsible for only sharing audio they
have permission to share.

## Development

Prerequisites: Node.js 20 or newer. For desktop work, also install Rust and,
on macOS, Xcode.

```bash
cd apps/karaoke
npm install
npm run dev      # browser development server, usually http://localhost:1420
npm test         # LRC/SRT/TTML import and export tests
npm run build    # TypeScript check plus Vite production build into dist/
npm run tauri dev # desktop app
npm run tauri build # create desktop bundles
```

## Testing

Tests live beside the code they cover:

- `src/lib/lyrics.test.ts` - timed lyric import/export and support text.
- `src/lib/project.test.ts` - project parsing and helpers.
- `src/lib/clipboard.test.ts` - rich-text clipboard normalization.
- `src/lib/player.test.ts` - player helper behavior.
- `src/components.test.tsx` - component behavior.

## Extending the app

- Add new lyric formats by extending `src/lib/lyrics.ts` and its tests.
- Add new project fields carefully, keeping `version` and `parseProject`
  validation in sync, and preserving older project files when possible.
- Keep UI components small and typed, following the patterns in
  `src/components.tsx`.
- Prefer reusing existing dependencies before adding new ones.
- Run `npm test` and `npm run build` before finishing a change.