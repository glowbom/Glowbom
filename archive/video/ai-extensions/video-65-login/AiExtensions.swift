
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Sign Up"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                // This is where the AI-generated SwiftUI view will go
                VStack(spacing: 20) {
                    Image("AppBanner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 100)
                        .clipped()
                        .cornerRadius(8)
                    
                    Text("Sign Up for My App")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Name", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Email", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        // Handle sign up action
                    }) {
                        Text("Sign Up")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold))
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

