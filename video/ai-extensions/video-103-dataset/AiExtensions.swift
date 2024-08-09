import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Profile Showcase"
    
    let profiles = [
        Profile(name: "Jacob Ilin", twitter: "https://twitter.com/jacobilin", image: "https://pbs.twimg.com/profile_images/1662261768432025602/evWd6Is7_400x400.jpg"),
        Profile(name: "Emin Israfil", twitter: "https://twitter.com/EminIsrafil", image: "https://pbs.twimg.com/profile_images/1715131385185492992/EFe1XsvQ_400x400.jpg")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Profile Showcase")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.bottom, 10)
                        
                        ForEach(profiles, id: \.name) { profile in
                            ProfileCard(profile: profile)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
                .shadow(radius: 5)
                Spacer()
            }
            Spacer()
        }
        .background(
            AsyncImage(url: URL(string: "https://picsum.photos/1920/1080?blur=5")) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let twitter: String
    let image: String
}

struct ProfileCard: View {
    let profile: Profile
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: profile.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(profile.name)
                    .font(.headline)
                Link("Twitter Profile", destination: URL(string: profile.twitter)!)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}