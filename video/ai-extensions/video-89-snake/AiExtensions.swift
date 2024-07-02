import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Snake Game"
    
    @State private var snake: [(Int, Int)] = [(20, 20)]
    @State private var food: (Int, Int) = (0, 0)
    @State private var direction: Direction = .right
    @State private var score: Int = 0
    @State private var isGameOver: Bool = false
    @State private var isGameRunning: Bool = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    enum Direction {
        case up, down, left, right
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text("Snake Game")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    
                    Text("Score: \(score)")
                        .font(.title2)
                        .padding()
                    
                    ZStack {
                        Color.black
                        
                        ForEach(snake, id: \.0) { part in
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 10, height: 10)
                                .position(x: CGFloat(part.0 * 10), y: CGFloat(part.1 * 10))
                        }
                        
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .position(x: CGFloat(food.0 * 10), y: CGFloat(food.1 * 10))
                    }
                    .frame(width: 300, height: 300)
                    .border(Color.white, width: 2)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                let translation = gesture.translation
                                if abs(translation.width) > abs(translation.height) {
                                    direction = translation.width > 0 ? .right : .left
                                } else {
                                    direction = translation.height > 0 ? .down : .up
                                }
                            }
                    )
                    
                    HStack {
                        ForEach(["⬆️", "⬇️", "⬅️", "➡️"], id: \.self) { arrow in
                            Button(action: {
                                switch arrow {
                                case "⬆️": direction = .up
                                case "⬇️": direction = .down
                                case "⬅️": direction = .left
                                case "➡️": direction = .right
                                default: break
                                }
                            }) {
                                Text(arrow)
                                    .font(.system(size: 30))
                                    .padding()
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        if !isGameRunning {
                            startGame()
                        }
                    }) {
                        Text(isGameRunning ? "Game Running" : "Start Game")
                            .padding()
                            .background(isGameRunning ? Color.gray : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(isGameRunning)
                    .padding()
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .onReceive(timer) { _ in
            if isGameRunning {
                moveSnake()
            }
        }
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("Game Over"),
                  message: Text("Your score: \(score)"),
                  dismissButton: .default(Text("OK")) {
                    resetGame()
                  })
        }
    }
    
    func startGame() {
        isGameRunning = true
        generateFood()
    }
    
    func resetGame() {
        snake = [(20, 20)]
        direction = .right
        score = 0
        isGameOver = false
        isGameRunning = false
    }
    
    func moveSnake() {
        var head = snake.first!
        switch direction {
        case .up: head.1 -= 1
        case .down: head.1 += 1
        case .left: head.0 -= 1
        case .right: head.0 += 1
        }
        
        if head.0 < 0 || head.0 >= 30 || head.1 < 0 || head.1 >= 30 || snake.contains(where: { $0 == head }) {
            isGameOver = true
            isGameRunning = false
            return
        }
        
        snake.insert(head, at: 0)
        
        if head == food {
            score += 10
            generateFood()
        } else {
            snake.removeLast()
        }
    }
    
    func generateFood() {
        repeat {
            food = (Int.random(in: 0..<30), Int.random(in: 0..<30))
        } while snake.contains { $0 == food }
    }
}