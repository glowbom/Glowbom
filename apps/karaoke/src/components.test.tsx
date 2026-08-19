// @vitest-environment jsdom

import "@testing-library/jest-dom/vitest";
import { cleanup, fireEvent, render, screen } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { KaraokeStage, MultilineTextarea, PlayerActions, TimedLyricsPicker } from "./components";

afterEach(cleanup);

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

describe("timed lyrics picker", () => {
  it("requires confirmation before removing attached timing", () => {
    const onRemove = vi.fn();
    const confirm = vi.spyOn(window, "confirm")
      .mockReturnValueOnce(false)
      .mockReturnValueOnce(true);

    render(<TimedLyricsPicker hasTiming onFile={vi.fn()} onRemove={onRemove} />);
    const removeButton = screen.getByRole("button", { name: "Remove lyric timing" });

    fireEvent.click(removeButton);
    expect(onRemove).not.toHaveBeenCalled();

    fireEvent.click(removeButton);
    expect(onRemove).toHaveBeenCalledOnce();
    expect(confirm).toHaveBeenCalledTimes(2);

    confirm.mockRestore();
  });

  it("does not show the remove action before timing exists", () => {
    render(<TimedLyricsPicker hasTiming={false} onFile={vi.fn()} onRemove={vi.fn()} />);

    expect(screen.queryByRole("button", { name: "Remove lyric timing" })).not.toBeInTheDocument();
    expect(screen.getByText("Open LRC, SRT or TTML")).toBeInTheDocument();
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

describe("karaoke opening title", () => {
  const cues = [{
    id: "one",
    text: "First lyric",
    startMs: 5_000,
    endMs: 7_000,
  }];

  it("shows the song and available artist during a usable lead-in", () => {
    render(
      <KaraokeStage
        cues={cues}
        positionMs={0}
        title="Song"
        artist="Artist"
        backgroundMode="stage"
      />,
    );

    expect(screen.getByRole("heading", { name: "Song", level: 1 })).toBeInTheDocument();
    expect(screen.getByRole("heading", { name: "Artist", level: 2 })).toBeInTheDocument();
    expect(screen.queryByLabelText("First lyric")).not.toBeInTheDocument();
  });

  it("omits a missing artist", () => {
    render(
      <KaraokeStage
        cues={cues}
        positionMs={0}
        title="Song"
        artist=""
        backgroundMode="stage"
      />,
    );

    expect(screen.getByRole("heading", { name: "Song", level: 1 })).toBeInTheDocument();
    expect(screen.queryByRole("heading", { level: 2 })).not.toBeInTheDocument();
  });

  it("goes directly to lyrics when the first line starts right away", () => {
    render(
      <KaraokeStage
        cues={[{ ...cues[0], startMs: 1_000 }]}
        positionMs={0}
        title="Song"
        artist="Artist"
        backgroundMode="stage"
      />,
    );

    expect(screen.queryByText("Now singing")).not.toBeInTheDocument();
    expect(screen.getByLabelText("First lyric")).toBeInTheDocument();
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
