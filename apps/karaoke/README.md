# Karaoke

Karaoke helps you turn any song into a simple karaoke experience.

You do not need to understand music software. The app guides you through four steps.

## What you can do

1. **Add your audio.** Choose the normal song with vocals. You can also add an instrumental version for singing.
2. **Add your lyrics.** Paste the words with one line on each row. You can optionally add matching Latin and Cyrillic pronunciation guides and translations. If you already have an LRC, SRT, or TTML file, you can open it instead.
3. **Set the timing.** Play the song. Hold the Space bar when a lyric line begins, then release it when the line ends. The app moves to the next line automatically. Press Delete if you make a mistake.
4. **Sing.** Open the player, switch backgrounds, show or hide available pronunciation guides and translations, use the instrumental or guide vocals, change the speed, and enter full screen.

When you paste lyrics or supporting text from ChatGPT or another rich-text editor, the app preserves paragraph and stanza breaks whenever the clipboard provides them.

The app can download your finished lyrics as **LRC**, **SRT**, or **TTML** files. These files can be opened by many lyric and karaoke tools.

## Saving your work

Press **Save project** to download one `.karaoke` file. It contains the song information, audio, lyrics, timing, and background image.

Pronunciation guides and translations are saved in the project too. They remain optional and do not change standard LRC, SRT, or TTML exports.

Press **Open project** later and choose that file. Everything will return, so you can keep editing or start singing again.

Because audio and images are kept inside the project, a project file can be large. Keep it somewhere safe on your computer. Only share audio that you have permission to share.

## Technology

It’s a cross-platform karaoke app built with React, TypeScript, and Vite for the web, with Tauri for desktop packaging.

## Run the experiment in a browser

You need [Node.js](https://nodejs.org/) 20 or newer.

```bash
cd apps/karaoke
npm install
npm run dev
```

Open the address shown in the terminal. Usually it is `http://localhost:1420`.

## Check that it works

```bash
npm test
npm run build
```

The tests check the LRC, SRT, and TTML import and export code. The build command checks the TypeScript code and creates the finished web files in `dist`.

## Run it as a desktop app

The desktop wrapper uses [Tauri](https://tauri.app/). Install the Rust toolchain first, then run:

```bash
npm run tauri dev
```

This opens Karaoke in its own desktop window.

## Make a Mac app

On a Mac with Xcode and Rust installed:

```bash
npm run tauri build
```

Tauri creates a `.app` and `.dmg` under `src-tauri/target/release/bundle/`.

A Mac downloaded app should be signed and notarized before it is shared widely. An unsigned experiment can still be used locally, but macOS may show a security warning.

## Project map

```text
src/App.tsx             screens and app workflow
src/components.tsx      reusable buttons, player, and lyric stage
src/lib/lyrics.ts       LRC, SRT, and TTML import/export
src/lib/project.ts      project save/load helpers
src/styles.css          the visual design
src-tauri/              the desktop app wrapper
```
