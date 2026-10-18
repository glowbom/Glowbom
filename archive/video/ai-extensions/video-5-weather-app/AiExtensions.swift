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
            CurrentWeatherView()
            Divider()
            WeeklyForecastView()
        }
        .frame(maxWidth: 360)
    }
}

struct CurrentWeatherView: View {
    var body: some View {
        VStack {
            Text("San Francisco")
                .font(.title)
                .fontWeight(.bold)
            Text("🌤")
                .font(.system(size: 96))
            Text("72°")
                .font(.system(size: 64))
                .fontWeight(.medium)
            Text("Sunny")
                .font(.title3)
                .fontWeight(.light)
        }
        .padding()
    }
}

struct WeeklyForecastView: View {
    var body: some View {
        ForEach(0..<7) { _ in
            VStack {
                HStack {
                    Text("MON")
                        .font(.headline)
                    Spacer()
                    Text("🌤")
                        .font(.title2)
                    Spacer()
                    Text("68°/52°")
                        .font(.body)
                }
                .padding(.horizontal)
                Divider()
            }
        }
    }
}
