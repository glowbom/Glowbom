
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Music Game"

    @State private var currentScreen: Screen = .menu

    enum Screen {
        case menu, popup, gig
    }

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                // This is where the AI-generated SwiftUI view will go
                content
                    .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch currentScreen {
        case .menu:
            menuView
        case .popup:
            popupView
        case .gig:
            gigView
        }
    }

    private var menuView: some View {
        VStack {
            Text("Choose Your Song")
                .font(.largeTitle)
                .padding(.bottom, 20)

            songView(imageURL: "https://source.unsplash.com/random/200x200?music", songName: "Song Name", artistName: "Artist Name")
            songView(imageURL: "https://source.unsplash.com/random/200x200?concert", songName: "Song Name", artistName: "Artist Name")

            Button(action: {
                currentScreen = .gig
            }) {
                Text("Perform Gig")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)

            Button(action: {
                // Add your back action here
            }) {
                Text("Back")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }

    private func songView(imageURL: String, songName: String, artistName: String) -> some View {
        VStack {
            AsyncImage(url: URL(string: imageURL))
                .frame(width: 200, height: 200)
                .padding(.bottom, 10)
            Text("Score: 0000")
            Text(songName)
            Text(artistName)
            Button(action: {
                currentScreen = .popup
            }) {
                Text("Play")
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
    }

    private var popupView: some View {
        VStack {
            Text("You can perform a gig upon completing at least 3 songs")
                .padding(.bottom, 20)
            Button(action: {
                currentScreen = .menu
            }) {
                Text("Okay")
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
        }
        .background(Color.black.opacity(0.75))
        .cornerRadius(10)
        .padding()
    }

    private var gigView: some View {
        VStack {
            Text("Performing Gig...")
                .font(.largeTitle)
                .padding(.bottom, 20)
            Text("Get ready to rock the stage!")
                .padding(.bottom, 20)
            Button(action: {
                currentScreen = .menu
            }) {
                Text("Back")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
