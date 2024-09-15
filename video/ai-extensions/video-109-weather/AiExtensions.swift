
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Weather App"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                // This is where the AI-generated SwiftUI view will go
                VStack(alignment: .leading, spacing: 16) {
                    // Header with Temperature
                    HStack {
                        Text("Weather App")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray.opacity(0.8))
                        Spacer()
                        Text("30°C")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.indigo)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)

                    // City List with Animated Bars
                    VStack(spacing: 16) {
                        CityTemperatureView(city: "SF", percentage: 0.7, color: .blue)
                        CityTemperatureView(city: "LA", percentage: 0.5, color: .green)
                        CityTemperatureView(city: "NYC", percentage: 0.8, color: .red)
                        CityTemperatureView(city: "EL PASO", percentage: 0.3, color: .yellow)
                    }

                    // Images from Lorem Picsum
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            CityImageView(cityName: "San Francisco", imageURL: "https://picsum.photos/seed/sf/400/300")
                            CityImageView(cityName: "Los Angeles", imageURL: "https://picsum.photos/seed/la/400/300")
                        }
                        HStack(spacing: 16) {
                            CityImageView(cityName: "New York City", imageURL: "https://picsum.photos/seed/nyc/400/300")
                            CityImageView(cityName: "El Paso", imageURL: "https://picsum.photos/seed/elpaso/400/300")
                        }
                    }
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct CityTemperatureView: View {
    let city: String
    let percentage: CGFloat // Range from 0.0 to 1.0
    let color: Color

    @State private var animatedPercentage: CGFloat = 0

    var body: some View {
        HStack {
            Text(city)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.gray.opacity(0.7))
                .frame(width: 80, alignment: .leading)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 10)
                        .foregroundColor(Color.gray.opacity(0.3))
                    Capsule()
                        .frame(width: geometry.size.width * animatedPercentage, height: 10)
                        .foregroundColor(color)
                        .animation(.easeOut(duration: 2), value: animatedPercentage)
                }
                .onAppear {
                    self.animatedPercentage = percentage
                }
            }
            .frame(height: 10)
        }
        .padding(.horizontal)
    }
}

struct CityImageView: View {
    let cityName: String
    let imageURL: String

    @State private var showOverlay = false

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .aspectRatio(4/3, contentMode: .fill)
            .frame(width: 150, height: 100)
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                Group {
                    if showOverlay {
                        Color.black.opacity(0.5)
                            .cornerRadius(10)
                        Text(cityName)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .animation(.easeInOut, value: showOverlay)
            )
            .onTapGesture {
                withAnimation {
                    showOverlay.toggle()
                }
            }
        }
    }
}
