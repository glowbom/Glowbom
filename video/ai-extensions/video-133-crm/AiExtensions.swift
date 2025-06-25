import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "CRM Dashboard"

    // Replace this with the generated SwiftUI view
    // Ensure the generated content shows up in the center of the screen
    // within a frame with a maximum width of 360.0.
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            Text("CRM Dashboard")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.blue)
                            Text("Manage your customer relationships effectively")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)

                        // Stats Cards
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                StatCard(title: "Total Customers", value: "1,234", color: .blue)
                                StatCard(title: "New Leads", value: "56", color: .green)
                            }
                            HStack(spacing: 16) {
                                StatCard(title: "Open Deals", value: "18", color: .yellow)
                                StatCard(title: "Customer Satisfaction", value: "92%", color: .purple)
                            }
                        }
                        .padding(.horizontal)

                        // Recent Activity
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Activity")
                                .font(.system(size: 20, weight: .semibold))
                            ActivityItem(icon: "C", title: "Customer Meeting", subtitle: "Scheduled with John Doe - 10 minutes ago", color: .blue)
                            ActivityItem(icon: "R", title: "Report Generated", subtitle: "Q3 Sales Report - 2 hours ago", color: .green)
                            ActivityItem(icon: "I", title: "Issue Resolved", subtitle: "Ticket #1234 - 1 day ago", color: .yellow)
                            ActivityItem(icon: "M", title: "Marketing Campaign", subtitle: "Email blast sent - 3 days ago", color: .purple)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)

                        // Sales Performance Placeholder
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Sales Performance")
                                .font(.system(size: 20, weight: .semibold))
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                                .cornerRadius(8)
                                .overlay(Text("Sales Chart Placeholder").foregroundColor(.gray))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)

                        // Customer Locations Placeholder
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Customer Locations")
                                .font(.system(size: 20, weight: .semibold))
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                                .cornerRadius(8)
                                .overlay(Text("Map Placeholder").foregroundColor(.gray))
                            Text("Visual representation of customer distribution")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)

                        // Recent Customers Table
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Recent Customers")
                                .font(.system(size: 20, weight: .semibold))
                            CustomerRow(name: "John Doe", email: "john@example.com", status: "Active", statusColor: .green)
                            Divider()
                            CustomerRow(name: "Jane Smith", email: "jane@example.com", status: "Pending", statusColor: .yellow)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                }
                .frame(maxWidth: 360)
                .background(Color.gray.opacity(0.1))
                Spacer()
            }
            Spacer()
        }
    }
}

// StatCard Component
struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(color)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// ActivityItem Component
struct ActivityItem: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Text(icon)
                .font(.system(size: 16, weight: .bold))
                .frame(width: 32, height: 32)
                .background(color.opacity(0.2))
                .foregroundColor(color)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

// CustomerRow Component
struct CustomerRow: View {
    let name: String
    let email: String
    let status: String
    let statusColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                Text(email)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(status)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor.opacity(0.2))
                .foregroundColor(statusColor)
                .clipShape(Capsule())
            Button(action: {
                // View details action
            }) {
                Text("View Details")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}