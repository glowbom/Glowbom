import SwiftUI
import AVFoundation

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "DJ Mix Master"

    @State private var isPlaying = false
    @State private var volume: Double = 50
    @State private var tempo: Double = 120
    @State private var selectedTrack: String?

    let tracks = ["Track 1", "Track 2", "Track 3"]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("DJ Mix Master")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Image("dj_booth")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Mixer Controls")
                                .font(.headline)

                            HStack {
                                Button(action: { isPlaying = true }) {
                                    Text("Play")
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                Button(action: { isPlaying = false }) {
                                    Text("Pause")
                                        .padding()
                                        .background(Color.yellow)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                Button(action: { isPlaying = false }) {
                                    Text("Stop")
                                        .padding()
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }

                            VStack(alignment: .leading) {
                                Text("Volume")
                                Slider(value: $volume, in: 0...100)
                            }

                            VStack(alignment: .leading) {
                                Text("Tempo")
                                Slider(value: $tempo, in: 60...180)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Playlist")
                                .font(.headline)

                            ForEach(tracks, id: \.self) { track in
                                HStack {
                                    Text(track)
                                    Spacer()
                                    Button("Play") {
                                        selectedTrack = track
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.purple.opacity(0.8))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                Spacer()
            }
            Spacer()
        }
    }
}