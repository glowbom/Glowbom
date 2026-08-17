import type { KaraokeCue } from "../types";

const newId = () => globalThis.crypto?.randomUUID?.() ?? `${Date.now()}-${Math.random()}`;

export type PronunciationGuideText = {
  latin?: string;
  cyrillic?: string;
};

export function linesToCues(lyrics: string, guides: PronunciationGuideText = {}): KaraokeCue[] {
  const latinRows = splitRows(guides.latin);
  const cyrillicRows = splitRows(guides.cyrillic);
  return lyricRows(lyrics).map(({ text, rowIndex }, index) => ({
      id: newId(),
      text,
      ...pronunciationFields(latinRows[rowIndex], cyrillicRows[rowIndex]),
      startMs: index * 1_000,
      endMs: index * 1_000 + 500,
    }));
}

export function applyPronunciationGuides(
  cues: KaraokeCue[],
  lyrics: string,
  guides: PronunciationGuideText = {},
): KaraokeCue[] {
  const rows = lyricRows(lyrics);
  const latinRows = splitRows(guides.latin);
  const cyrillicRows = splitRows(guides.cyrillic);
  return cues.map((cue, index) => {
    const rowIndex = rows[index]?.rowIndex ?? index;
    return {
      id: cue.id,
      text: cue.text,
      startMs: cue.startMs,
      endMs: cue.endMs,
      ...pronunciationFields(latinRows[rowIndex], cyrillicRows[rowIndex]),
    };
  });
}

export function pronunciationTextFromCues(
  cues: KaraokeCue[],
  field: "latinPronunciation" | "cyrillicPronunciation",
): string {
  return cues.map((cue) => cue[field] ?? "").join("\n").replace(/\n+$/, "");
}

export function pronunciationGuideStats(lyrics: string, guide: string) {
  const guideRows = splitRows(guide);
  const rows = lyricRows(lyrics);
  return {
    filled: rows.filter(({ rowIndex }) => Boolean(guideRows[rowIndex]?.trim())).length,
    total: rows.length,
  };
}

export function parseTimedLyrics(fileName: string, contents: string): KaraokeCue[] {
  const extension = fileName.toLowerCase().split(".").pop();
  if (extension === "lrc") return parseLrc(contents);
  if (extension === "srt") return parseSrt(contents);
  if (extension === "ttml" || extension === "xml") return parseTtml(contents);
  throw new Error("Choose an LRC, SRT, or TTML lyrics file.");
}

export function parseLrc(contents: string): KaraokeCue[] {
  const timestamp = /\[(\d+):(\d{2})(?:[.:](\d{1,3}))?\]/g;
  const pending: Array<{ startMs: number; text: string }> = [];

  for (const rawLine of contents.split(/\r?\n/)) {
    const matches = [...rawLine.matchAll(timestamp)];
    if (!matches.length) continue;
    const text = rawLine.replace(timestamp, "").trim();
    if (!text) continue;

    for (const match of matches) {
      const fraction = match[3] ?? "0";
      const milliseconds =
        fraction.length === 1
          ? Number(fraction) * 100
          : fraction.length === 2
            ? Number(fraction) * 10
            : Number(fraction.padEnd(3, "0").slice(0, 3));
      pending.push({
        startMs: (Number(match[1]) * 60 + Number(match[2])) * 1_000 + milliseconds,
        text,
      });
    }
  }

  pending.sort((a, b) => a.startMs - b.startMs);
  return pending.map((item, index) => {
    const next = pending[index + 1];
    return {
      id: newId(),
      text: item.text,
      startMs: item.startMs,
      endMs: next ? Math.max(item.startMs + 100, next.startMs - 40) : item.startMs + 4_000,
    };
  });
}

export function parseSrt(contents: string): KaraokeCue[] {
  const range = /(\d{1,2}):(\d{2}):(\d{2})[,.](\d{3})\s*-->\s*(\d{1,2}):(\d{2}):(\d{2})[,.](\d{3})/;
  const cues: KaraokeCue[] = [];

  for (const block of contents.trim().split(/\r?\n\s*\r?\n/)) {
    const lines = block.split(/\r?\n/);
    const rangeIndex = lines.findIndex((line) => range.test(line));
    if (rangeIndex < 0) continue;
    const match = lines[rangeIndex].match(range);
    if (!match) continue;
    const text = lines.slice(rangeIndex + 1).join(" ").replace(/<[^>]+>/g, "").trim();
    if (!text) continue;
    cues.push({ id: newId(), text, startMs: matchTime(match, 1), endMs: matchTime(match, 5) });
  }
  return cues;
}

