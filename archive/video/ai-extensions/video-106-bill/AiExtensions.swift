import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Bill Splitter"

    @State private var totalBill: Double = 100.0
    @State private var people: [Person] = [
        Person(share: 33.33),
        Person(share: 33.33),
        Person(share: 33.34)
    ]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Bill Splitting App")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                        
                        Image(systemName: "dollarsign.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .foregroundColor(.indigo)
                        
                        TextField("Total Bill Amount ($)", value: $totalBill, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
                        ForEach(people.indices, id: \.self) { index in
                            PersonShareView(person: $people[index], index: index, totalBill: totalBill)
                        }
                        
                        SummaryView(totalBill: totalBill, remainingAmount: remainingAmount)
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .background(Color(.systemGray6))
    }
    
    private var remainingAmount: Double {
        totalBill - people.reduce(0) { $0 + (totalBill * $1.share / 100) }
    }
}

struct Person: Identifiable {
    let id = UUID()
    var share: Double
}

struct PersonShareView: View {
    @Binding var person: Person
    let index: Int
    let totalBill: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Person \(index + 1) Share (%)")
                .font(.caption)
                .foregroundColor(.secondary)
            Slider(value: $person.share, in: 0...100, step: 0.01)
            HStack {
                Text("\(person.share, specifier: "%.2f")%")
                Spacer()
                Text("$\((totalBill * person.share / 100), specifier: "%.2f")")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}

struct SummaryView: View {
    let totalBill: Double
    let remainingAmount: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Summary")
                .font(.headline)
                .foregroundColor(.indigo)
            Text("Total: $\(totalBill, specifier: "%.2f")")
                .foregroundColor(.indigo)
            Text("Remaining: $\(remainingAmount, specifier: "%.2f")")
                .foregroundColor(.indigo)
        }
        .padding()
        .background(Color(.systemIndigo).opacity(0.1))
        .cornerRadius(10)
    }
}