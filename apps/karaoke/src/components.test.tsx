// @vitest-environment jsdom

import "@testing-library/jest-dom/vitest";
import { fireEvent, render, screen } from "@testing-library/react";
import { describe, expect, it, vi } from "vitest";
import { KaraokeStage, MultilineTextarea, PlayerActions } from "./components";

describe("multiline text fields", () => {
  it("uses rich clipboard structure to preserve stanza breaks", () => {
    const onValue = vi.fn();
    render(<MultilineTextarea aria-label="Lyrics" value="" onValue={onValue} />);

    fireEvent.paste(screen.getByRole("textbox", { name: "Lyrics" }), {
      clipboardData: {
        getData: (type: string) => type === "text/html"
          ? "<p>First line<br>Second line</p><p>Third line</p>"
          : "First line\nSecond line\nThird line",
      },
    });

    expect(onValue).toHaveBeenCalledWith("First line\nSecond line\n\nThird line");
  });
});

describe("karaoke pronunciation guides", () => {
  it("shows enabled guides beneath the current lyric", () => {
    render(
      <KaraokeStage
        cues={[{
          id: "one",
          text: "Πρώτη γραμμή",
          latinPronunciation: "Próti grammí",
          cyrillicPronunciation: "Проти грами",
          translation: "First line",
          startMs: 1_000,
          endMs: 3_000,
        }]}
        positionMs={1_500}
        title="Song"
        artist="Artist"
        backgroundMode="stage"
        showLatinPronunciation
        showCyrillicPronunciation
        showTranslation
      />,
    );

    expect(screen.getByText("Próti grammí")).toBeInTheDocument();
    expect(screen.getByText("Проти грами")).toBeInTheDocument();
    expect(screen.getByText("First line")).toHaveClass("karaoke-translation");
  });
});

describe("player actions", () => {
  it("describes the fullscreen action according to the current state", () => {
    const common = {
      playing: false,
      hasInstrumental: false,
      guideVocals: false,
      hasLatinPronunciation: false,
      hasCyrillicPronunciation: false,
      hasTranslation: true,
      latinPronunciationEnabled: false,
      cyrillicPronunciationEnabled: false,
      translationEnabled: false,
      speed: 1,
      backgroundMode: "stage" as const,
      onPlay: vi.fn(),
      onGuideVocals: vi.fn(),
      onLatinPronunciation: vi.fn(),
      onCyrillicPronunciation: vi.fn(),
      onTranslation: vi.fn(),
      onSpeed: vi.fn(),
      onBackground: vi.fn(),
      onFullscreen: vi.fn(),
    };
    const { rerender } = render(<PlayerActions {...common} fullscreen={false} />);

    expect(screen.getByRole("button", { name: "Full screen" })).toBeInTheDocument();
    expect(screen.getByRole("button", { name: "Translation" })).toHaveAttribute("aria-pressed", "false");

    rerender(<PlayerActions {...common} fullscreen />);
    expect(screen.getByRole("button", { name: "Exit full screen" })).toBeInTheDocument();
  });
});
