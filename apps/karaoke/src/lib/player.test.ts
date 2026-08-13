import { describe, expect, it } from "vitest";
import { playerPageClassName } from "./player";

describe("player page classes", () => {
  it("marks fullscreen independently of the browser Fullscreen API", () => {
    expect(playerPageClassName(true, true)).toBe("player-page player-page--fullscreen");
  });

  it("hides controls only while fullscreen", () => {
    expect(playerPageClassName(true, false)).toBe("player-page player-page--fullscreen player-page--controls-hidden");
    expect(playerPageClassName(false, false)).toBe("player-page");
  });
});
