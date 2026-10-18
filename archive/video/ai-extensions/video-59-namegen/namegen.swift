import SwiftUI

struct ContentView: View {
  @State private var backgroundUrl: URL?
  @State private var names: [String] = []
  @State private var inputText: String = ""

  var body: some View {
    VStack {
      if let backgroundUrl = backgroundUrl {
        // AsyncImage is a SwiftUI view that can load and display an image from a URL.
        // It's new in iOS 15. If you're targeting earlier iOS versions, you'll need to handle image loading differently.
        AsyncImage(url: backgroundUrl) { image in
          image.resizable()
        } placeholder: {
          Color.gray
        }
          .frame(width: 300, height: 300)
          .cornerRadius(10)
        }

        TextField("Enter idea", text: $inputText)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()

        Button(action: generateNames) {
          Text("Generate")
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }

        List(names, id: .self) { name in
          Text(name)
        }
      }
      .onAppear(perform: loadBackground)
  }

  func loadBackground() {
    // Here you would call the Unsplash API to get a random image URL
    // and update the backgroundUrl state property.
    // Replace "YOUR_UNSPLASH_ACCESS_KEY" with your actual Unsplash API key.
    let urlString = "https://api.unsplash.com/photos/random?client_id=YOUR_UNSPLASH_ACCESS_KEY&query=inspiration"
    guard let url = URL(string: urlString) else { return }

    // Omitting the network call for simplicity. You would parse the JSON response
    // and use it to set the backgroundUrl property.
  }

  func generateNames() {
    names = ["Innova", "Creativio", "IdeaStorm", "Conceptualize", "Brainwave"]
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
