import SwiftUI

// GlowbyScreen struct is the main view for the Health Tips feature.
struct GlowbyScreen: View {
    // Set enabled to true to make the screen visible in the app
    static let enabled = true
    
    // Set the title for the screen in the app
    static let title = "Health Tips"
    
    // The body property represents the content of the view
    var body: some View {
        HealthTipsView()
    }
}

// HealthTip model to represent each health tip
struct HealthTip: Identifiable {
    var id = UUID()
    var category: String
    var tip: String
    var iconName: String
}

// HealthTipsView is the view that displays the health tips
struct HealthTipsView: View {
    // Sample data for health tips
    let healthTips: [HealthTip] = [
        HealthTip(category: "Nutrition", tip: "Eat more green vegetables.", iconName: "leaf"),
        HealthTip(category: "Exercise", tip: "Take a 10-minute walk daily.", iconName: "figure.walk"),
        HealthTip(category: "Mindfulness", tip: "Meditate for 5 minutes every morning.", iconName: "mindfulness"),
        HealthTip(category: "Sleep", tip: "Stick to a sleep schedule.", iconName: "bed.double")
    ]
    
    var body: some View {
        VStack {
            Text("Daily Health Tips")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(healthTips) { tip in
                        HealthTipCard(tip: tip)
                    }
                }
            }
        }
    }
}

// HealthTipCard is the view for each individual tip card
struct HealthTipCard: View {
    var tip: HealthTip
    
    var body: some View {
        VStack {
            Image(systemName: tip.iconName)
                .font(.largeTitle)
                .foregroundColor(.green)
            
            Text(tip.category)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(tip.tip)
                .font(.body)
                .padding()
        }
        .frame(width: 300, height: 200)
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

// Preview for SwiftUI Canvas
struct HealthTipsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthTipsView()
    }
}
