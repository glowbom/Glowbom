import { useEffect, useMemo, useRef, useState } from "react";
import { ChevronRight, Download, FileText, FolderOpen, Image, Mic2, Music2, Save, Sparkles, TimerReset, Upload } from "lucide-react";
import {
  AudioTransport,
  ExportButtons,
  FilePicker,
  KaraokeStage,
  MultilineTextarea,
  PlayerActions,
  ProjectButtons,
  SetupSection,
  TimedLyricsPicker,
  TopBar,
  useAudioClock,
} from "./components";
import {
  applyLyricSupportText,
  exportLrc,
  exportSrt,
  exportTtml,
  fileBaseName,
  linesToCues,
  parseTimedLyrics,
  lyricSupportStats,
  lyricSupportTextFromCues,
} from "./lib/lyrics";
import { downloadText, fileToAsset, parseProject, PROJECT_EXTENSION, serializeProject } from "./lib/project";
import { leaveDesktopFullscreen, openKaraokeProjectFromDisk, saveTextToDisk, toggleDesktopFullscreen } from "./lib/desktop";
import { playerPageClassName } from "./lib/player";
import type { BackgroundMode, KaraokeCue, KaraokeProject, ProjectAsset } from "./types";
import "./styles.css";

type Screen = "home" | "setup" | "timing" | "player";

const initialDate = () => new Date().toISOString();

