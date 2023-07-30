//
//  AiExtensitions.swift
//  Custom
//
//  Created by Jacob Ilin on 7/29/23.
//

import SwiftUI

// MARK: - QuoteGeneratorView
struct QuoteGeneratorView: View {
    // Predefined list of inspirational quotes
    let quotes: [String] = [
        "Believe you can and you're halfway there.",
        "The only way to do great work is to love what you do.",
        "Don't watch the clock; do what it does. Keep going.",
        "The harder you work for something, the greater you'll feel when you achieve it.",
        "Success is not the key to happiness. Happiness is the key to success."
    ]

    // State variable to hold the current quote
    @State private var currentQuote: String

    // Initialize the current quote with a random quote
    init() {
        _currentQuote = State(initialValue: quotes.randomElement() ?? "")
    }

    var body: some View {
        VStack {
            Text(currentQuote)
                .font(.title)
                .padding()
            Button(action: {
                currentQuote = quotes.randomElement() ?? ""
            }) {
                Text("Generate New Quote")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

// This is a designated area where the OpenAI model can add or modify code.
struct GlowbyScreen: View {
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Inspirational Quote Generator"

    // The body of GlowbyScreen
    var body: some View {
        if GlowbyScreen.enabled {
            QuoteGeneratorView()
                .frame(maxWidth: 360)
        } else {
            EmptyView()
        }
    }
}
