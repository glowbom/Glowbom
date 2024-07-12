


import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Interactive Calendar"

    @State private var selectedEvent: Event? = nil

    struct Event: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let image: String
    }

    let events: [Int: Event] = [
        1: Event(title: "Event 1", description: "Meeting with investors", image: "https://picsum.photos/200/300?business"),
        7: Event(title: "Event 2", description: "Product launch", image: "https://picsum.photos/200/300?tech")
    ]

    var body: some View {
        VStack {
            Text("Calendar")
                .font(.largeTitle)
                .bold()
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(1...31, id: \.self) { day in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 50)
                        if let event = events[day] {
                            VStack {
                                Text("\(day)")
                                Text(event.title)
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        selectedEvent = event
                                    }
                            }
                        } else {
                            Text("\(day)")
                        }
                    }
                }
            }
            .padding()

            if let event = selectedEvent {
                VStack {
                    Text(event.title)
                        .font(.title)
                        .bold()
                    Text(event.description)
                        .padding()
                    AsyncImage(url: URL(string: event.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    Button("Close") {
                        selectedEvent = nil
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
        .frame(maxWidth: 360)
    }
}
