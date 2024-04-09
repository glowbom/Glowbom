import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Best Working Spaces in San Francisco"

    // Unsplash URLs for images
    let imageUrls = [
        URL(string: "https://source.unsplash.com/featured/?office,sanfrancisco"),
        URL(string: "https://source.unsplash.com/featured/?workspace,sanfrancisco"),
        URL(string: "https://source.unsplash.com/featured/?coworking,sanfrancisco")
    ]

    var body: some View {
        ScrollView {
            VStack {
                Text("SF's Best Working Spaces")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.8))
                
                Text("Explore Top Working Spaces")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                
                ForEach(imageUrls.indices, id: \.self) { index in
                    if let url = imageUrls[index] {
                        VStack(alignment: .leading) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(height: 200)
                                         .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                         .frame(height: 200)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200)

                            Text("Space \(index + 1)")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text("Description for Space \(index + 1)") // Replace with actual descriptions
                                .foregroundColor(.gray)
                                .padding(.vertical, 4)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }
                }
                
                Spacer(minLength: 50)
                
                Text("© 2023 Best Working Spaces in San Francisco")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.8))
            }
            .padding()
        }
        .frame(maxWidth: 360)
        .background(Color.gray.opacity(0.1))
    }
}

struct GlowbyScreen_Previews: PreviewProvider {
    static var previews: some View {
        GlowbyScreen()
    }
}
