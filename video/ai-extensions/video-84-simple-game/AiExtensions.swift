
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Home and Casino Game"

    @State private var characterPosition: CGFloat = 0

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 360, height: 240)
                        .border(Color.gray, width: 4)
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                characterPosition = -100
                            }
                        }) {
                            Text("Home")
                                .frame(width: 80, height: 80)
                                .background(Color.yellow)
                                .border(Color.gray, width: 4)
                        }
                        Spacer()
                        Button(action: {
                            withAnimation {
                                characterPosition = 100
                            }
                        }) {
                            Text("Casino")
                                .frame(width: 80, height: 80)
                                .background(Color.yellow)
                                .border(Color.gray, width: 4)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                        .border(Color.gray, width: 4)
                        .offset(x: characterPosition)
                }
                Spacer()
            }
            Spacer()
        }
    }
}
