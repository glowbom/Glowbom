
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "3D Solar System"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                SolarSystemView()
                    .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SolarSystemView: View {
    @State private var rotation: Double = 0
    @State private var isAnimating = true
    @State private var animationSpeed: Double = 1.0
    @State private var selectedPlanet: Planet?
    
    var body: some View {
        ZStack {
            // Background with starfield
            Rectangle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.3), Color.black]),
                    center: .center,
                    startRadius: 20,
                    endRadius: 200
                ))
                .overlay(
                    StarsView()
                )
            
            // Solar System
            ZStack {
                // Sun
                Circle()
                    .fill(RadialGradient(
                        gradient: Gradient(colors: [Color.yellow, Color.orange]),
                        center: .center,
                        startRadius: 5,
                        endRadius: 15
                    ))
                    .frame(width: 30, height: 30)
                    .shadow(color: .yellow, radius: 10)
                    .scaleEffect(1.0 + sin(rotation * 0.1) * 0.1)
                    .onTapGesture {
                        selectedPlanet = planets[0]
                    }
                
                // Planet orbits
                ForEach(1..<planets.count, id: \.self) { index in
                    let planet = planets[index]
                    
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        .frame(width: planet.orbitRadius * 2, height: planet.orbitRadius * 2)
                    
                    Circle()
                        .fill(planet.color)
                        .frame(width: planet.size, height: planet.size)
                        .shadow(color: planet.color, radius: 3)
                        .offset(y: -planet.orbitRadius)
                        .rotationEffect(.degrees(rotation * planet.speed * animationSpeed))
                        .scaleEffect(selectedPlanet?.name == planet.name ? 1.5 : 1.0)
                        .onTapGesture {
                            selectedPlanet = planet
                        }
                }
            }
            .rotationEffect(.degrees(rotation * 0.1))
            
            // Control panel
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Button(isAnimating ? "Pause" : "Play") {
                            isAnimating.toggle()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text("Speed: \(String(format: "%.1f", animationSpeed))x")
                                .font(.caption)
                                .foregroundColor(.white)
                            
                            Slider(value: $animationSpeed, in: 0.1...3.0, step: 0.1)
                                .frame(width: 80)
                        }
                    }
                    .padding(12)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
                    
                    Spacer()
                }
                
                Spacer()
                
                // Planet info
                if let planet = selectedPlanet {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(planet.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(planet.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(12)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(12)
                    .transition(.opacity)
                }
            }
            .padding()
        }
        .onAppear {
            startAnimation()
        }
        .clipped()
    }
    
    private func startAnimation() {
        withAnimation(.linear(duration: 0.1).repeatForever(autoreverses: false)) {
            rotation = isAnimating ? 360 : 0
        }
    }
    
    private var planets: [Planet] {
        [
            Planet(name: "Sun", color: .yellow, size: 30, orbitRadius: 0, speed: 0, description: "The center of our solar system"),
            Planet(name: "Mercury", color: .gray, size: 8, orbitRadius: 50, speed: 4.0, description: "Closest planet to the Sun"),
            Planet(name: "Venus", color: .orange, size: 10, orbitRadius: 65, speed: 3.0, description: "Hottest planet in the solar system"),
            Planet(name: "Earth", color: .blue, size: 12, orbitRadius: 80, speed: 2.5, description: "Our home planet"),
            Planet(name: "Mars", color: .red, size: 10, orbitRadius: 95, speed: 2.0, description: "The red planet"),
            Planet(name: "Jupiter", color: .brown, size: 20, orbitRadius: 125, speed: 1.5, description: "Largest planet in our solar system"),
            Planet(name: "Saturn", color: .yellow, size: 18, orbitRadius: 155, speed: 1.2, description: "Famous for its rings"),
            Planet(name: "Uranus", color: .cyan, size: 14, orbitRadius: 180, speed: 1.0, description: "Ice giant that rotates on its side"),
            Planet(name: "Neptune", color: .blue, size: 14, orbitRadius: 200, speed: 0.8, description: "Windiest planet in the solar system")
        ]
    }
}

struct Planet {
    let name: String
    let color: Color
    let size: CGFloat
    let orbitRadius: CGFloat
    let speed: Double
    let description: String
}

struct StarsView: View {
    var body: some View {
        Canvas { context, size in
            for _ in 0..<100 {
                let x = Double.random(in: 0...size.width)
                let y = Double.random(in: 0...size.height)
                let opacity = Double.random(in: 0.3...1.0)
                
                context.fill(
                    Path(ellipseIn: CGRect(x: x, y: y, width: 1, height: 1)),
                    with: .color(.white.opacity(opacity))
                )
            }
        }
    }
}
