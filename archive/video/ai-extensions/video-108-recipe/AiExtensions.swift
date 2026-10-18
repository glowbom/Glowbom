import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Recipe Creator"

    @State private var ingredients: [Ingredient] = [
        Ingredient(name: "Flour", amount: 50, unit: "g", caloriesPerUnit: 3.64),
        Ingredient(name: "Sugar", amount: 25, unit: "g", caloriesPerUnit: 3.87),
        Ingredient(name: "Butter", amount: 30, unit: "g", caloriesPerUnit: 7.17),
        Ingredient(name: "Eggs", amount: 1, unit: "piece", caloriesPerUnit: 155)
    ]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Recipe Creator")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)

                        ForEach($ingredients) { $ingredient in
                            VStack(alignment: .leading) {
                                Text("\(ingredient.name) (\(ingredient.unit))")
                                    .font(.headline)
                                HStack {
                                    Slider(value: $ingredient.amount, in: 0...100, step: 1)
                                    Text("\(Int(ingredient.amount))")
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Recipe Summary")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.indigo)

                            ForEach(ingredients) { ingredient in
                                Text("\(ingredient.name): \(Int(ingredient.amount)) \(ingredient.unit)")
                            }

                            Text("Total Calories: \(totalCalories)")
                                .font(.headline)
                            Text("Portions: \(portions)")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                        Button("Randomize Ingredients") {
                            randomizeIngredients()
                        }
                        .padding()
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }

    private var totalCalories: Int {
        Int(ingredients.reduce(0) { $0 + $1.amount * $1.caloriesPerUnit })
    }

    private var portions: Int {
        max(1, Int(Double(totalCalories) / 500.0))
    }

    private func randomizeIngredients() {
        for i in ingredients.indices {
            ingredients[i].amount = Double.random(in: 1...100).rounded()
        }
    }
}

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    var amount: Double
    let unit: String
    let caloriesPerUnit: Double
}