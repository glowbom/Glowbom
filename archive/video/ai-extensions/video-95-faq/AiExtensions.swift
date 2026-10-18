

import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "FAQ - Balneário Camboriú"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Frequently Asked Questions about Balneário Camboriú")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    FAQItem(question: "Where is Balneário Camboriú located?", answer: "Balneário Camboriú is a resort city in the southern Brazilian state of Santa Catarina. It's known for its high-rise buildings and beaches, such as Praia Central.")
                    
                    FAQItem(question: "What are the main attractions in Balneário Camboriú?", answer: "The main attractions include the Unipraias Park, Cristo Luz, and the beautiful beaches like Praia dos Amores and Praia Brava.")
                    
                    FAQItem(question: "What's the best time to visit Balneário Camboriú?", answer: "The best time to visit is during the summer months from December to March when the weather is warm and perfect for beach activities.")
                    
                    FAQItem(question: "How can I get to Balneário Camboriú?", answer: "You can get to Balneário Camboriú by flying into the nearest airport, Navegantes Airport, and then taking a bus or taxi to the city.")
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Text(question)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            if isExpanded {
                Text(answer)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
