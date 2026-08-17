// @vitest-environment jsdom

import { describe, expect, it } from "vitest";
import { normalizedClipboardText } from "./clipboard";

describe("clipboard text normalization", () => {
  it("restores stanza breaks from rich-text paragraphs", () => {
    const plain = "First line\nSecond line\nThird line\nFourth line";
    const html = "<p>First line<br>Second line</p><p>Third line<br>Fourth line</p>";

    expect(normalizedClipboardText(plain, html)).toBe(
      "First line\nSecond line\n\nThird line\nFourth line",
    );
  });

  it("normalizes Unicode and Windows newline characters", () => {
    expect(normalizedClipboardText("First\r\nSecond\u2028Third\u2029Fourth")).toBe(
      "First\nSecond\nThird\n\nFourth",
    );
  });

  it("keeps plain text when it already contains the richer spacing", () => {
    const plain = "First line\nSecond line\n\nThird line";
    const html = "<p>First line<br>Second line</p><p>Third line</p>";

    expect(normalizedClipboardText(plain, html)).toBe(plain);
  });
});
