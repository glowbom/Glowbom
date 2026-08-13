export function playerPageClassName(fullscreen: boolean, controlsVisible: boolean) {
  return [
    "player-page",
    fullscreen ? "player-page--fullscreen" : "",
    fullscreen && !controlsVisible ? "player-page--controls-hidden" : "",
  ].filter(Boolean).join(" ");
}