export default function App() {
  const [screen, setScreen] = useState<Screen>("home");
  const [title, setTitle] = useState("");
  const [artist, setArtist] = useState("");
  const [lyrics, setLyrics] = useState("");
  const [latinPronunciations, setLatinPronunciations] = useState("");
  const [cyrillicPronunciations, setCyrillicPronunciations] = useState("");
  const [translations, setTranslations] = useState("");
  const [cues, setCues] = useState<KaraokeCue[]>([]);
  const [vocalAudio, setVocalAudio] = useState<ProjectAsset>();
  const [instrumentalAudio, setInstrumentalAudio] = useState<ProjectAsset>();
  const [backgroundImage, setBackgroundImage] = useState<ProjectAsset>();
  const [backgroundMode, setBackgroundMode] = useState<BackgroundMode>("stage");
  const [error, setError] = useState("");
  const [createdAt, setCreatedAt] = useState(initialDate);
  const openProjectInput = useRef<HTMLInputElement>(null);

  const project = useMemo<KaraokeProject | null>(() => vocalAudio ? ({
    format: "karaoke-project",
    version: 1,
    title: title.trim() || "My karaoke",
    artist: artist.trim() || "Your song",
    lyrics,
    latinPronunciations,
    cyrillicPronunciations,
    translations,
    cues,
    vocalAudio,
    instrumentalAudio,
    backgroundImage,
    backgroundMode,
    createdAt,
    updatedAt: initialDate(),
  }) : null, [artist, backgroundImage, backgroundMode, createdAt, cues, cyrillicPronunciations, instrumentalAudio, latinPronunciations, lyrics, title, translations, vocalAudio]);

  const loadProject = (value: KaraokeProject) => {
    const latin = value.latinPronunciations ?? lyricSupportTextFromCues(value.cues, "latinPronunciation");
    const cyrillic = value.cyrillicPronunciations ?? lyricSupportTextFromCues(value.cues, "cyrillicPronunciation");
    const translated = value.translations ?? lyricSupportTextFromCues(value.cues, "translation");
    setTitle(value.title); setArtist(value.artist); setLyrics(value.lyrics);
    setLatinPronunciations(latin); setCyrillicPronunciations(cyrillic);
    setTranslations(translated);
    setCues(applyLyricSupportText(value.cues, value.lyrics, { latin, cyrillic, translation: translated }));
    setVocalAudio(value.vocalAudio); setInstrumentalAudio(value.instrumentalAudio);
    setBackgroundImage(value.backgroundImage); setBackgroundMode(value.backgroundMode ?? "stage");
    setCreatedAt(value.createdAt); setError(""); setScreen("player");
  };

  const saveProject = async () => {
    if (!project) { setError("Add the song audio before saving the project."); return; }
    const contents = serializeProject(project);
    const name = `${fileBaseName(project.artist, project.title)}.${PROJECT_EXTENSION}`;
    if (!(await saveTextToDisk(contents, name))) downloadText(contents, name, "application/json");
  };

  const chooseProject = async () => {
    try {
      const contents = await openKaraokeProjectFromDisk();
      if (contents === undefined) openProjectInput.current?.click();
      else if (contents !== null) loadProject(parseProject(contents));
    } catch (reason) {
      setError(reason instanceof Error ? reason.message : "The project could not be opened.");
    }
  };

  const openProject = async (file: File) => {
    try { loadProject(parseProject(await file.text())); }
    catch (reason) { setError(reason instanceof Error ? reason.message : "The project could not be opened."); }
  };

  const begin = () => {
    if (!vocalAudio) { setError("Add the song audio with vocals first."); return; }
    if (!lyrics.trim()) { setError("Paste the lyrics or import a timed lyrics file."); return; }
    if (cues.length) setScreen("player");
    else { setCues(linesToCues(lyrics, { latin: latinPronunciations, cyrillic: cyrillicPronunciations, translation: translations })); setScreen("timing"); }
    setError("");
  };

  const cycleBackground = () => {
    const available: BackgroundMode[] = backgroundImage ? ["photo", "stage", "gray"] : ["stage", "gray"];
    setBackgroundMode(available[(available.indexOf(backgroundMode) + 1) % available.length]);
  };

  const reset = () => {
    setTitle(""); setArtist(""); setLyrics(""); setLatinPronunciations(""); setCyrillicPronunciations(""); setTranslations(""); setCues([]); setVocalAudio(undefined);
    setInstrumentalAudio(undefined); setBackgroundImage(undefined); setBackgroundMode("stage");
    setCreatedAt(initialDate()); setError(""); setScreen("setup");
  };

  return (
    <div className={`app app--${screen}`}>
      <input ref={openProjectInput} type="file" accept={`.${PROJECT_EXTENSION},application/json`} hidden onChange={(event) => {
        const file = event.target.files?.[0]; if (file) void openProject(file); event.currentTarget.value = "";
      }} />
      {screen === "home" && <Home onCreate={() => { setError(""); setScreen("setup"); }} onOpen={() => void chooseProject()} error={error} />}
      {screen === "setup" && (
        <Setup
          title={title} artist={artist} lyrics={lyrics} latinPronunciations={latinPronunciations} cyrillicPronunciations={cyrillicPronunciations} translations={translations} vocalAudio={vocalAudio}
          instrumentalAudio={instrumentalAudio} backgroundImage={backgroundImage}
          imported={cues.length > 0} error={error}
          onTitle={setTitle} onArtist={setArtist}
          onVocal={async (file) => { setVocalAudio(await fileToAsset(file)); if (!title.trim()) setTitle(file.name.replace(/\.[^.]+$/, "").replaceAll("_", " ")); setError(""); }}
          onInstrumental={async (file) => { setInstrumentalAudio(await fileToAsset(file)); setError(""); }}
          onBackground={async (file) => { setBackgroundImage(await fileToAsset(file)); setBackgroundMode("photo"); setError(""); }}
          onLyrics={(value) => { setLyrics(value); setCues([]); }}
          onLatinPronunciations={(value) => { setLatinPronunciations(value); setCues((current) => applyLyricSupportText(current, lyrics, { latin: value, cyrillic: cyrillicPronunciations, translation: translations })); }}
          onCyrillicPronunciations={(value) => { setCyrillicPronunciations(value); setCues((current) => applyLyricSupportText(current, lyrics, { latin: latinPronunciations, cyrillic: value, translation: translations })); }}
          onTranslations={(value) => { setTranslations(value); setCues((current) => applyLyricSupportText(current, lyrics, { latin: latinPronunciations, cyrillic: cyrillicPronunciations, translation: value })); }}
          onTimed={(file, value) => { try { const imported = parseTimedLyrics(file.name, value); if (!imported.length) throw new Error("No timed lyric lines were found."); const importedLyrics = imported.map((cue) => cue.text).join("\n"); setCues(applyLyricSupportText(imported, importedLyrics, { latin: latinPronunciations, cyrillic: cyrillicPronunciations, translation: translations })); setLyrics(importedLyrics); setError(""); } catch (reason) { setError(reason instanceof Error ? reason.message : "The lyrics file could not be read."); } }}
          onRemoveTiming={() => { setCues([]); setError(""); }}
          onContinue={begin} onHome={() => setScreen("home")} onOpen={() => void chooseProject()} onSave={() => void saveProject()}
        />
      )}
      {screen === "timing" && vocalAudio && <Timing title={title || "My karaoke"} artist={artist || "Your song"} audio={vocalAudio} cues={cues} onCues={setCues} onBack={() => setScreen("setup")} onComplete={() => setScreen("player")} onSave={() => void saveProject()} />}
      {screen === "player" && vocalAudio && (
        <Player
          key={createdAt}
          title={title || "My karaoke"} artist={artist || "Your song"} vocalAudio={vocalAudio}
          instrumentalAudio={instrumentalAudio} backgroundImage={backgroundImage} backgroundMode={backgroundMode}
          cues={cues} onBackground={cycleBackground} onBack={() => setScreen("setup")} onSave={() => void saveProject()}
          onOpen={() => void chooseProject()} onNew={reset}
        />
      )}
    </div>
  );
}

