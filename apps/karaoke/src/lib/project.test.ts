import { describe, expect, it } from "vitest";
import type { KaraokeProject } from "../types";
import { parseProject, serializeProject } from "./project";

const project = (overrides: Partial<KaraokeProject> = {}): KaraokeProject => ({
  format: "karaoke-project",
  version: 1,
  title: "Song",
  artist: "Artist",
  lyrics: "Γεια σου",
  cues: [{ id: "one", text: "Γεια σου", startMs: 1_000, endMs: 2_000 }],
  vocalAudio: { name: "song.mp3", mimeType: "audio/mpeg", dataUrl: "data:audio/mpeg;base64,AA==" },
  backgroundMode: "stage",
  createdAt: "2026-08-17T00:00:00.000Z",
  updatedAt: "2026-08-17T00:00:00.000Z",
  ...overrides,
});

describe("karaoke projects", () => {
  it("preserves pronunciation guides", () => {
    const saved = parseProject(serializeProject(project({
      latinPronunciations: "Ya su",
      cyrillicPronunciations: "Я су",
      cues: [{
        id: "one",
        text: "Γεια σου",
        latinPronunciation: "Ya su",
        cyrillicPronunciation: "Я су",
        startMs: 1_000,
        endMs: 2_000,
      }],
    })));

    expect(saved.latinPronunciations).toBe("Ya su");
    expect(saved.cues[0]).toMatchObject({ latinPronunciation: "Ya su", cyrillicPronunciation: "Я су" });
  });

  it("continues to open version 1 projects without guides", () => {
    expect(parseProject(JSON.stringify(project())).cues[0].text).toBe("Γεια σου");
  });
});
