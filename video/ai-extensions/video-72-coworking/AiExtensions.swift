
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Best Working Spaces in San Francisco"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("SF's Best Working Spaces")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                
                Text("Explore Top Working Spaces")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.vertical)
                
                ForEach(1...3, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Image("workspace\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(8)
                        
                        Text("Space \(index)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.vertical, 2)
                        
                        Text("Description for Space \(index)")
                            .foregroundColor(.secondary)
                            .padding(.bottom, 4)
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    .padding(.bottom, 4)
                }
                
                Spacer(minLength: 50)
                
                Text("© 2023 Best Working Spaces in San Francisco")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: 360)
    }
}

// Note: Image names "workspace1", "workspace2", "workspace3" should be replaced with actual images of the working spaces.
// The text "Description for Space \(index)" should be replaced with actual descriptions of the working spaces.
