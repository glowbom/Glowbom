import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Balneário Camboriú FAQ"
    
    @State private var expandedFAQ: Int? = nil
    
    let faqs = [
        FAQ(question: "Where is Balneário Camboriú located?", answer: "Balneário Camboriú is located in the southern Brazilian state of Santa Catarina, on the Atlantic coast."),
        FAQ(question: "What are the main attractions in Balneário Camboriú?", answer: "Key attractions include Central Beach, Unipraias Park (cable car), Cristo Luz monument, Laranjeiras Beach, and Taquarinhas Beach."),
        FAQ(question: "What's the best time to visit Balneário Camboriú?", answer: "The best time to visit is during the summer months (December to March) for beach activities, but spring and fall offer milder weather and fewer crowds."),
        FAQ(question: "How can I get to Balneário Camboriú?", answer: "The nearest airport is Navegantes International Airport, about 30 minutes away. You can also reach the city by bus or car from major Brazilian cities."),
        FAQ(question: "What is the weather like in Balneário Camboriú?", answer: "The city has a subtropical climate with warm summers and mild winters. Average temperatures range from 15°C (59°F) in winter to 30°C (86°F) in summer."),
        FAQ(question: "Are there good restaurants in Balneário Camboriú?", answer: "Yes, the city is known for its diverse culinary scene, offering everything from traditional Brazilian cuisine to international options."),
        FAQ(question: "What water activities are available in Balneário Camboriú?", answer: "You can enjoy swimming, surfing, jet skiing, parasailing, boat tours, and fishing among other water activities."),
        FAQ(question: "Is Balneário Camboriú safe for tourists?", answer: "Generally, yes. However, as with any tourist destination, it's advisable to take standard precautions and be aware of your surroundings."),
        FAQ(question: "What is the nightlife like in Balneário Camboriú?", answer: "The city is famous for its vibrant nightlife, with numerous bars, nightclubs, and live music venues, especially along Avenida Atlântica."),
        FAQ(question: "Are there shopping opportunities in Balneário Camboriú?", answer: "Yes, the city has several shopping centers, including Balneário Camboriú Shopping and Atlântico Shopping, as well as street markets and boutiques."),
        FAQ(question: "What is the population of Balneário Camboriú?", answer: "As of 2021, the estimated population is around 145,000, though this number can swell significantly during peak tourist seasons."),
        FAQ(question: "Is Balneário Camboriú suitable for family vacations?", answer: "Absolutely! The city offers family-friendly beaches, parks, and attractions like the Unipraias Park and oceanarium."),
        FAQ(question: "What languages are commonly spoken in Balneário Camboriú?", answer: "Portuguese is the primary language, but due to tourism, many people in the service industry speak some English and Spanish."),
        FAQ(question: "Are there any cultural or historical sites in Balneário Camboriú?", answer: "While known more for its beaches, the city does have some historical sites like the Santo Amaro Church and the Molhe da Barra Sul."),
        FAQ(question: "What is the currency used in Balneário Camboriú?", answer: "The currency used is the Brazilian Real (BRL). Major credit cards are widely accepted in the city."),
        FAQ(question: "Are there any nearby cities worth visiting from Balneário Camboriú?", answer: "Yes, nearby cities like Itapema, Bombinhas, and Florianópolis are popular for day trips or extended stays."),
        FAQ(question: "What kind of accommodation is available in Balneário Camboriú?", answer: "The city offers a wide range of accommodations, from luxury beachfront hotels to budget-friendly hostels and vacation rentals."),
        FAQ(question: "Is public transportation available in Balneário Camboriú?", answer: "Yes, the city has a good bus system. Taxis and ride-sharing services are also readily available."),
        FAQ(question: "What are some popular events or festivals in Balneário Camboriú?", answer: "The city hosts various events throughout the year, including the Balneário Camboriú Summer Festival and the Santa Catarina Oktoberfest."),
        FAQ(question: "Are there hiking or nature trails near Balneário Camboriú?", answer: "Yes, there are several nearby nature reserves and parks offering hiking trails, such as Parque Unipraias and the Interpraias region.")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 16) {
                        Text("Balneário Camboriú FAQ")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        ForEach(Array(faqs.enumerated()), id: \.element.id) { index, faq in
                            FAQView(faq: faq, isExpanded: expandedFAQ == index) {
                                withAnimation {
                                    if expandedFAQ == index {
                                        expandedFAQ = nil
                                    } else {
                                        expandedFAQ = index
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct FAQView: View {
    let faq: FAQ
    let isExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: onTap) {
                HStack {
                    Text(faq.question)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            
            if isExpanded {
                Text(faq.answer)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}