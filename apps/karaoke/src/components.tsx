import { useEffect, useRef, useState, type ChangeEvent, type ClipboardEvent as ReactClipboardEvent, type ReactNode, type TextareaHTMLAttributes } from "react";
import {
  ArrowLeft,
  Check,
  Download,
  FileAudio,
  FileText,
  FolderOpen,
  Image,
  Maximize,
  Minimize,
  Mic2,
  Music2,
  Pause,
  Play,
  RotateCcw,
  Save,
  Upload,
  Wallpaper,
  X,
} from "lucide-react";
import type { BackgroundMode, KaraokeCue, ProjectAsset } from "./types";
import { normalizedClipboardText } from "./lib/clipboard";

export function TopBar({
  title,
  subtitle,
  onBack,
  actions,
}: {
  title: string;
  subtitle?: string;
  onBack?: () => void;
  actions?: ReactNode;
}) {
  return (
    <header className="top-bar">
      <div className="top-bar__title">
        {onBack && (
          <button className="icon-button" onClick={onBack} aria-label="Go back">
            <ArrowLeft />
          </button>
        )}
        <div>
          <strong>{title}</strong>
          {subtitle && <small>{subtitle}</small>}
        </div>
      </div>
      {actions && <div className="top-bar__actions">{actions}</div>}
    </header>
  );
}

export function FilePicker({
  label,
  helper,
  accept,
  asset,
  icon,
  onFile,
  optional,
}: {
  label: string;
  helper: string;
  accept: string;
  asset?: ProjectAsset;
  icon: ReactNode;
  onFile: (file: File) => void | Promise<void>;
  optional?: boolean;
}) {
  const input = useRef<HTMLInputElement>(null);
  return (
    <button className={`file-picker ${asset ? "file-picker--ready" : ""}`} onClick={() => input.current?.click()} type="button">
      <input
        ref={input}
        type="file"
        accept={accept}
        hidden
        onChange={(event) => {
          const file = event.target.files?.[0];
          if (file) void onFile(file);
          event.currentTarget.value = "";
        }}
      />
      <span className="file-picker__icon">{asset ? <Check /> : icon}</span>
      <span className="file-picker__copy">
        <strong>{asset?.name ?? label}{optional && !asset ? " · optional" : ""}</strong>
        <small>{asset ? "Click to choose a different file" : helper}</small>
      </span>
      <Upload size={18} />
    </button>
  );
}

export function SetupSection({ number, title, description, children }: { number: number; title: string; description: string; children: ReactNode }) {
  return (
    <section className="setup-card">
      <div className="setup-card__heading">
        <span>{number}</span>
        <div><h2>{title}</h2><p>{description}</p></div>
      </div>
      <div className="setup-card__body">{children}</div>
    </section>
  );
}

export function MultilineTextarea({ value, onValue, ...props }: {
  value: string;
  onValue: (value: string) => void;
} & Omit<TextareaHTMLAttributes<HTMLTextAreaElement>, "value" | "onChange" | "onPaste">) {
  const paste = (event: ReactClipboardEvent<HTMLTextAreaElement>) => {
    const plainText = event.clipboardData.getData("text/plain");
    const text = normalizedClipboardText(plainText, event.clipboardData.getData("text/html"));
    if (text === plainText) return;

    event.preventDefault();
    const textarea = event.currentTarget;
    const start = textarea.selectionStart ?? value.length;
    const end = textarea.selectionEnd ?? start;
    onValue(`${value.slice(0, start)}${text}${value.slice(end)}`);
    const restoreCaret = () => textarea.setSelectionRange(start + text.length, start + text.length);
    if (typeof requestAnimationFrame === "function") requestAnimationFrame(restoreCaret);
    else setTimeout(restoreCaret, 0);
  };

  return <textarea {...props} value={value} onChange={(event) => onValue(event.target.value)} onPaste={paste} />;
}

export function AudioTransport({ audio, positionMs, durationMs, playing, onToggle, onSeek }: {
  audio: HTMLAudioElement | null;
  positionMs: number;
  durationMs: number;
  playing: boolean;
  onToggle: () => void;
  onSeek: (milliseconds: number) => void;
}) {
  return (
    <div className="transport">
      <button className="round-button" disabled={!audio} onClick={onToggle} aria-label={playing ? "Pause" : "Play"}>
        {playing ? <Pause fill="currentColor" /> : <Play fill="currentColor" />}
      </button>
      <div className="transport__timeline">
        <input
          type="range"
          min={0}
          max={Math.max(durationMs, 1)}
          value={Math.min(positionMs, durationMs || 1)}
          onChange={(event) => onSeek(Number(event.target.value))}
        />
        <div><span>{clock(positionMs)}</span><span>{clock(durationMs)}</span></div>
      </div>
    </div>
  );
}