function Home({ onCreate, onOpen, error }: { onCreate: () => void; onOpen: () => void; error: string }) {
  return (
    <main className="home">
      <div className="home__glow" />
      <div className="home__content">
        <div className="home__logo"><span>karaoke</span><small>Apps</small></div>
        <p className="eyebrow">A small creative experiment</p>
        <h1>Make your own karaoke.</h1>
        <p className="home__intro">Add a song and its lyrics. Tap the timing with your space bar, then sing in full screen.</p>
        <div className="home__actions">
          <button className="button button--primary button--large" onClick={onCreate}><Mic2 /> Create a karaoke <ChevronRight /></button>
          <button className="button button--glass button--large" onClick={onOpen}><FolderOpen /> Open a saved project</button>
        </div>
        {error && <p className="error-message">{error}</p>}
        <div className="home__steps"><span><Upload /> Add audio</span><span><FileText /> Add lyrics</span><span><TimerReset /> Tap timing</span><span><Music2 /> Sing</span></div>
      </div>
    </main>
  );
}

type SetupProps = {
  title: string; artist: string; lyrics: string; latinPronunciations: string; cyrillicPronunciations: string; translations: string; vocalAudio?: ProjectAsset; instrumentalAudio?: ProjectAsset;
  backgroundImage?: ProjectAsset; imported: boolean; error: string;
  onTitle: (value: string) => void; onArtist: (value: string) => void; onLyrics: (value: string) => void;
  onLatinPronunciations: (value: string) => void; onCyrillicPronunciations: (value: string) => void; onTranslations: (value: string) => void;
  onVocal: (file: File) => void; onInstrumental: (file: File) => void; onBackground: (file: File) => void;
  onTimed: (file: File, value: string) => void; onRemoveTiming: () => void;
  onContinue: () => void; onHome: () => void; onOpen: () => void; onSave: () => void;
};

