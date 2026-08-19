export function playerPageClassName(fullscreen: boolean, controlsVisible: boolean) {
  return [
    "player-page",
    fullscreen ? "player-page--fullscreen" : "",
    fullscreen && !controlsVisible ? "player-page--controls-hidden" : "",
  ].filter(Boolean).join(" ");
}

const MIN_OPENING_TITLE_LEAD_MS = 1_500;
const MAX_OPENING_TITLE_DURATION_MS = 3_500;
const OPENING_TITLE_LYRIC_GAP_MS = 500;
const OPENING_TITLE_FADE_MS = 400;

export function openingTitleState(firstCueStartMs: number | undefined, positionMs: number) {
  if (
    firstCueStartMs === undefined
    || !Number.isFinite(firstCueStartMs)
    || firstCueStartMs < MIN_OPENING_TITLE_LEAD_MS
  ) {
    return { visible: false, opacity: 0 };
  }

  const endMs = Math.min(
    MAX_OPENING_TITLE_DURATION_MS,
    firstCueStartMs - OPENING_TITLE_LYRIC_GAP_MS,
  );
  if (positionMs < 0 || positionMs >= endMs) return { visible: false, opacity: 0 };

  const fadeStartMs = Math.max(0, endMs - OPENING_TITLE_FADE_MS);
  const opacity = positionMs <= fadeStartMs
    ? 1
    : Math.max(0, (endMs - positionMs) / OPENING_TITLE_FADE_MS);

  return { visible: true, opacity };
}
