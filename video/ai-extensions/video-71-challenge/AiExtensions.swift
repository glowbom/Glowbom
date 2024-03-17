
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Daily Challenge App"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    @State private var challengeText: String = "Click the button to see today's challenge!"
    @State private var challengeImage: UIImage? = UIImage(systemName: "photo")
    
    let challenges = [
        "Write a letter to your future self.",
        "Take a walk and photograph something interesting.",
        "Learn to cook a new recipe.",
        "Read a chapter of a book you've been putting off.",
        "Do a random act of kindness.",
        "Practice meditation for 10 minutes.",
        "Declutter your workspace."
    ]
    
    func getRandomChallenge() -> String {
        return challenges.randomElement() ?? "Challenge yourself!"
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    if let image = challengeImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 200)
                            .cornerRadius(8)
                            .padding(.bottom, 4)
                    }
                    Text(challengeText)
                        .font(.headline)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .frame(maxWidth: 360)
                    Button(action: {
                        challengeText = getRandomChallenge()
                        challengeImage = UIImage(named: "https://source.unsplash.com/random/600x400?sig=\(Int.random(in: 1...1000))")
                    }) {
                        Text("Challenge")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}