function Setup(props: SetupProps) {
  const latinStats = lyricSupportStats(props.lyrics, props.latinPronunciations);
  const cyrillicStats = lyricSupportStats(props.lyrics, props.cyrillicPronunciations);
  const translationStats = lyricSupportStats(props.lyrics, props.translations);
  return (
    <><TopBar title="karaoke" subtitle="Apps" onBack={props.onHome} actions={<ProjectButtons onOpen={props.onOpen} onSave={props.onSave} />} />
    <main className="setup-page page-shell">
      <div className="page-heading"><p className="eyebrow">Start here</p><h1>Add your own song</h1><p>Your files stay on your computer. Work through these four small steps.</p></div>
      <div className="setup-grid">
        <SetupSection number={1} title="Name the song" description="This appears at the top of your karaoke.">
          <div className="field-row"><label>Song title<input value={props.title} onChange={(event) => props.onTitle(event.target.value)} placeholder="My favorite song" /></label><label>Artist or occasion <small>optional</small><input value={props.artist} onChange={(event) => props.onArtist(event.target.value)} placeholder="Birthday song" /></label></div>
        </SetupSection>
        <SetupSection number={2} title="Add the audio" description="Use the vocal song for timing. The instrumental is optional.">
          <FilePicker label="Song audio with vocals" helper="MP3, WAV, M4A, AAC, OGG or FLAC" accept="audio/*,.mp3,.wav,.m4a,.aac,.ogg,.flac" asset={props.vocalAudio} icon={<Mic2 />} onFile={props.onVocal} />
          <FilePicker label="Instrumental audio" helper="Used for the final sing-along" accept="audio/*,.mp3,.wav,.m4a,.aac,.ogg,.flac" asset={props.instrumentalAudio} icon={<Music2 />} onFile={props.onInstrumental} optional />
        </SetupSection>
        <SetupSection number={3} title="Add the lyrics" description="Put one lyric line on each row, or open a timed lyrics file.">
          <MultilineTextarea value={props.lyrics} onValue={props.onLyrics} placeholder={'First lyric line\nSecond lyric line\nThird lyric line'} rows={9} />
          <div className="lyric-support-heading"><strong>Pronunciation and translation</strong><span>optional</span><p>Match each row to its lyric row. Leave a row blank when a lyric does not need supporting text.</p></div>
          <div className="lyric-support-fields">
            <label>Latin reading guide <small>{latinStats.filled} / {latinStats.total} lyrics</small>
              <MultilineTextarea value={props.latinPronunciations} onValue={props.onLatinPronunciations} placeholder={'How lyric line 1 sounds\nHow lyric line 2 sounds'} rows={6} />
            </label>
            <label>Cyrillic reading guide <small>{cyrillicStats.filled} / {cyrillicStats.total} lyrics</small>
              <MultilineTextarea value={props.cyrillicPronunciations} onValue={props.onCyrillicPronunciations} placeholder={'Как звучит строка 1\nКак звучит строка 2'} rows={6} />
            </label>
            <label>Translation <small>{translationStats.filled} / {translationStats.total} lyrics</small>
              <MultilineTextarea value={props.translations} onValue={props.onTranslations} placeholder={'Translation of lyric line 1\nTranslation of lyric line 2'} rows={6} />
            </label>
          </div>
          <TimedLyricsPicker hasTiming={props.imported} onFile={props.onTimed} onRemove={props.onRemoveTiming} />
        </SetupSection>
        <SetupSection number={4} title="Choose a background" description="A landscape image works best. You can change it later.">
          <FilePicker label="Background image" helper="JPG, PNG or WebP" accept="image/*,.jpg,.jpeg,.png,.webp" asset={props.backgroundImage} icon={<Image />} onFile={props.onBackground} optional />
        </SetupSection>
      </div>
      {props.error && <p className="error-message">{props.error}</p>}
      <button className="button button--primary button--continue" onClick={props.onContinue}>{props.imported ? <Music2 /> : <TimerReset />}{props.imported ? "Open your karaoke" : "Start lyric timing"}<ChevronRight /></button>
    </main></>
  );
}

function Timing({ title, artist, audio: asset, cues, onCues, onBack, onComplete, onSave }: {
  title: string; artist: string; audio: ProjectAsset; cues: KaraokeCue[]; onCues: (cues: KaraokeCue[]) => void; onBack: () => void; onComplete: () => void; onSave: () => void;
}) {
  const audio = useMemo(() => new Audio(asset.dataUrl), [asset.dataUrl]);
  const { positionMs, durationMs, playing } = useAudioClock(audio);
  const [current, setCurrent] = useState(0);
  const [pressedAt, setPressedAt] = useState<number | null>(null);
  const [history, setHistory] = useState<KaraokeCue[][]>([]);
  const list = useRef<HTMLDivElement>(null);
  const position = useRef(positionMs);
  position.current = positionMs;
  const complete = current >= cues.length;

  const press = () => { if (!playing || complete || pressedAt !== null) return; setPressedAt(position.current); };
  const release = () => {
    if (pressedAt === null || complete) return;
    setHistory((items) => [...items, cues]);
    onCues(cues.map((cue, index) => index === current ? { ...cue, startMs: pressedAt, endMs: Math.max(pressedAt + 100, Math.min(position.current, durationMs || position.current)) } : cue));
    setPressedAt(null); setCurrent((value) => value + 1);
  };
  const undo = () => {
    const previous = history.at(-1); if (!previous) return;
    onCues(previous); setHistory((items) => items.slice(0, -1)); setPressedAt(null); setCurrent((value) => Math.max(0, value - 1));
  };

  useEffect(() => () => audio.pause(), [audio]);

  useEffect(() => {
    const down = (event: KeyboardEvent) => {
      if (event.code === "Space") { event.preventDefault(); if (!event.repeat) press(); }
      if ((event.key === "Backspace" || event.key === "Delete") && !event.repeat) { event.preventDefault(); undo(); }
    };
    const up = (event: KeyboardEvent) => { if (event.code === "Space") { event.preventDefault(); release(); } };
    window.addEventListener("keydown", down); window.addEventListener("keyup", up);
    return () => { window.removeEventListener("keydown", down); window.removeEventListener("keyup", up); };
  });

  useEffect(() => {
    const line = list.current?.querySelector(`[data-line="${current}"]`);
    line?.scrollIntoView({ behavior: "smooth", block: "center" });
  }, [current]);

  return (
    <div className="timing-page"><TopBar title="Lyric timing" subtitle={`${title} · ${artist}`} onBack={onBack} actions={<button className="button button--quiet" onClick={onSave}><Save /> Save project</button>} />
      <main className="timing-layout">
        <section className="timing-controls">
          <div><p className="eyebrow">One button does the work</p><h1>Listen, hold, release.</h1><p>Play the song. Hold <kbd>SPACE</kbd> when the highlighted line begins. Release it when the line ends.</p><p className="timing-delete">Press <kbd>DELETE</kbd> if you make a mistake.</p></div>
          <AudioTransport audio={audio} positionMs={positionMs} durationMs={durationMs} playing={playing} onToggle={() => playing ? audio.pause() : void audio.play()} onSeek={(value) => { audio.currentTime = value / 1_000; }} />
          <button className={`space-button ${pressedAt !== null ? "space-button--holding" : ""}`} disabled={!playing || complete} onPointerDown={press} onPointerUp={release} onPointerCancel={release}>
            {complete ? "Timing complete" : !playing ? "Press play to begin" : pressedAt !== null ? "Release SPACE when the line ends" : "Hold SPACE when the line begins"}
          </button>
          <div className="timing-progress"><span>{complete ? cues.length : current + 1} / {cues.length}</span><div><i style={{ width: `${(current / Math.max(cues.length, 1)) * 100}%` }} /></div></div>
          {complete && <button className="button button--primary button--continue" onClick={onComplete}><Music2 /> Open your karaoke <ChevronRight /></button>}
        </section>
        <section className="lyric-timing-list" ref={list}>
          {cues.map((cue, index) => <div data-line={index} key={cue.id} className={index === current ? `current ${pressedAt !== null ? "holding" : ""}` : index < current ? "done" : ""}><span>{index + 1}</span><p>{cue.text}</p>{index < current && <small>{formatMilliseconds(cue.startMs)} – {formatMilliseconds(cue.endMs)}</small>}</div>)}
        </section>
      </main>
    </div>
  );
}

