import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Group Voting App"

    @State private var candidates = [
        Candidate(name: "Movie Night", image: "https://picsum.photos/seed/movie/200/100"),
        Candidate(name: "Game Night", image: "https://picsum.photos/seed/game/200/100")
    ]
    @State private var groupSize = 5
    @State private var newCandidateName = ""
    @State private var showingAddAlert = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Group Voting App")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        ForEach($candidates) { $candidate in
                            VStack {
                                Text(candidate.name)
                                    .font(.headline)
                                AsyncImage(url: URL(string: candidate.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                Slider(value: $candidate.votes, in: 0...Double(groupSize), step: 1)
                                Text("Votes: \(Int(candidate.votes))")
                            }
                        }
                        
                        HStack {
                            Text("Group Size:")
                            Picker("Group Size", selection: $groupSize) {
                                ForEach(1...20, id: \.self) { size in
                                    Text("\(size)").tag(size)
                                }
                            }
                        }
                        
                        Text("Total Votes: \(totalVotes)")
                        Text("Remaining Votes: \(remainingVotes)")
                        
                        Button("Add Candidate") {
                            showingAddAlert = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .alert("Add New Candidate", isPresented: $showingAddAlert) {
            TextField("Candidate Name", text: $newCandidateName)
            Button("Add") {
                if !newCandidateName.isEmpty {
                    let newCandidate = Candidate(name: newCandidateName, image: "https://picsum.photos/seed/\(newCandidateName)/200/100")
                    candidates.append(newCandidate)
                    newCandidateName = ""
                }
            }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    var totalVotes: Int {
        candidates.reduce(0) { $0 + Int($1.votes) }
    }
    
    var remainingVotes: Int {
        groupSize - totalVotes
    }
}

struct Candidate: Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var votes: Double = 0
}