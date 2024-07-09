


import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Search Results"

    @State private var searchText = ""
    @State private var selectedCategory = ""
    @State private var data = [
        Item(title: "Beautiful Nature Scene", category: "nature", imageUrl: "https://picsum.photos/200/300?nature,forest"),
        Item(title: "Urban Cityscape", category: "city", imageUrl: "https://picsum.photos/200/300?city,buildings"),
        Item(title: "Tech Innovation", category: "technology", imageUrl: "https://picsum.photos/200/300?technology,innovation"),
        Item(title: "Mountain Landscape", category: "nature", imageUrl: "https://picsum.photos/200/300?mountains"),
        Item(title: "City Nightlife", category: "city", imageUrl: "https://picsum.photos/200/300?city,night"),
        Item(title: "Futuristic Gadget", category: "technology", imageUrl: "https://picsum.photos/200/300?gadget,technology")
    ]
    
    var filteredData: [Item] {
        data.filter { item in
            (item.title.lowercased().contains(searchText.lowercased()) || searchText.isEmpty) &&
            (item.category == selectedCategory || selectedCategory.isEmpty)
        }
    }

    var body: some View {
        VStack {
            Text("Search Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.trailing, 10)
                
                Picker("Category", selection: $selectedCategory) {
                    Text("All Categories").tag("")
                    Text("Nature").tag("nature")
                    Text("City").tag("city")
                    Text("Technology").tag("technology")
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.trailing, 10)
                
                Button(action: {
                    // Apply filters
                }) {
                    Text("Apply Filters")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 20)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(filteredData) { item in
                        VStack {
                            AsyncImage(url: URL(string: item.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 180, height: 120)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 180, height: 120)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            
                            Text(item.title)
                                .font(.headline)
                                .padding(.top, 5)
                            
                            Text("Category: \(item.category)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let imageUrl: String
}