export function KaraokeStage({
  cues,
  positionMs,
  title,
  artist,
  background,
  backgroundMode,
  fullscreen,
  showLatinPronunciation,
  showCyrillicPronunciation,
  showTranslation,
}: {
  cues: KaraokeCue[];
  positionMs: number;
  title: string;
  artist: string;
  background?: ProjectAsset;
  backgroundMode: BackgroundMode;
  fullscreen?: boolean;
  showLatinPronunciation?: boolean;
  showCyrillicPronunciation?: boolean;
  showTranslation?: boolean;
}) {
  const activeIndex = cues.findIndex((cue) => positionMs >= cue.startMs && positionMs <= cue.endMs);
  const nextIndex = cues.findIndex((cue) => cue.startMs > positionMs);
  const index = activeIndex >= 0 ? activeIndex : nextIndex;
  const cue = index >= 0 ? cues[index] : undefined;
  const next = index >= 0 ? cues[index + 1] : undefined;
  const firstCue = cues[0];
  const countdown = firstCue && positionMs < firstCue.startMs
    ? Math.ceil((firstCue.startMs - positionMs) / 1_000)
    : 0;
  const showCountdown = countdown >= 1 && countdown <= 3;
  const progress = activeIndex < 0 || !cue ? 0 : Math.max(0, Math.min(1, (positionMs - cue.startMs) / Math.max(1, cue.endMs - cue.startMs)));

  const style = backgroundMode === "photo" && background
    ? { backgroundImage: `url(${background.dataUrl})` }
    : undefined;

  return (
    <div className={`karaoke-stage karaoke-stage--${backgroundMode} ${fullscreen ? "karaoke-stage--fullscreen" : ""}`} style={style}>
      <div className="karaoke-stage__noise" />
      <div className="karaoke-stage__meta">{title} <span>·</span> {artist || "Your song"}</div>
      {cue ? (
        <div className="karaoke-stage__lyrics">
          {showCountdown && firstCue && (
            <div className="karaoke-countdown" aria-live="polite">
              <strong>{countdown}</strong>
            </div>
          )}
          <SweepingLyric text={cue.text} progress={progress} />
          {(showLatinPronunciation && cue.latinPronunciation || showCyrillicPronunciation && cue.cyrillicPronunciation) && (
            <div className="karaoke-pronunciations">
              {showLatinPronunciation && cue.latinPronunciation && <div data-guide="latin">{cue.latinPronunciation}</div>}
              {showCyrillicPronunciation && cue.cyrillicPronunciation && <div data-guide="cyrillic">{cue.cyrillicPronunciation}</div>}
            </div>
          )}
          {next && <div className="next-line">{next.text}</div>}
        </div>
      ) : cues.length === 0 ? <p className="karaoke-empty">Add lyrics to begin.</p> : null}
      {showTranslation && cue?.translation && <div className="karaoke-translation">{cue.translation}</div>}
    </div>
  );
}

function SweepingLyric({ text, progress }: { text: string; progress: number }) {
  const tokens = text.split(/(\s+)/);
  const totalLength = Math.max(text.length, 1);
  let offset = 0;

  return (
    <div className="sweeping-line" aria-label={text}>
      {tokens.map((token, index) => {
        const start = offset / totalLength;
        offset += token.length;
        const end = offset / totalLength;
        const tokenProgress = Math.max(0, Math.min(1, (progress - start) / Math.max(end - start, Number.EPSILON)));

        if (/^\s+$/.test(token)) {
          return <span className="sweeping-space" aria-hidden="true" key={`${index}-${offset}`}>{token}</span>;
        }

        return (
          <span
            className="sweeping-word"
            aria-hidden="true"
            key={`${index}-${offset}`}
            style={{
              backgroundImage: `linear-gradient(90deg, var(--yellow) 0%, var(--yellow) ${tokenProgress * 100}%, #ffffff ${tokenProgress * 100}%, #ffffff 100%)`,
            }}
          >
            {token}
          </span>
        );
      })}
    </div>
  );
}

