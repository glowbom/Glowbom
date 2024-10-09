
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Food Ordering App"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                // AI-generated SwiftUI view starts here
                VStack(spacing: 20) {
                    // Navigation Bar
                    HStack {
                        Text("Ortibpos")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        HStack(spacing: 20) {
                            Button(action: {}) {
                                Text("Home")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            }
                            Button(action: {}) {
                                Text("Salsa")
                                    .foregroundColor(.gray)
                            }
                            Button(action: {}) {
                                Text("Caligous")
                                    .foregroundColor(.gray)
                            }
                            Button(action: {}) {
                                Text("Shop")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Featured Image Section
                    VStack(alignment: .leading, spacing: 10) {
                        Image("featured_food")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Experience the exquisite taste of our signature chicken and tomato salad on a crispy base.")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // Buttons
                    HStack(spacing: 10) {
                        Button(action: {}) {
                            Text("Cast Africa")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        Button(action: {}) {
                            Text("Carter & Ribs")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        Button(action: {}) {
                            Text("Sort Here")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    // Correct Ternepy Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Correct Ternepy")
                            .font(.title2)
                            .fontWeight(.bold)
                        HStack(spacing: 15) {
                            Image("salad")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            Text("A delightful mix of fresh greens and vegetables to refresh your palate.")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)

                    // Canse Mulierond Button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "house.fill")
                            Text("Canse Mulierond")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    // Bottom Navigation Icons
                    HStack(spacing: 40) {
                        VStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(.blue)
                            Text("Home")
                                .foregroundColor(.blue)
                        }
                        VStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("Search")
                                .foregroundColor(.gray)
                        }
                        VStack {
                            Image(systemName: "cart.fill")
                                .foregroundColor(.gray)
                            Text("Cart")
                                .foregroundColor(.gray)
                        }
                        VStack {
                            Image(systemName: "person.circle")
                                .foregroundColor(.gray)
                            Text("Profile")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.bottom)
                }
                .frame(maxWidth: 360)
                // AI-generated SwiftUI view ends here
                Spacer()
            }
            Spacer()
        }
    }
}
