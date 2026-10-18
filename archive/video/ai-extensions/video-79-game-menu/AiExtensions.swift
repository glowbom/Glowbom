
// Please build the game menu similar to this one. The screen should change to something else when user presses the buttons. Thanks


import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Game Menu"

    // State to manage the current screen
    @State private var currentScreen: String? = nil

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            if let screen = currentScreen {
                // Content will be updated by the state change
                Text(screen)
                    .frame(maxWidth: 360)
            } else {
                // Game menu content
                VStack(spacing: 20) {
                    Image("gameTitle") // Placeholder for game title image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 360)
                    
                    Button("Continue") {
                        currentScreen = "Continuing game..."
                    }
                    .frame(maxWidth: 360)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("New Game") {
                        currentScreen = "Starting a new game..."
                    }
                    .frame(maxWidth: 360)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Quit") {
                        currentScreen = "Quitting game. Goodbye!"
                    }
                    .frame(maxWidth: 360)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .frame(maxWidth: 360)
            }
            Spacer()
        }
    }
}

