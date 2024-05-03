
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Social Media Feed"

    // State to manage the view type
    @State private var isListView = true

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            TextField("What's on your mind?", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            HStack {
                Button("Live video") {}
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Photo/video") {}
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Life event") {}
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Divider()
            HStack {
                Text("Posts")
                    .font(.title)
                    .bold()
                Spacer()
                Button("List view") {
                    isListView = true
                }
                .foregroundColor(isListView ? .blue : .primary)
                Button("Grid view") {
                    isListView = false
                }
                .foregroundColor(isListView ? .primary : .blue)
            }
            .padding()
            if isListView {
                ListView()
            } else {
                GridView()
            }
        }
        .frame(maxWidth: 360)
    }
}

struct ListView: View {
    var body: some View {
        VStack {
            PostView(name: "Jacob Ilín", time: "6h ago", imageName: "office", description: "Just updated my workspace with a new monitor!")
            PostView(name: "Glowbom", time: "Apr 20", imageName: "tech", description: "Meet Glowby, the first draw-to-code GenAI assistant for software creation.")
        }
    }
}

struct GridView: View {
    var body: some View {
        VStack {
            HStack {
                PostView(name: "Jacob Ilín", time: "6h ago", imageName: "office", description: "Just updated my workspace with a new monitor!")
                PostView(name: "Glowbom", time: "Apr 20", imageName: "tech", description: "Meet Glowby, the first draw-to-code GenAI assistant for software creation.")
            }
        }
    }
}

struct PostView: View {
    var name: String
    var time: String
    var imageName: String
    var description: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(.headline)
                Spacer()
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(8)
                .frame(height: 200)
            Text(description)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
