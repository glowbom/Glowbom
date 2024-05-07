
import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let image: URL
}

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Contact Manager"

    @State private var contacts = [
        Contact(name: "Alice Johnson", email: "alice@example.com", image: URL(string: "https://source.unsplash.com/random/100x100?sig=1")!),
        Contact(name: "Bob Smith", email: "bob@example.com", image: URL(string: "https://source.unsplash.com/random/100x100?sig=2")!),
        Contact(name: "Carol Williams", email: "carol@example.com", image: URL(string: "https://source.unsplash.com/random/100x100?sig=3")!),
        Contact(name: "David Brown", email: "david@example.com", image: URL(string: "https://source.unsplash.com/random/100x100?sig=4")!)
    ]
    @State private var searchText = ""

    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.email.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            List(filteredContacts) { contact in
                HStack {
                    AsyncImage(url: contact.image)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.trailing, 4)

                    VStack(alignment: .leading) {
                        Text(contact.name)
                            .font(.headline)
                        Text(contact.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .frame(maxWidth: 360)
    }
}
