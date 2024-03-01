import SwiftUI

struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var imageUrl: String
}

struct GlowbyScreen: View {
    // Enabling the screen for display
    static let enabled = true
    static let title = "My Habits"
    
    let habits: [Habit] = [
        Habit(name: "Running", imageUrl: "https://source.unsplash.com/featured/?running"),
        Habit(name: "Gym", imageUrl: "https://source.unsplash.com/featured/?gym"),
        Habit(name: "Coding", imageUrl: "https://source.unsplash.com/featured/?coding"),
        Habit(name: "Reading", imageUrl: "https://source.unsplash.com/featured/?reading"),
        Habit(name: "Meditation", imageUrl: "https://source.unsplash.com/featured/?meditation")
    ]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text(GlowbyScreen.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    List(habits) { habit in
                        HStack {
                            AsyncImage(url: URL(string: habit.imageUrl)!) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            Text(habit.name)
                            Spacer()
                            CheckboxView()
                        }
                        .padding(.vertical)
                    }
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct CheckboxView: View {
    @State private var isChecked: Bool = false

    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square" : "square")
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct GlowbyScreen_Previews: PreviewProvider {
    static var previews: some View {
        GlowbyScreen()
    }
}
