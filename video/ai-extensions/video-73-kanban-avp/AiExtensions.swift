
import SwiftUI

struct KanbanColumn: Identifiable {
    let id: UUID
    var title: String
    var tasks: [String]
}

struct KanbanTaskView: View {
    var task: String
    
    var body: some View {
        Text(task)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 2)
    }
}

struct KanbanColumnView: View {
    @State var column: KanbanColumn
    
    var body: some View {
        VStack {
            Text("\(column.title) \(column.tasks.count)")
                .font(.headline)
                .padding(.bottom)
            ForEach(column.tasks, id: \.self) { task in
                KanbanTaskView(task: task)
            }
            Button(action: {
                column.tasks.append("Type something...")
            }) {
                Image(systemName: "plus")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Kanban Board"
    
    @State private var columns: [KanbanColumn] = [
        KanbanColumn(id: UUID(), title: "Backlog", tasks: []),
        KanbanColumn(id: UUID(), title: "In Progress", tasks: []),
        KanbanColumn(id: UUID(), title: "Done", tasks: [])
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(columns) { column in
                            KanbanColumnView(column: column)
                        }
                    }
                    .frame(maxWidth: 360)
                }
                Spacer()
            }
            Spacer()
        }
    }
}