function Player({ title, artist, vocalAudio, instrumentalAudio, backgroundImage, backgroundMode, cues, onBackground, onBack, onSave, onOpen, onNew }: {
  title: string; artist: string; vocalAudio: ProjectAsset; instrumentalAudio?: ProjectAsset; backgroundImage?: ProjectAsset; backgroundMode: BackgroundMode;
  cues: KaraokeCue[]; onBackground: () => void; onBack: () => void; onSave: () => void; onOpen: () => void; onNew: () => void;
}) {
  const vocal = useMemo(() => new Audio(vocalAudio.dataUrl), [vocalAudio.dataUrl]);
  const instrumental = useMemo(() => instrumentalAudio ? new Audio(instrumentalAudio.dataUrl) : null, [instrumentalAudio]);
  const hasLatinPronunciation = cues.some((cue) => Boolean(cue.latinPronunciation));
  const hasCyrillicPronunciation = cues.some((cue) => Boolean(cue.cyrillicPronunciation));
  const hasTranslation = cues.some((cue) => Boolean(cue.translation));
  const [guideVocals, setGuideVocals] = useState(!instrumental);
  const [latinPronunciationEnabled, setLatinPronunciationEnabled] = useState(hasLatinPronunciation);
  const [cyrillicPronunciationEnabled, setCyrillicPronunciationEnabled] = useState(false);
  const [translationEnabled, setTranslationEnabled] = useState(false);
  const [speed, setSpeed] = useState(1);
  const [fullscreen, setFullscreen] = useState(false);
  const [controlsVisible, setControlsVisible] = useState(true);
  const controlsTimer = useRef<number | undefined>(undefined);
  const active = guideVocals || !instrumental ? vocal : instrumental;
  const { positionMs, durationMs, playing } = useAudioClock(active);
  const shell = useRef<HTMLDivElement>(null);
  const baseName = fileBaseName(artist, title);

  useEffect(() => () => { vocal.pause(); instrumental?.pause(); }, [instrumental, vocal]);
  useEffect(() => { const change = () => setFullscreen(Boolean(document.fullscreenElement)); document.addEventListener("fullscreenchange", change); return () => document.removeEventListener("fullscreenchange", change); }, []);
  useEffect(() => {
    if (!fullscreen) return;
    const escape = (event: KeyboardEvent) => { if (event.key === "Escape") { setFullscreen(false); void leaveDesktopFullscreen(); } };
    window.addEventListener("keydown", escape);
    return () => window.removeEventListener("keydown", escape);
  }, [fullscreen]);
  useEffect(() => {
    window.clearTimeout(controlsTimer.current);
    if (!fullscreen) {
      setControlsVisible(true);
      return;
    }
    setControlsVisible(true);
    controlsTimer.current = window.setTimeout(() => setControlsVisible(false), 2400);
    return () => window.clearTimeout(controlsTimer.current);
  }, [fullscreen]);

  const revealControls = () => {
    if (!fullscreen) return;
    setControlsVisible(true);
    window.clearTimeout(controlsTimer.current);
    controlsTimer.current = window.setTimeout(() => setControlsVisible(false), 2400);
  };

  const switchTrack = () => {
    if (!instrumental) return;
    const wasPlaying = !active.paused; const time = active.currentTime; active.pause();
    const next = guideVocals ? instrumental : vocal; next.currentTime = time; next.playbackRate = speed;
    setGuideVocals(!guideVocals); if (wasPlaying) void next.play();
  };
  const cycleSpeed = () => { const speeds = [1, .75, .9]; const next = speeds[(speeds.indexOf(speed) + 1) % speeds.length]; vocal.playbackRate = next; if (instrumental) instrumental.playbackRate = next; setSpeed(next); };
  const toggleFullscreen = async () => setFullscreen(await toggleDesktopFullscreen(shell.current));
  const exportFile = async (format: "lrc" | "srt" | "ttml") => {
    const contents = format === "lrc" ? exportLrc(cues) : format === "srt" ? exportSrt(cues) : exportTtml(cues);
    const name = `${baseName}.${format}`;
    if (!(await saveTextToDisk(contents, name))) downloadText(contents, name, format === "ttml" ? "application/ttml+xml" : "text/plain;charset=utf-8");
  };

  return (
    <div
      className={playerPageClassName(fullscreen, controlsVisible)}
      ref={shell}
      onPointerMove={revealControls}
      onPointerDown={revealControls}
    >
      {!fullscreen && <TopBar title="Your karaoke" subtitle={`${title} · ${artist}`} onBack={onBack} actions={<><button className="button button--quiet" onClick={onNew}><Sparkles /> New</button><ProjectButtons onOpen={onOpen} onSave={onSave} /></>} />}
      <main className="player-layout">
        <KaraokeStage cues={cues} positionMs={positionMs} title={title} artist={artist} background={backgroundImage} backgroundMode={backgroundMode} fullscreen={fullscreen} showLatinPronunciation={latinPronunciationEnabled} showCyrillicPronunciation={cyrillicPronunciationEnabled} showTranslation={translationEnabled} />
        <div className="player-controls">
          <input type="range" min={0} max={Math.max(durationMs, 1)} value={Math.min(positionMs, durationMs || 1)} onChange={(event) => { active.currentTime = Number(event.target.value) / 1_000; }} />
          <PlayerActions playing={playing} hasInstrumental={Boolean(instrumental)} guideVocals={guideVocals} hasLatinPronunciation={hasLatinPronunciation} hasCyrillicPronunciation={hasCyrillicPronunciation} hasTranslation={hasTranslation} latinPronunciationEnabled={latinPronunciationEnabled} cyrillicPronunciationEnabled={cyrillicPronunciationEnabled} translationEnabled={translationEnabled} speed={speed} backgroundMode={backgroundMode} fullscreen={fullscreen} onPlay={() => playing ? active.pause() : void active.play()} onGuideVocals={switchTrack} onLatinPronunciation={() => setLatinPronunciationEnabled((enabled) => !enabled)} onCyrillicPronunciation={() => setCyrillicPronunciationEnabled((enabled) => !enabled)} onTranslation={() => setTranslationEnabled((enabled) => !enabled)} onSpeed={cycleSpeed} onBackground={onBackground} onFullscreen={() => void toggleFullscreen()} />
          {!fullscreen && <div className="player-export"><span><Download /> Download karaoke files</span><ExportButtons onExport={(format) => void exportFile(format)} /></div>}
        </div>
      </main>
    </div>
  );
}

function formatMilliseconds(milliseconds: number) {
  const minutes = Math.floor(milliseconds / 60_000);
  const seconds = ((milliseconds % 60_000) / 1_000).toFixed(2).padStart(5, "0");
  return `${String(minutes).padStart(2, "0")}:${seconds}`;
}
