import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Abstract Art Gallery"

    @State private var isDrawing = false
    @State private var lines: [Line] = []
    @State private var currentLine: Line?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Abstract Art Gallery")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)

                        Text("Featured Artwork")
                            .font(.title2)
                            .fontWeight(.semibold)

                        HStack {
                            SVGView()
                                .frame(width: 150, height: 150)
                            
                            AsyncImage(url: URL(string: "https://picsum.photos/seed/abstract1/300/200")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                        Text("Gallery")
                            .font(.title2)
                            .fontWeight(.semibold)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(1...6, id: \.self) { i in
                                AsyncImage(url: URL(string: "https://picsum.photos/seed/abstract\(i)/300/200")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                        Text("Interactive Canvas")
                            .font(.title2)
                            .fontWeight(.semibold)

                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .border(Color.gray, width: 1)
                                .frame(width: 300, height: 200)

                            Canvas { context, size in
                                for line in lines {
                                    var path = Path()
                                    path.addLines(line.points)
                                    context.stroke(path, with: .color(.black), lineWidth: 2)
                                }
                            }
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        let newPoint = value.location
                                        if currentLine == nil {
                                            currentLine = Line(points: [newPoint])
                                            lines.append(currentLine!)
                                        } else {
                                            currentLine?.points.append(newPoint)
                                        }
                                    }
                                    .onEnded { _ in
                                        currentLine = nil
                                    }
                            )
                        }
                        .frame(width: 300, height: 200)

                        Button(action: {
                            lines.removeAll()
                        }) {
                            Text("Clear Canvas")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: 360)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct Line: Identifiable {
    let id = UUID()
    var points: [CGPoint]
}

struct SVGView: View {
    @State private var progress: CGFloat = 0

    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 25, y: 50))
                path.addQuadCurve(to: CGPoint(x: 75, y: 50), control: CGPoint(x: 50, y: 25))
                path.addQuadCurve(to: CGPoint(x: 125, y: 50), control: CGPoint(x: 100, y: 75))
            }
            .trim(from: 0, to: progress)
            .stroke(Color.black, lineWidth: 2)
            .animation(.easeInOut(duration: 5), value: progress)
        }
        .onAppear {
            progress = 1
        }
    }
}