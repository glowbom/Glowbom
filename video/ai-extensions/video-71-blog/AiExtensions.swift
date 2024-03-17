
import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "IT Blog"

    var body: some View {
        ScrollView {
            VStack {
                // Navigation Bar
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .shadow(radius: 2)
                    HStack {
                        Text("IT Blog")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                        Text("Hi, User")
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                
                // Metric Cards
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    MetricCardView(category: "Technology", count: "24 Posts", color: .green, imageUrl: "https://source.unsplash.com/random/100x100?sig=tech")
                    MetricCardView(category: "Programming", count: "12 Posts", color: .pink, imageUrl: "https://source.unsplash.com/random/100x100?sig=programming")
                    MetricCardView(category: "Innovation", count: "8 Posts", color: .yellow, imageUrl: "https://source.unsplash.com/random/100x100?sig=innovation")
                }
                .padding(.top, 20)
                
                // Divider
                Divider()
                    .padding(.vertical, 20)
                
                // Graph Cards
                GraphCardView(title: "Graph", imageUrl: "https://source.unsplash.com/random/400x200?sig=graph")
                GraphCardView(title: "Chart", imageUrl: "https://source.unsplash.com/random/400x200?sig=chart")
                
                // Footer
                VStack {
                    Text("About")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("IT Blog is a place where you can find the latest news and articles on technology, programming, and innovation.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                    
                    Text("Social")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 20)
                    
                    VStack {
                        Text("Add social link")
                            .foregroundColor(.blue)
                        Text("Add social link")
                            .foregroundColor(.blue)
                    }
                    .font(.body)
                    .padding(.top, 4)
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal)
        }
    }
}

struct MetricCardView: View {
    var category: String
    var count: String
    var color: Color
    var imageUrl: String
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
                Spacer()
                VStack(alignment: .trailing) {
                    Text(category)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(count)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct GraphCardView: View {
    var title: String
    var imageUrl: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
            }
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.bottom, 20)
    }
}

