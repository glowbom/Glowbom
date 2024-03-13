
import SwiftUI

struct GlowbyScreen: View {
    @State private var lightIsOn = false
    @State private var temperature: Double = 70
    @State private var homeStatus = "Home"

    static let enabled = true
    static let title = "Smart Home App"

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    // Light Control
                    VStack {
                        HStack {
                            Text("Light Control")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(lightIsOn ? "On" : "Off")
                                .foregroundColor(.gray)
                        }
                        Button(action: {
                            lightIsOn.toggle()
                        }) {
                            Text("Toggle Light")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(lightIsOn ? Color.yellow : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                    // Temperature Control
                    VStack {
                        HStack {
                            Text("Temperature")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(Int(temperature))°F")
                        }
                        Slider(value: $temperature, in: 60...80, step: 1)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                    // Security Camera
                    VStack {
                        Text("Security Camera")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom)
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)

                    // Home/Away Toggle
                    VStack {
                        HStack {
                            Text("Home/Away")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            Text(homeStatus)
                                .foregroundColor(.gray)
                        }
                        Button(action: {
                            homeStatus = homeStatus == "Home" ? "Away" : "Home"
                        }) {
                            Text("Toggle Status")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(homeStatus == "Home" ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .padding()
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: 360)
    }
}

