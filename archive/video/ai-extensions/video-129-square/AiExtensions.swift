


import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Bouncing Ball"
    
    private let squareSize: Double = 300.0
    private let ballDiameter: Double = 40.0
    
    @State private var xPosition: Double = 50
    @State private var yPosition: Double = 50
    @State private var dx: Double = 5
    @State private var dy: Double = 5
    @State private var rotationAngle: Double = 0
    @State var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack {
                Rectangle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: squareSize, height: squareSize)
                    .rotationEffect(Angle(degrees: rotationAngle))
                
                Circle()
                    .fill(Color.yellow)
                    .frame(width: ballDiameter, height: ballDiameter)
                    .position(x: xPosition, y: yPosition)
            }
            .frame(width: squareSize, height: squareSize)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            updateBallPosition()
            rotationAngle += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateBallPosition() {
        let minX = ballDiameter / 2
        let maxX = squareSize - (ballDiameter / 2)
        let minY = ballDiameter / 2
        let maxY = squareSize - (ballDiameter / 2)
        
        xPosition += dx
        yPosition += dy
        
        if xPosition <= minX || xPosition >= maxX {
            dx *= -1
            xPosition += dx // Prevent sticking at edges
        }
        
        if yPosition <= minY || yPosition >= maxY {
            dy *= -1
            yPosition += dy // Prevent sticking at edges
        }
    }
}
