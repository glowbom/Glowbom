

import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Notifications"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    Text("Notifications")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    NotificationView(imageName: "meeting", title: "Meeting", description: "Board meeting at 2 PM today", time: "10 min ago", buttonText: "Read")
                    NotificationView(imageName: "email", title: "Email", description: "New investment opportunity from VC firm", time: "30 min ago", buttonText: "Read")
                    NotificationView(imageName: "alert", title: "Alert", description: "Stock price up 5% this morning", time: "1 hour ago", buttonText: "Mark as read")
                    NotificationView(imageName: "message", title: "Message", description: "CFO: Q3 financial reports ready for review", time: "2 hours ago", buttonText: "Read")
                    NotificationView(imageName: "invitation", title: "Invitation", description: "Tech conference keynote speaker invitation", time: "3 hours ago", buttonText: "Mark as read")
                    NotificationView(imageName: "news", title: "News", description: "Your company featured in TechCrunch", time: "4 hours ago", buttonText: "Mark as read")
                    NotificationView(imageName: "reminder", title: "Reminder", description: "Employee town hall tomorrow at 11 AM", time: "5 hours ago", buttonText: "Mark as read")
                    NotificationView(imageName: "message", title: "Message", description: "HR: New diversity initiative proposal", time: "6 hours ago", buttonText: "Mark as read")
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
}

struct NotificationView: View {
    var imageName: String
    var title: String
    var description: String
    var time: String
    var buttonText: String

    var body: some View {
        HStack {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                // Action for button
            }) {
                Text(buttonText)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
