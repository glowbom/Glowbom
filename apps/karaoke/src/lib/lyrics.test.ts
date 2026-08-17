import { describe, expect, it } from "vitest";
import {
  applyLyricSupportText,
  exportLrc,
  exportSrt,
  exportTtml,
  fileBaseName,
  linesToCues,
  parseLrc,
  parseSrt,
  parseTtml,
  lyricSupportStats,
  lyricSupportTextFromCues,
} from "./lyrics";

describe("timed lyrics", () => {
  it("imports LRC and derives line endings", () => {
    const cues = parseLrc("[00:01.20]First line\n[00:04.50]Second line\n");
    expect(cues).toHaveLength(2);
    expect(cues[0]).toMatchObject({ text: "First line", startMs: 1200, endMs: 4460 });
    expect(cues[1]).toMatchObject({ startMs: 4500, endMs: 8500 });
  });

  it("imports SRT with exact endings", () => {
    const cues = parseSrt("1\n00:00:02,125 --> 00:00:05,450\nFirst lyric\n\n2\n00:00:06,000 --> 00:00:08,010\nSecond lyric\n");
    expect(cues[0]).toMatchObject({ startMs: 2125, endMs: 5450 });
    expect(cues[1].text).toBe("Second lyric");
  });

  it("imports TTML and decodes entities", () => {
    const cues = parseTtml('<tt><body><div><p begin="00:00:03.250" end="00:00:07.900">You &amp; me</p><p begin="8.1s" dur="2.2s">Next line</p></div></body></tt>');
    expect(cues[0]).toMatchObject({ text: "You & me", startMs: 3250, endMs: 7900 });
    expect(cues[1]).toMatchObject({ startMs: 8100, endMs: 10300 });
  });

  it("exports all supported formats", () => {
    const cues = [{ id: "1", text: "You & I <3", startMs: 13722, endMs: 16927 }];
    expect(exportLrc(cues)).toBe("[00:13.72]You & I <3\n");
    expect(exportSrt(cues)).toContain("00:00:13,722 --> 00:00:16,927");
    expect(exportTtml(cues)).toContain("You &amp; I &lt;3");
  });

  it("creates a portable file name", () => {
    expect(fileBaseName("Frenesi Melódico", "Não Vamos Viver Aqui")).toBe("frenesi-melodico-nao-vamos-viver-aqui");
  });

  it("keeps optional pronunciation guides aligned with lyric rows", () => {
    const cues = linesToCues("Πρώτη γραμμή\n\nΔεύτερη γραμμή", {
      latin: "Próti grammí\n\nDéfteri grammí",
      cyrillic: "Проти грами\n\nДэфтэри грами",
      translation: "First line\n\nSecond line",
    });

    expect(cues).toMatchObject([
      { text: "Πρώτη γραμμή", latinPronunciation: "Próti grammí", cyrillicPronunciation: "Проти грами", translation: "First line" },
      { text: "Δεύτερη γραμμή", latinPronunciation: "Défteri grammí", cyrillicPronunciation: "Дэфтэри грами", translation: "Second line" },
    ]);
    expect(lyricSupportStats("Πρώτη γραμμή\n\nΔεύτερη γραμμή", "Próti grammí\n\n")).toEqual({ filled: 1, total: 2 });
  });

  it("updates pronunciation without changing imported timing", () => {
    const cues = parseSrt("1\n00:00:02,125 --> 00:00:05,450\nΓεια σου\n");
    const updated = applyLyricSupportText(cues, "Γεια σου", { latin: "Ya su", translation: "Hello" });

    expect(updated[0]).toMatchObject({ startMs: 2125, endMs: 5450, latinPronunciation: "Ya su", translation: "Hello" });
    expect(lyricSupportTextFromCues(updated, "latinPronunciation")).toBe("Ya su");
    expect(lyricSupportTextFromCues(updated, "translation")).toBe("Hello");
  });
});
