import { isTauri } from "@tauri-apps/api/core";
import { getCurrentWindow } from "@tauri-apps/api/window";
import { open, save } from "@tauri-apps/plugin-dialog";
import { readTextFile, writeTextFile } from "@tauri-apps/plugin-fs";

export async function saveTextToDisk(contents: string, fileName: string) {
  if (!isTauri()) return false;
  const extension = fileName.split(".").pop() ?? "txt";
  const path = await save({
    defaultPath: fileName,
    filters: [{ name: extension === "karaoke" ? "Karaoke project" : `${extension.toUpperCase()} file`, extensions: [extension] }],
  });
  if (!path) return true;
  await writeTextFile(path, contents);
  return true;
}

export async function openKaraokeProjectFromDisk() {
  if (!isTauri()) return undefined;
  const path = await open({
    multiple: false,
    directory: false,
    filters: [{ name: "Karaoke project", extensions: ["karaoke"] }],
  });
  if (!path) return null;
  return readTextFile(path);
}

export async function toggleDesktopFullscreen(element: HTMLElement | null) {
  if (isTauri()) {
    const window = getCurrentWindow();
    const next = !(await window.isFullscreen());
    await window.setFullscreen(next);
    return next;
  }
  if (document.fullscreenElement) {
    await document.exitFullscreen();
    return false;
  }
  await element?.requestFullscreen();
  return Boolean(document.fullscreenElement);
}

export async function leaveDesktopFullscreen() {
  if (isTauri()) {
    await getCurrentWindow().setFullscreen(false);
  } else if (document.fullscreenElement) {
    await document.exitFullscreen();
  }
}
