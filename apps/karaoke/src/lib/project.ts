import type { KaraokeProject, ProjectAsset } from "../types";

export const PROJECT_EXTENSION = "karaoke";

export async function fileToAsset(file: File): Promise<ProjectAsset> {
  return { name: file.name, mimeType: file.type || "application/octet-stream", dataUrl: await fileToDataUrl(file) };
}

export function assetToUrl(asset?: ProjectAsset): string | undefined {
  return asset?.dataUrl;
}

export function serializeProject(project: KaraokeProject): string {
  return JSON.stringify({ ...project, updatedAt: new Date().toISOString() }, null, 2);
}

export function parseProject(contents: string): KaraokeProject {
  const value = JSON.parse(contents) as Partial<KaraokeProject>;
  if (value.format !== "karaoke-project" || value.version !== 1) {
    throw new Error("This is not a Karaoke project.");
  }
  if (!value.title || !value.vocalAudio?.dataUrl || !Array.isArray(value.cues)) {
    throw new Error("This project is missing required song data.");
  }
  return value as KaraokeProject;
}

export function downloadText(contents: string, fileName: string, type = "text/plain;charset=utf-8") {
  const url = URL.createObjectURL(new Blob([contents], { type }));
  const anchor = document.createElement("a");
  anchor.href = url;
  anchor.download = fileName;
  anchor.click();
  URL.revokeObjectURL(url);
}

export function downloadDataUrl(dataUrl: string, fileName: string) {
  const anchor = document.createElement("a");
  anchor.href = dataUrl;
  anchor.download = fileName;
  anchor.click();
}

function fileToDataUrl(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(String(reader.result));
    reader.onerror = () => reject(reader.error ?? new Error("The file could not be read."));
    reader.readAsDataURL(file);
  });
}
