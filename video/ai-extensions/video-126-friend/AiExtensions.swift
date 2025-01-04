import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Gratitude Companion"
    
    @State private var currentPrompt = "Click generate for your daily gratitude prompt"
    @State private var promptDescription = "Let's practice gratitude together!"
    @State private var promptHistory: [String] = []
    
    let gratitudePrompts = [
        "What made you smile today?",
        "Name three things you're thankful for right now.",
        "Who has positively influenced your life recently?",
        "What's a simple pleasure you enjoyed today?",
        "What's something beautiful you saw today?",
        "What's a challenge you're grateful for overcoming?",
        "What's a skill or ability you're thankful to have?",
        "What's something in nature that brought you joy today?"
    ]
    
    let promptDescriptions = [
        "Take a moment to reflect on the joy in your day.",
        "Sometimes the smallest things bring the greatest happiness.",
        "Acknowledging those who make a difference matters.",
        "Life's simple moments often bring the most joy.",
        "Beauty surrounds us in unexpected places.",
        "Growth comes from overcoming obstacles.",
        "Your unique abilities are worth celebrating.",
        "Nature has a way of lifting our spirits."
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Image("glowbyimage:3D cute friendly robot character with a warm smile and gentle eyes, soft pastel colors")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                        
                        Text("Your Gratitude Companion")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                        
                        VStack(spacing: 16) {
                            Image("glowbyimage:3D illustration of a magical floating journal with glowing gratitude words, ethereal lighting")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 160)
                                .cornerRadius(12)
                            
                            Text(currentPrompt)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            
                            Text(promptDescription)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            
                            Button(action: generateNewPrompt) {
                                Text("Generate New Prompt")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.indigo)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        
                        if !promptHistory.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Previous Prompts")
                                    .font(.headline)
                                
                                ForEach(promptHistory, id: \.self) { prompt in
                                    Text(prompt)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(15)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    func generateNewPrompt() {
        let randomIndex = Int.random(in: 0..<gratitudePrompts.count)
        currentPrompt = gratitudePrompts[randomIndex]
        promptDescription = promptDescriptions[randomIndex]
        
        if !promptHistory.contains(currentPrompt) {
            promptHistory.insert(currentPrompt, at: 0)
            if promptHistory.count > 5 {
                promptHistory.removeLast()
            }
        }
    }
}