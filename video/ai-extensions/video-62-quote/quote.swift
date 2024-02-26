import SwiftUI

// Define a structure for the quote
struct Quote: Identifiable {
    var id = UUID()
    var text: String
    var author: String
}

// The array of quotes
let quotes: [Quote] = [
    Quote(text: "Be yourself; everyone else is already taken.", author: "Oscar Wilde"),
    Quote(text: "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.", author: "Albert Einstein"),
    Quote(text: "So many books, so little time.", author: "Frank Zappa")
    // Add more quotes as needed
]

struct ContentView: View {
    // State for the current quote
    @State private var currentQuote: Quote = quotes.randomElement()!

    // Function to get a random quote
    func getRandomQuote() -> Quote {
        return quotes.randomElement()!
    }

    var body: some View {
        VStack {
            Spacer()
            // Display the quote text
            Text(currentQuote.text)
                .font(.title)
                .padding()
            // Display the author's name
            Text("- \(currentQuote.author)")
                .font(.subheadline)
                .padding()
            Spacer()
            // Button to show the next quote
            Button(action: {
                currentQuote = getRandomQuote()
            }) {
                Text("Next")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

@main
struct DailyQuoteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
