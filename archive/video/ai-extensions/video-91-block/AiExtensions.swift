
import SwiftUI
import SceneKit

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Block Explorer 3D"

    @State private var gameScene: SCNScene?
    @State private var cameraNode: SCNNode?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    SceneView(scene: gameScene, pointOfView: cameraNode, options: [.allowsCameraControl, .autoenablesDefaultLighting])
                        .frame(width: 360, height: 480)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Controls")
                            .font(.headline)
                        Text("Drag: Look around")
                        Text("Pinch: Zoom")
                        Text("Tap: Place block")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                    Text("Explore a procedurally generated block world. Build, destroy, and discover!")
                        .font(.caption)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .onAppear(perform: setupScene)
    }

    func setupScene() {
        gameScene = SCNScene()
        
        // Create camera
        cameraNode = SCNNode()
        cameraNode?.camera = SCNCamera()
        cameraNode?.position = SCNVector3(x: 0, y: 5, z: 10)
        gameScene?.rootNode.addChildNode(cameraNode!)
        
        // Create ground plane
        let planeGeometry = SCNPlane(width: 100, height: 100)
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = Color.gray
        planeGeometry.materials = [planeMaterial]
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.eulerAngles.x = -.pi / 2
        gameScene?.rootNode.addChildNode(planeNode)
        
        // Generate random blocks
        for _ in 0..<50 {
            let x = Float.random(in: -10...10)
            let y = Float.random(in: 0...5)
            let z = Float.random(in: -10...10)
            createBlock(x: x, y: y, z: z)
        }
    }
    
    func createBlock(x: Float, y: Float, z: Float) {
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let boxMaterial = SCNMaterial()
        boxMaterial.diffuse.contents = Color(red: .random(in: 0...1),
                                             green: .random(in: 0...1),
                                             blue: .random(in: 0...1))
        boxGeometry.materials = [boxMaterial]
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(x: x, y: y, z: z)
        gameScene?.rootNode.addChildNode(boxNode)
    }
}
