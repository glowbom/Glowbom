import SwiftUI
import Charts

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Personal Financial Analyst"

    @State private var revenue: Double = 0
    @State private var users: Double = 0
    @State private var mau: Double = 0
    @State private var showChart = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("Personal Financial Analyst")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)

                    VStack(spacing: 10) {
                        TextField("Revenue", value: $revenue, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
                        TextField("Users", value: $users, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        TextField("Monthly Active Users (MAU)", value: $mau, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)

                    Button("Analyze Data") {
                        showChart = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    if showChart {
                        Chart {
                            BarMark(
                                x: .value("Category", "Revenue"),
                                y: .value("Value", revenue)
                            )
                            .foregroundStyle(Color.red.opacity(0.7))
                            
                            BarMark(
                                x: .value("Category", "Users"),
                                y: .value("Value", users)
                            )
                            .foregroundStyle(Color.blue.opacity(0.7))
                            
                            BarMark(
                                x: .value("Category", "MAU"),
                                y: .value("Value", mau)
                            )
                            .foregroundStyle(Color.yellow.opacity(0.7))
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .background(Color(.systemGray6))
    }
}