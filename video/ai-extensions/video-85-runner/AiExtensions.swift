import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Endless Runner Game"

    @State private var characterPosition = CGPoint(x: 50, y: 10)
    @State private var obstacles = [Obstacle]()
    @State private var isJumping = false
    @State private var jumpHeight: CGFloat = 0
    @State private var jumpSpeed: CGFloat = 0
    @State private var gameSpeed: CGFloat = 5
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            Text("RUNNER")
                .font(.largeTitle)
                .foregroundColor(.white)
                .position(x: 200, y: 50)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .position(characterPosition)
            ForEach(obstacles) { obstacle in
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                    .position(obstacle.position)
            }
        }
        .onAppear {
            startGame()
        }
        .onTapGesture {
            jump()
        }
    }

    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            gameLoop()
        }
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            createObstacle()
        }
    }

    func createObstacle() {
        let obstacle = Obstacle(position: CGPoint(x: 400, y: 10))
        obstacles.append(obstacle)
    }

    func moveObstacles() {
        for i in 0..<obstacles.count {
            obstacles[i].position.x -= gameSpeed
        }
        obstacles.removeAll { $0.position.x < 0 }
    }

    func jump() {
        if !isJumping {
            isJumping = true
            jumpSpeed = 15
        }
    }

    func updateCharacter() {
        if isJumping {
            jumpHeight += jumpSpeed
            jumpSpeed -= 1
            if jumpHeight <= 0 {
                jumpHeight = 0
                isJumping = false
            }
        }
        characterPosition.y = 10 + jumpHeight
    }

    func gameLoop() {
        moveObstacles()
        updateCharacter()
    }
}

struct Obstacle: Identifiable {
    let id = UUID()
    var position: CGPoint
}
