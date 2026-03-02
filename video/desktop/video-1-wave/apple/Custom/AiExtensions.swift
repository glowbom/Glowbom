import SwiftUI

// High-performance engine for handling the simulation state
// By keeping this inside a plain class instead of an ObservableObject, 
// we avoid triggering costly SwiftUI view-update cycles. 
// The TimelineView natively drives the 60fps refresh loop.
class WaveformEngine {
    var isRecording = false
    var timeMs: Double = 0
    var audioData: [CGFloat] = []
    var pixelAccumulator: CGFloat = 0
    var timeOffset: Double = 0
    var lastTimestamp: Double = 0
    
    func reset() {
        audioData.removeAll()
        timeMs = 0
        pixelAccumulator = 0
        timeOffset = 0
    }
    
    func generateSimulatedAudioValue(t: Double) -> CGFloat {
        let slowOsc = sin(t * 0.5) * 0.5 + 0.5
        let envelope = pow(slowOsc, 3)
        let noise1 = sin(t * 15)
        let noise2 = sin(t * 27) * 0.5
        let randomScratch = Double.random(in: -1...1) * 0.3
        
        let rawSound = noise1 + noise2 + randomScratch
        let amp = (rawSound * envelope * 0.8) + (Double.random(in: -0.5...0.5) * 0.05)
        
        return CGFloat(max(-1, min(1, amp)))
    }
    
