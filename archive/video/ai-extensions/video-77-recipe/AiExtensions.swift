// A recipe finder app that suggests meals based on ingredients you have.

import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Recipe Finder"

    // State variables to hold the ingredients input and search results
    @State private var ingredients = ""
    @State private var recipes = [Recipe]()

    // A placeholder Recipe struct to simulate fetched recipes
    struct Recipe: Identifiable  {
        var id = UUID()
        var title: String
        var description: String
        var image: String
    }

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Text("Recipe Finder")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Enter ingredient     s separated by commas", text: $ingredients)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                searchRecipes()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(recipes) { recipe in
                        VStack {
                            Image(recipe.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(10)
                            Text(recipe.title)
                                .fontWeight(.bold)
                            Text(recipe.description)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
            }
        }
        .frame(maxWidth: 360)
    }

    // Simulate a search function that fetches recipes based on the ingredients
    func searchRecipes() {
        // Clear previous results
        recipes.removeAll()

        // Split the ingredients string into an array
        let ingredientsArray = ingredients.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }

        // Simulate fetching recipes (here we just use placeholders)
        for i in 0..<3 {
            let recipe = Recipe(title: "Recipe \(i + 1)",
                                description: "This is a placeholder recipe description. It would be replaced with the actual recipe details fetched from an API.",
                                image: "placeholder-image") // Replace with actual image URL or local asset
            recipes.append(recipe)
        }
    }
}
