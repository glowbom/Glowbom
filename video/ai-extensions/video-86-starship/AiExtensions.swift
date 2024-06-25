import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Starship Lander"

    @State private var landerPosition = CGPoint(x: 160, y: 20)
    @State private var landerRotation = 0.0
    @State private var velocityY = 0.0
    @State private var score = 0
    @State private var gameOver = false
    @State private var gameTimer: Timer?

    let gameWidth: CGFloat = 320
    let gameHeight: CGFloat = 384

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: gameWidth, height: gameHeight)
                        .overlay(
                            Rectangle()
                                .stroke(Color.blue, lineWidth: 4)
                        )

                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 96, height: 16)
                        .position(x: gameWidth / 2, y: gameHeight - 8)

                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 32, height: 48)
                        .rotationEffect(.degrees(landerRotation))
                        .position(landerPosition)

                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .position(x: gameWidth / 2, y: 20)
                }
                .frame(width: gameWidth, height: gameHeight)
                .clipped()

                Spacer()
            }

            HStack {
                Button(action: { move(left: true) }) {
                    Text("←")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: { move(left: false) }) {
                    Text("→")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            Button(action: restartGame) {
                Text("Restart")
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .frame(maxWidth: 360)
        .onAppear(perform: startGame)
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"), message: Text("Your score: \(score)"), dismissButton: .default(Text("OK"), action: restartGame))
        }
    }

    func startGame() {
        landerPosition = CGPoint(x: gameWidth / 2, y: 20)
        landerRotation = 0
        velocityY = 0
        score = 0
        gameOver = false

        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            updateGame()
        }
    }

    func updateGame() {
        velocityY += 0.1
        landerPosition.y += velocityY

        if landerPosition.y > gameHeight - 48 {
            gameTimer?.invalidate()
            if abs(landerPosition.x - gameWidth / 2) < 48 && abs(landerRotation) < 15 {
                score += 100
            } else {
                gameOver = true
            }
        }
    }

    func move(left: Bool) {
        if left {
            landerPosition.x -= 5
            landerRotation = max(landerRotation - 5, -30)
        } else {
            landerPosition.x += 5
            landerRotation = min(landerRotation + 5, 30)
        }
    }

    func restartGame() {
        gameTimer?.invalidate()
        startGame()
    }
}