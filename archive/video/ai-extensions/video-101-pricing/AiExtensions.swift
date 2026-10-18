
import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Pricing Plans"
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView(.vertical, showsIndicators: false) {
                    if horizontalSizeClass == .compact {
                        VStack(spacing: 16) {
                            PricingPlanCard(title: "Free", price: "$0", subtitle: "to start", features: ["Brainstorm with Glowby", "App creation powered by GPT-4", "Claude 3.5 Sorrel", "Llama 3.1 and Gemini 1.5 Pro"], buttonTitle: "Get Started")
                            PricingPlanCard(title: "Creator", price: "$20", subtitle: "Everything in Free, plus", features: ["Unlimited projects", "Unlimited code exports", "All boilerplates", "$10 monthly credits for AI usage"], buttonTitle: "Start Free Trial")
                            PricingPlanCard(title: "Pro", price: "$40", subtitle: "Everything in Creator, plus", features: ["Early feature access", "Priority support", "Testflight access", "$20 monthly credits for AI usage"], buttonTitle: "Start Free Trial")
                        }
                        .padding(.horizontal, 16)
                    } else {
                        HStack(spacing: 16) {
                            PricingPlanCard(title: "Free", price: "$0", subtitle: "to start", features: ["Brainstorm with Glowby", "App creation powered by GPT-4", "Claude 3.5 Sorrel", "Llama 3.1 and Gemini 1.5 Pro"], buttonTitle: "Get Started")
                            PricingPlanCard(title: "Creator", price: "$20", subtitle: "Everything in Free, plus", features: ["Unlimited projects", "Unlimited code exports", "All boilerplates", "$10 monthly credits for AI usage"], buttonTitle: "Start Free Trial")
                            PricingPlanCard(title: "Pro", price: "$40", subtitle: "Everything in Creator, plus", features: ["Early feature access", "Priority support", "Testflight access", "$20 monthly credits for AI usage"], buttonTitle: "Start Free Trial")
                        }
                        .padding(.horizontal, 32)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            Spacer()
        }
    }
}

struct PricingPlanCard: View {
    let title: String
    let price: String
    let subtitle: String
    let features: [String]
    let buttonTitle: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            Text(price)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(subtitle)
                .font(.subheadline)
            ForEach(features, id: \.self) { feature in
                Text(feature)
                    .font(.body)
            }
            Button(action: {
                print("Button tapped")
            }) {
                Text(buttonTitle)
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.green.opacity(0.2))
        .cornerRadius(16)
    }
}
