import SwiftUI

struct GlowbyScreen: View {
    // This is a designated area where the OpenAI model can add or modify code.
    // To enable the screen, set this value to true
    // If it is false, the screen won't be visible in the app
    static let enabled = true

    // Change the title according to the assigned task
    // This will be the name of the screen in the app
    static let title = "Scientific Calculator"

    @State private var display = "0"

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text(display)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                    
                    let buttons: [[String]] = [
                        ["Rad", "|", "Deg", "x!", "(", ")", "%", "AC"],
                        ["Inv", "sin", "ln", "7", "8", "9", "+", "⌫"],
                        ["π", "cos", "log", "4", "5", "6", "×", "÷"],
                        ["e", "tan", "√", "1", "2", "3", "−", "Ans"],
                        ["EXP", "xʸ", "0", ".", "="]
                    ]
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    self.buttonTapped(button)
                                }) {
                                    Text(button)
                                        .font(.title)
                                        .frame(width: 60, height: 60)
                                        .background(button == "=" ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(button == "=" ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }
    
    func buttonTapped(_ button: String) {
        switch button {
        case "AC":
            display = "0"
        case "⌫":
            if display.count > 1 {
                display.removeLast()
            } else {
                display = "0"
            }
        case "=":
            calculateResult()
        default:
            if display == "0" {
                display = button
            } else {
                display += button
            }
        }
    }
    
    func calculateResult() {
        let expression = NSExpression(format: display.replacingOccurrences(of: "×", with: "*").replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "π", with: "\(Double.pi)").replacingOccurrences(of: "e", with: "\(M_E)"))
        if let result = expression.expressionValue(with: nil, context: nil) as? Double {
            display = String(result)
        } else {
            display = "Error"
        }
    }
}