
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Video Hosting App"

    @State private var searchText = ""
    @State private var videos = [
        Video(title: "Video Title 1", thumbnail: "https://source.unsplash.com/random/300x169"),
        Video(title: "Video Title 2", thumbnail: "https://source.unsplash.com/random/300x169?sig=1"),
        Video(title: "Video Title 3", thumbnail: "https://source.unsplash.com/random/300x169?sig=2"),
        Video(title: "Video Title 4", thumbnail: "https://source.unsplash.com/random/300x169?sig=3")
        // More videos can be added here...
    ]

    var filteredVideos: [Video] {
        if searchText.isEmpty {
            return videos
        } else {
            return videos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 20)], spacing: 20) {
                    ForEach(filteredVideos, id: \.self) { video in
                        VideoCard(video: video)
                    }
                }
            }
            .padding()
        }
    }
}

struct Video: Hashable {
    let title: String
    let thumbnail: String
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
    }
}

struct VideoCard: View {
    let video: Video

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: video.thumbnail)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            
            Text(video.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}

