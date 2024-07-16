

import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Brazil Travel Guide"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Brazil Travel Guide")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("Explore the beauty and culture of Brazil")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Section(header: Text("Top Destinations")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)) {
                            VStack(spacing: 20) {
                                DestinationCard(imageName: "rio-de-janeiro", title: "Rio de Janeiro", description: "Famous for its Copacabana beach, Christ the Redeemer statue, and vibrant Carnival.")
                                DestinationCard(imageName: "amazon-rainforest", title: "Amazon Rainforest", description: "Explore the world's largest tropical rainforest and its incredible biodiversity.")
                                DestinationCard(imageName: "iguazu-falls", title: "Iguazu Falls", description: "Witness the power of these magnificent waterfalls on the border with Argentina.")
                            }
                        }
                        
                        Section(header: Text("Culture")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)) {
                            VStack(alignment: .leading, spacing: 10) {
                                Image("brazil-culture")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 200)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                Text("Brazilian culture is a vibrant mix of Portuguese, African, and indigenous influences. The country is known for its lively music and dance, including samba and bossa nova. Football (soccer) is a national passion, and the country has hosted and won multiple World Cups.")
                                
                                Text("The annual Carnival celebration, especially in Rio de Janeiro, is world-famous for its colorful parades, elaborate costumes, and non-stop partying.")
                            }
                        }
                        
                        Section(header: Text("Travel Tips")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("• Learn some basic Portuguese phrases to communicate with locals.")
                                Text("• Be aware of your surroundings, especially in large cities.")
                                Text("• Try local dishes like feijoada, açaí, and pão de queijo.")
                                Text("• Book accommodations and tours in advance, especially during peak seasons.")
                                Text("• Get necessary vaccinations before your trip, particularly if visiting the Amazon.")
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: 360)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct DestinationCard: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(10)
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 5)
                .foregroundColor(.blue)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
