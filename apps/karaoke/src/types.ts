export type KaraokeCue = {
  id: string;
  text: string;
  startMs: number;
  endMs: number;
};

export type ProjectAsset = {
  name: string;
  mimeType: string;
  dataUrl: string;
};

export type BackgroundMode = "photo" | "stage" | "gray";

export type KaraokeProject = {
  format: "karaoke-project";
  version: 1;
  title: string;
  artist: string;
  lyrics: string;
  cues: KaraokeCue[];
  vocalAudio: ProjectAsset;
  instrumentalAudio?: ProjectAsset;
  backgroundImage?: ProjectAsset;
  backgroundMode: BackgroundMode;
  createdAt: string;
  updatedAt: string;
};

export type DraftProject = Omit<KaraokeProject, "format" | "version" | "createdAt" | "updatedAt">;
