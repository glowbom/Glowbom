

import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Paint-like Editor"

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                PaintCanvasView()
                    .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct PaintCanvasView: View {
    @State private var currentTool: DrawingTool = .rectangle
    @State private var drawings: [Drawing] = []
    @State private var currentDrawing: Drawing?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { self.currentTool = .rectangle }) {
                    Text("Rectangle")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: { self.currentTool = .circle }) {
                    Text("Circle")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: { self.drawings.removeAll() }) {
                    Text("Clear")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom)
            
            Canvas { context, size in
                for drawing in drawings {
                    switch drawing.tool {
                    case .rectangle:
                        context.fill(Path(CGRect(origin: drawing.start, size: CGSize(width: drawing.end.x - drawing.start.x, height: drawing.end.y - drawing.start.y))), with: .color(.blue.opacity(0.5)))
                    case .circle:
                        let radius = sqrt(pow(drawing.end.x - drawing.start.x, 2) + pow(drawing.end.y - drawing.start.y, 2))
                        context.fill(Path(ellipseIn: CGRect(x: drawing.start.x, y: drawing.start.y, width: 2 * radius, height: 2 * radius)), with: .color(.green.opacity(0.5)))
                    }
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            let newPoint = value.location
                            if currentDrawing == nil {
                                currentDrawing = Drawing(start: newPoint, end: newPoint, tool: currentTool)
                            } else {
                                currentDrawing?.end = newPoint
                            }
                        }
                        .onEnded { value in
                            if let drawing = currentDrawing {
                                drawings.append(drawing)
                                currentDrawing = nil
                            }
                        })
            .border(Color.black, width: 1)
        }
    }
}

enum DrawingTool {
    case rectangle, circle
}

struct Drawing {
    var start: CGPoint
    var end: CGPoint
    var tool: DrawingTool
}
