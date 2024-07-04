import SwiftUI
import SceneKit

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Solar System 3D"

    @State private var isRotating = true
    @State private var cameraPosition = SCNVector3(x: 0, y: 0, z: 50)

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    SceneView(
                        scene: createSolarSystemScene(),
                        pointOfView: createCamera(),
                        options: [.allowsCameraControl, .autoenablesDefaultLighting]
                    )
                    .frame(height: 300)
                    .cornerRadius(10)

                    HStack {
                        Button(action: resetView) {
                            Text("Reset View")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }

                        Button(action: toggleRotation) {
                            Text(isRotating ? "Stop Rotation" : "Start Rotation")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.top)
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }

    func createSolarSystemScene() -> SCNScene {
        let scene = SCNScene()

        let sun = createPlanet(radius: 5, texture: "sun")
        scene.rootNode.addChildNode(sun)

        let planets = [
            (name: "Mercury", radius: 0.5, distance: 10, speed: 0.05),
            (name: "Venus", radius: 0.8, distance: 15, speed: 0.035),
            (name: "Earth", radius: 1, distance: 20, speed: 0.025),
            (name: "Mars", radius: 0.7, distance: 25, speed: 0.015)
        ]

        for planet in planets {
            let orbit = SCNNode()
            scene.rootNode.addChildNode(orbit)

            let planetNode = createPlanet(radius: planet.radius, texture: planet.name.lowercased())
            planetNode.position = SCNVector3(x: Float(planet.distance), y: 0, z: 0)
            orbit.addChildNode(planetNode)

            let rotationAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 1 / planet.speed)
            let rotationForever = SCNAction.repeatForever(rotationAction)
            orbit.runAction(rotationForever)

            let selfRotationAction = SCNAction.rotateBy(x: 0, y: CGFloat(2 * Double.pi), z: 0, duration: 0.5)
            let selfRotationForever = SCNAction.repeatForever(selfRotationAction)
            planetNode.runAction(selfRotationForever)
        }

        return scene
    }

    func createPlanet(radius: Double, texture: String) -> SCNNode {
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: texture) ?? UIColor.gray
        let node = SCNNode(geometry: sphere)
        return node
    }

    func createCamera() -> SCNNode {
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = cameraPosition
        return cameraNode
    }

    func resetView() {
        cameraPosition = SCNVector3(x: 0, y: 0, z: 50)
    }

    func toggleRotation() {
        isRotating.toggle()
        // In a real implementation, you would pause/resume the SCNScene here
    }
}