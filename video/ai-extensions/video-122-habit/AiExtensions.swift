
import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Habit Tracker"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    @State private var habits: [Habit] = [
        Habit(name: "Exercise", isCompleted: false),
        Habit(name: "Read", isCompleted: false),
        Habit(name: "Meditate", isCompleted: false)
    ]
    
    @State private var newHabitName = ""

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("Habit Tracker")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    ForEach(habits.indices, id: \.self) { index in
                        HStack {
                            Image(systemName: habits[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(habits[index].isCompleted ? .green : .gray)
                                .onTapGesture {
                                    habits[index].isCompleted.toggle()
                                }
                            
                            TextField("Enter habit", text: $habits[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disabled(habits[index].isCompleted)
                            
                        }
                    }
                    
                    HStack {
                        TextField("New Habit", text: $newHabitName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Add Habit") {
                            addHabit()
                        }
                    }
                    
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
    
    func addHabit() {
           if !newHabitName.isEmpty {
               habits.append(Habit(name: newHabitName, isCompleted: false))
               newHabitName = ""
           }
    }
}

struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool
}