export function parseTtml(contents: string): KaraokeCue[] {
  const paragraph = /<p\b([^>]*)>([\s\S]*?)<\/p>/gi;
  const cues: KaraokeCue[] = [];

  for (const match of contents.matchAll(paragraph)) {
    const begin = attribute(match[1], "begin");
    const end = attribute(match[1], "end");
    const duration = attribute(match[1], "dur");
    if (!begin || (!end && !duration)) continue;
    const startMs = parseTtmlTime(begin);
    const endMs = end ? parseTtmlTime(end) : startMs + parseTtmlTime(duration!);
    const text = decodeXml(match[2].replace(/<br\s*\/?>/gi, " ").replace(/<[^>]+>/g, "")).trim();
    if (text) cues.push({ id: newId(), text, startMs, endMs });
  }
  return cues;
}

export function exportLrc(cues: KaraokeCue[]): string {
  return `${cues.map((cue) => `[${lrcTime(cue.startMs)}]${cue.text}`).join("\n")}\n`;
}

export function exportSrt(cues: KaraokeCue[]): string {
  return `${cues
    .map(
      (cue, index) =>
        `${index + 1}\n${subtitleTime(cue.startMs, ",")} --> ${subtitleTime(cue.endMs, ",")}\n${cue.text}`,
    )
    .join("\n\n")}\n`;
}

export function exportTtml(cues: KaraokeCue[]): string {
  const lines = cues
    .map(
      (cue) =>
        `<p begin="${subtitleTime(cue.startMs)}" end="${subtitleTime(cue.endMs)}">${escapeXml(cue.text)}</p>`,
    )
    .join("\n");
  return `<?xml version="1.0" encoding="UTF-8"?>
<tt xmlns="http://www.w3.org/ns/ttml" xmlns:tts="http://www.w3.org/ns/ttml#styling" xmlns:ttm="http://www.w3.org/ns/ttml#metadata" xml:lang="mul">
<head></head>
<body><div>
${lines}
</div></body>
</tt>
`;
}

export function fileBaseName(artist: string, title: string): string {
  const normalized = `${artist} ${title}`
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
  return normalized || "karaoke-lyrics";
}

function matchTime(match: RegExpMatchArray, offset: number) {
  return (((Number(match[offset]) * 60 + Number(match[offset + 1])) * 60 + Number(match[offset + 2])) * 1_000) + Number(match[offset + 3]);
}

function attribute(attributes: string, name: string) {
  return attributes.match(new RegExp(`${name}\\s*=\\s*["']([^"']+)["']`, "i"))?.[1];
}

function parseTtmlTime(value: string): number {
  const milliseconds = value.match(/^(\d+(?:\.\d+)?)ms$/);
  if (milliseconds) return Math.round(Number(milliseconds[1]));
  const seconds = value.match(/^(\d+(?:\.\d+)?)s$/);
  if (seconds) return Math.round(Number(seconds[1]) * 1_000);
  const clock = value.match(/^(\d{1,2}):(\d{2}):(\d{2})(?:[.:](\d{1,3}))?$/);
  if (!clock) throw new Error(`Unsupported TTML time: ${value}`);
  const fraction = Number((clock[4] ?? "0").padEnd(3, "0").slice(0, 3));
  return ((Number(clock[1]) * 60 + Number(clock[2])) * 60 + Number(clock[3])) * 1_000 + fraction;
}

function lrcTime(milliseconds: number) {
  const centiseconds = Math.round(milliseconds / 10);
  const minutes = Math.floor(centiseconds / 6_000);
  const seconds = Math.floor(centiseconds / 100) % 60;
  const fraction = centiseconds % 100;
  return `${pad(minutes, 2)}:${pad(seconds, 2)}.${pad(fraction, 2)}`;
}

function subtitleTime(milliseconds: number, separator = ".") {
  const hours = Math.floor(milliseconds / 3_600_000);
  const minutes = Math.floor(milliseconds / 60_000) % 60;
  const seconds = Math.floor(milliseconds / 1_000) % 60;
  const millis = Math.floor(milliseconds) % 1_000;
  return `${pad(hours, 2)}:${pad(minutes, 2)}:${pad(seconds, 2)}${separator}${pad(millis, 3)}`;
}

function lyricRows(lyrics: string) {
  return splitRows(lyrics)
    .map((text, rowIndex) => ({ text: text.trim(), rowIndex }))
    .filter(({ text }) => Boolean(text));
}

function splitRows(value = "") {
  return value.split(/\r?\n/);
}

function pronunciationFields(latin?: string, cyrillic?: string) {
  const normalizedLatin = latin?.trim();
  const normalizedCyrillic = cyrillic?.trim();
  return {
    ...(normalizedLatin ? { latinPronunciation: normalizedLatin } : {}),
    ...(normalizedCyrillic ? { cyrillicPronunciation: normalizedCyrillic } : {}),
  };
}

function pad(value: number, length: number) {
  return String(value).padStart(length, "0");
}

function decodeXml(value: string) {
  return value
    .replaceAll("&amp;", "&")
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">")
    .replaceAll("&quot;", '"')
    .replaceAll("&apos;", "'");
}

function escapeXml(value: string) {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&apos;");
}
