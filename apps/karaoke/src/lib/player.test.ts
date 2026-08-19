import { describe, expect, it } from "vitest";
import { openingTitleState, playerPageClassName } from "./player";

describe("player page classes", () => {
  it("marks fullscreen independently of the browser Fullscreen API", () => {
    expect(playerPageClassName(true, true)).toBe("player-page player-page--fullscreen");
  });

  it("hides controls only while fullscreen", () => {
    expect(playerPageClassName(true, false)).toBe("player-page player-page--fullscreen player-page--controls-hidden");
    expect(playerPageClassName(false, false)).toBe("player-page");
  });
});

describe("opening song title", () => {
  it("is skipped when the first lyric starts immediately", () => {
    expect(openingTitleState(1_499, 0)).toEqual({ visible: false, opacity: 0 });
  });

  it("shows for a few seconds when the song has a lead-in", () => {
    expect(openingTitleState(8_000, 0)).toEqual({ visible: true, opacity: 1 });
    expect(openingTitleState(8_000, 3_499).visible).toBe(true);
    expect(openingTitleState(8_000, 3_500)).toEqual({ visible: false, opacity: 0 });
  });

  it("fades before handing the stage to the first lyric", () => {
    expect(openingTitleState(3_000, 2_300).opacity).toBeCloseTo(0.5);
    expect(openingTitleState(3_000, 2_500)).toEqual({ visible: false, opacity: 0 });
  });
});