export function PlayerActions({
  playing,
  hasInstrumental,
  guideVocals,
  hasLatinPronunciation,
  hasCyrillicPronunciation,
  hasTranslation,
  latinPronunciationEnabled,
  cyrillicPronunciationEnabled,
  translationEnabled,
  speed,
  backgroundMode,
  fullscreen,
  onPlay,
  onGuideVocals,
  onLatinPronunciation,
  onCyrillicPronunciation,
  onTranslation,
  onSpeed,
  onBackground,
  onFullscreen,
}: {
  playing: boolean;
  hasInstrumental: boolean;
  guideVocals: boolean;
  hasLatinPronunciation: boolean;
  hasCyrillicPronunciation: boolean;
  hasTranslation: boolean;
  latinPronunciationEnabled: boolean;
  cyrillicPronunciationEnabled: boolean;
  translationEnabled: boolean;
  speed: number;
  backgroundMode: BackgroundMode;
  fullscreen: boolean;
  onPlay: () => void;
  onGuideVocals: () => void;
  onLatinPronunciation: () => void;
  onCyrillicPronunciation: () => void;
  onTranslation: () => void;
  onSpeed: () => void;
  onBackground: () => void;
  onFullscreen: () => void;
}) {
  return (
    <div className="player-actions">
      {hasInstrumental && <button className={guideVocals ? "active" : ""} onClick={onGuideVocals}><Mic2 /> Guide vocals</button>}
      {hasLatinPronunciation && <button className={latinPronunciationEnabled ? "active" : ""} aria-pressed={latinPronunciationEnabled} onClick={onLatinPronunciation}>Latin guide</button>}
      {hasCyrillicPronunciation && <button className={cyrillicPronunciationEnabled ? "active" : ""} aria-pressed={cyrillicPronunciationEnabled} onClick={onCyrillicPronunciation}>Cyrillic guide</button>}
      {hasTranslation && <button className={translationEnabled ? "active" : ""} aria-pressed={translationEnabled} onClick={onTranslation}>Translation</button>}
      <button className="player-actions__play" onClick={onPlay}>{playing ? <Pause fill="currentColor" /> : <Play fill="currentColor" />}</button>
      <button onClick={onSpeed}>{speed}×</button>
      <button onClick={onBackground}><Wallpaper /> {backgroundMode}</button>
      <button onClick={onFullscreen}>{fullscreen ? <Minimize /> : <Maximize />} {fullscreen ? "Exit full screen" : "Full screen"}</button>
    </div>
  );
}

export function ProjectButtons({ onOpen, onSave }: { onOpen: () => void; onSave: () => void }) {
  return <><button className="button button--quiet" onClick={onOpen}><FolderOpen /> Open project</button><button className="button button--quiet" onClick={onSave}><Save /> Save project</button></>;
}

export function ExportButtons({ onExport }: { onExport: (format: "lrc" | "srt" | "ttml") => void }) {
  return (
    <div className="export-buttons">
      <button onClick={() => onExport("lrc")}><Download /> LRC</button>
      <button onClick={() => onExport("srt")}><Download /> SRT</button>
      <button onClick={() => onExport("ttml")}><Download /> TTML</button>
    </div>
  );
}

export const Icons = { FileAudio, FileText, Image, Music2, RotateCcw, Save, X };

export function readTextFile(event: ChangeEvent<HTMLInputElement>, onText: (file: File, contents: string) => void) {
  const file = event.target.files?.[0];
  if (!file) return;
  void file.text().then((text) => onText(file, text));
  event.currentTarget.value = "";
}

export function clock(milliseconds: number) {
  const totalSeconds = Math.max(0, Math.floor(milliseconds / 1_000));
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;
  return `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`;
}

export function useAudioClock(audio: HTMLAudioElement | null) {
  const [positionMs, setPositionMs] = useState(0);
  const [durationMs, setDurationMs] = useState(0);
  const [playing, setPlaying] = useState(false);

  useEffect(() => {
    if (!audio) { setPositionMs(0); setDurationMs(0); setPlaying(false); return; }
    let frame = 0;
    const update = () => {
      setPositionMs(audio.currentTime * 1_000);
      if (Number.isFinite(audio.duration)) setDurationMs(audio.duration * 1_000);
      if (!audio.paused) frame = requestAnimationFrame(update);
    };
    const play = () => { setPlaying(true); frame = requestAnimationFrame(update); };
    const stop = () => { setPlaying(false); cancelAnimationFrame(frame); update(); };
    const metadata = () => setDurationMs(Number.isFinite(audio.duration) ? audio.duration * 1_000 : 0);
    audio.addEventListener("play", play); audio.addEventListener("pause", stop); audio.addEventListener("ended", stop); audio.addEventListener("loadedmetadata", metadata); audio.addEventListener("seeked", update);
    metadata(); update();
    return () => { cancelAnimationFrame(frame); audio.removeEventListener("play", play); audio.removeEventListener("pause", stop); audio.removeEventListener("ended", stop); audio.removeEventListener("loadedmetadata", metadata); audio.removeEventListener("seeked", update); };
  }, [audio]);
  return { positionMs, durationMs, playing, setPositionMs };
}