    func formatTime() -> String {
        let totalSeconds = Int(timeMs / 1000)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let centi = Int((timeMs.truncatingRemainder(dividingBy: 1000)) / 10)
        return String(format: "%02d:%02d.%02d", minutes, seconds, centi)
    }
}

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    static let enabled = true
    static let title = "Studio Capture"

    @State private var engine = WaveformEngine()
    @State private var isRecordingUI = false
    
    @State private var pingScale: CGFloat = 1.0
    @State private var pingOpacity: Double = 0.7

    var body: some View {
        // Continuous 60fps Timeline loop for smooth visuals
        TimelineView(.animation) { timeline in
            VStack(spacing: 0) {
                
                // --- HEADER ---
                        HStack {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 12, height: 12)
                                        .scaleEffect(pingScale)
                                        .opacity(isRecordingUI ? pingOpacity : 0)
                                        .onAppear {
                                            withAnimation(.easeOut(duration: 1.5).repeatForever(autoreverses: false)) {
                                                pingScale = 2.5
                                                pingOpacity = 0.0
                                            }
                                        }
                                    
                                    Circle()
                                        .fill(isRecordingUI ? Color.red : Color(red: 82/255, green: 82/255, blue: 91/255))
                                        .frame(width: 8, height: 8)
                                        .animation(.easeInOut, value: isRecordingUI)
                                }
                                
                                Text("Studio Capture")
                                    .font(.system(size: 12, weight: .medium))
                                    .tracking(1)
                                    .textCase(.uppercase)
                                    .foregroundColor(Color(red: 212/255, green: 212/255, blue: 216/255))
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                Text(engine.formatTime())
                                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                                    .foregroundColor(Color(red: 161/255, green: 161/255, blue: 170/255))
                                    .frame(width: 85, alignment: .trailing)
                                
                                Image("img_abstract_geometric_avatar_modern_min_d08e95a0")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color(red: 39/255, green: 39/255, blue: 42/255), lineWidth: 2))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color(red: 24/255, green: 24/255, blue: 27/255).opacity(0.8))
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(red: 39/255, green: 39/255, blue: 42/255).opacity(0.8)),
                            alignment: .bottom
                        )
                        
                        // --- WAVEFORM CANVAS ---
                        ZStack {
                            // Grid lines
                            GeometryReader { geo in
                                Path { path in
                                    let w = geo.size.width
                                    let h = geo.size.height
                                    for x in stride(from: 0, through: w, by: 20) {
                                        path.move(to: CGPoint(x: x, y: 0))
                                        path.addLine(to: CGPoint(x: x, y: h))
                                    }
                                    for y in stride(from: 0, through: h, by: 20) {
                                        path.move(to: CGPoint(x: 0, y: y))
                                        path.addLine(to: CGPoint(x: w, y: y))
                                    }
                                }
                                .stroke(Color.white.opacity(0.03), lineWidth: 1)
                            }
                            
                            Rectangle()
                                .fill(Color(red: 39/255, green: 39/255, blue: 42/255).opacity(0.8))
                                .frame(height: 1)
                            
                            // Highly performant Canvas avoiding State loops
                            Canvas { ctx, size in
                                let now = timeline.date.timeIntervalSinceReferenceDate
                                if engine.lastTimestamp == 0 { engine.lastTimestamp = now }
                                let dt = now - engine.lastTimestamp
                                engine.lastTimestamp = now
                                
                                if engine.isRecording {
                                    engine.timeMs += dt * 1000
                                    let scrollSpeed: Double = 150
                                    let spacing: Double = 3
                                    engine.pixelAccumulator += CGFloat(scrollSpeed * dt)
                                    
                                    while engine.pixelAccumulator >= spacing {
                                        let val = engine.generateSimulatedAudioValue(t: engine.timeOffset)
                                        engine.audioData.append(val)
                                        engine.timeOffset += 0.05
                                        engine.pixelAccumulator -= CGFloat(spacing)
                                        
                                        let maxVisible = Int(size.width / CGFloat(spacing)) + 10
                                        if engine.audioData.count > maxVisible {
                                            engine.audioData.removeFirst()
                                        }
                                    }
                                }
                                
                                if !engine.audioData.isEmpty {
                                    let playheadX = size.width * 0.8
                                    let centerY = size.height / 2
                                    let spacing: CGFloat = 3
                                    var path = Path()
                                    
                                    for (i, amp) in engine.audioData.enumerated().reversed() {
                                        let dataIndex = engine.audioData.count - 1 - i
                                        let xPos = playheadX - CGFloat(i) * spacing - engine.pixelAccumulator
                                        
                                        let ampHeight = amp * (size.height / 2) * 0.85
                                        
                                        if abs(ampHeight) > 0.5 {
                                            path.move(to: CGPoint(x: xPos, y: centerY - ampHeight))
                                            path.addLine(to: CGPoint(x: xPos, y: centerY + ampHeight))
                                        } else {
                                            path.move(to: CGPoint(x: xPos, y: centerY - 0.5))
                                            path.addLine(to: CGPoint(x: xPos, y: centerY + 0.5))
                                        }
                                    }
                                    
                                    let gradient = Gradient(colors: [
                                        Color(red: 6/255, green: 182/255, blue: 212/255).opacity(0.1),
                                        Color(red: 6/255, green: 182/255, blue: 212/255),
                                        Color(red: 59/255, green: 130/255, blue: 246/255),
                                        Color(red: 6/255, green: 182/255, blue: 212/255),
                                        Color(red: 6/255, green: 182/255, blue: 212/255).opacity(0.1)
                                    ])
                                    
                                    ctx.stroke(
                                        path,
                                        with: .linearGradient(gradient, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: size.height)),
                                        style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round)
                                    )
                                }
                            }
                            
                            // Edge overlay gradients
                            HStack(spacing: 0) {
                                LinearGradient(colors: [Color(red: 9/255, green: 9/255, blue: 11/255), .clear], startPoint: .leading, endPoint: .trailing)
                                    .frame(width: 80)
                                Spacer()
                                LinearGradient(colors: [.clear, Color(red: 9/255, green: 9/255, blue: 11/255)], startPoint: .leading, endPoint: .trailing)
                                    .frame(width: 80)
                            }
                            
                            // Playhead line
                            GeometryReader { geo in
                                let playheadX = geo.size.width * 0.8
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 6/255, green: 182/255, blue: 212/255).opacity(0.5))
                                        .frame(width: 2)
                                        .shadow(color: Color(red: 6/255, green: 182/255, blue: 212/255).opacity(0.6), radius: 7, x: 0, y: 0)
                                    
                                    VStack {
                                        Circle()
                                            .stroke(Color(red: 6/255, green: 182/255, blue: 212/255), lineWidth: 2)
                                            .background(Circle().fill(Color(red: 9/255, green: 9/255, blue: 11/255)))
                                            .frame(width: 12, height: 12)
                                            .offset(y: -6)
                                        Spacer()
                                        Circle()
                                            .stroke(Color(red: 6/255, green: 182/255, blue: 212/255), lineWidth: 2)
                                            .background(Circle().fill(Color(red: 9/255, green: 9/255, blue: 11/255)))
                                            .frame(width: 12, height: 12)
                                            .offset(y: 6)
                                    }
                                }
                                .frame(width: 2)
                                .position(x: playheadX, y: geo.size.height / 2)
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .background(Color(red: 9/255, green: 9/255, blue: 11/255))
                        .clipped()
                        
                        // --- FOOTER ---
                        HStack(spacing: 40) {
                            Button(action: {
                                engine.reset()
                                if isRecordingUI {
                                    withAnimation { isRecordingUI = false }
                                    engine.isRecording = false
                                }
                            }) {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color(red: 113/255, green: 113/255, blue: 122/255))
                                    .padding(8)
                            }
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    isRecordingUI.toggle()
                                }
                                engine.isRecording = isRecordingUI
                            }) {
                                ZStack {
                                    Circle()
                                        .stroke(Color(red: 63/255, green: 63/255, blue: 70/255), lineWidth: 4)
                                        .frame(width: 72, height: 72)
                                    
                                    RoundedRectangle(cornerRadius: isRecordingUI ? 12 : 36)
                                        .fill(Color.red)
                                        .frame(width: isRecordingUI ? 32 : 56, height: isRecordingUI ? 32 : 56)
                                        .shadow(color: Color.red.opacity(0.4), radius: 10, x: 0, y: 0)
                                }
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "square.and.arrow.down")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color(red: 113/255, green: 113/255, blue: 122/255))
                                    .padding(8)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color(red: 24/255, green: 24/255, blue: 27/255))
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(red: 39/255, green: 39/255, blue: 42/255)),
                            alignment: .top
                        )
            }
        }
        .background(Color(red: 9/255, green: 9/255, blue: 11/255).edgesIgnoringSafeArea(.all))
    }
}