

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
        ScrollView {
            VStack {
                // Hero Section
                ZStack {
                    AsyncImage(url: URL(string: "https://source.unsplash.com/random/1600x900"))
    
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                    VStack {
                        Text("BEAUTIFUL APPS AND ADDICTIVE GAMES")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                        Text("We create beautiful apps and games with no-code tools.")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(height: 300)
                
                // Products Section
                VStack(spacing: 20) {
                    Text("PRODUCTS")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 20)
                    
                    VStack(spacing: 20) {
                        // Product 1
                        VStack {
                            AsyncImage(url: URL(string: "https://source.unsplash.com/random/400x300?game"))
                            
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                            Text("U.S. Citizenship Test App")
                                .font(.system(size: 20, weight: .semibold))
                            Text("Citizenship Test with Audio.")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        // Product 2
                        VStack {
                            AsyncImage(url: URL(string: "https://source.unsplash.com/random/400x300?game"))
                    
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                            Text("Office Story")
                                .font(.system(size: 20, weight: .semibold))
                            Text("Build your own game company.")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        // Product 3
                        VStack {
                            AsyncImage(url: URL(string: "https://source.unsplash.com/random/400x300?puzzle"))
                                
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                            Text("Glow Puzzle")
                                .font(.system(size: 20, weight: .semibold))
                            Text("The best game about connecting the dots.")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color.gray.opacity(0.1))
                
                // Footer
                VStack {
                    Text("Â© 2023 Indie Dev Company. All rights reserved.")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                }
                .background(Color.gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}



