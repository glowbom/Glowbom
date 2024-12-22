
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "App"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                SnakeGameView()
                    .frame(maxWidth: 360, maxHeight: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SnakeGameView: View {
    @State private var snake: [CGPoint] = [CGPoint(x: 160, y: 160)]
    @State private var direction: CGPoint = CGPoint(x: 20, y: 0)
    @State private var food: CGPoint = CGPoint(x: 200, y: 200)
    @State private var gameOver: Bool = false
    @State private var timer: Timer?

    let gridSize: CGFloat = 20
    let gameSize: CGFloat = 360

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: gameSize, height: gameSize)
                .border(Color.gray, width: 2)
                .onAppear(perform: startGame)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let horizontal = abs(value.translation.width) > abs(value.translation.height)
                            if horizontal {
                                if value.translation.width > 0 {
                                    if direction.x == 0 {
                                        direction = CGPoint(x: gridSize, y: 0)
                                    }
                                } else {
                                    if direction.x == 0 {
                                        direction = CGPoint(x: -gridSize, y: 0)
                                    }
                                }
                            } else {
                                if value.translation.height > 0 {
                                    if direction.y == 0 {
                                        direction = CGPoint(x: 0, y: gridSize)
                                    }
                                } else {
                                    if direction.y == 0 {
                                        direction = CGPoint(x: 0, y: -gridSize)
                                    }
                                }
                            }
                        }
                )
            
            ForEach(snake, id: \.self) { segment in
                Rectangle()
                    .fill(Color.green)
                    .frame(width: gridSize, height: gridSize)
                    .position(segment)
            }
            
            Rectangle()
                .fill(Color.red)
                .frame(width: gridSize, height: gridSize)
                .position(food)
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"), message: Text("Try again!"), dismissButton: .default(Text("OK"), action: resetGame))
        }
    }
    
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            moveSnake()
        }
    }
    
    func moveSnake() {
        var newHead = CGPoint(x: snake[0].x + direction.x, y: snake[0].y + direction.y)
        
        if newHead.x < 0 { newHead.x = gameSize - gridSize }
        if newHead.x >= gameSize { newHead.x = 0 }
        if newHead.y < 0 { newHead.y = gameSize - gridSize }
        if newHead.y >= gameSize { newHead.y = 0 }
        
        if snake.contains(newHead) {
            timer?.invalidate()
            gameOver = true
            return
        }
        
        snake.insert(newHead, at: 0)
        
        if newHead == food {
            placeFood()
        } else {
            snake.removeLast()
        }
    }
    
    func placeFood() {
        let x = CGFloat(Int.random(in: 0..<Int(gameSize / gridSize))) * gridSize + gridSize / 2
        let y = CGFloat(Int.random(in: 0..<Int(gameSize / gridSize))) * gridSize + gridSize / 2
        food = CGPoint(x: x, y: y)
    }
    
    func resetGame() {
        snake = [CGPoint(x: 160, y: 160)]
        direction = CGPoint(x: 20, y: 0)
        placeFood()
        gameOver = false
        startGame()
    }
}
