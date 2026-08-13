import { describe, expect, it } from "vitest";
import { exportLrc, exportSrt, exportTtml, fileBaseName, parseLrc, parseSrt, parseTtml } from "./lyrics";

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
});
