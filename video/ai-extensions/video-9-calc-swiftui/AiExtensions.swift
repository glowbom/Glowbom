import SwiftUI

enum CalculatorOperation {
    case addition, subtraction, multiplication, division, none
}

struct CalculatorButton: View {
    let symbol: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(symbol)
                .font(.title)
                .frame(width: 80, height: 80)
                .foregroundColor(Color.black)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(40)
        }
    }
}

struct CalculatorScreen: View {
    @State private var displayValue: String = "0"
    @State private var currentOperation: CalculatorOperation = .none
    @State private var storedValue: Double? = nil

    let buttons: [[String]] = [
        ["C", "+/-", "%", "/"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    func input(digit: String) {
        if displayValue == "0" || displayValue == "0.0" {
            displayValue = digit != "." ? digit : "0."
        } else {
            if digit == "." && displayValue.contains(".") { return }
            displayValue += digit
        }
    }

    func performOperation(_ operation: CalculatorOperation) {
        if let storedVal = storedValue, let displayVal = Double(displayValue) {
            switch currentOperation {
                case .addition:
                    displayValue = "\(storedVal + displayVal)"
                case .subtraction:
                    displayValue = "\(storedVal - displayVal)"
                case .multiplication:
                    displayValue = "\(storedVal * displayVal)"
                case .division:
                    displayValue = storedVal != 0 ? "\(storedVal / displayVal)" : "Error"
                case .none:
                    break
            }
            self.storedValue = Double(displayValue)
            self.currentOperation = operation
        } else {
            storedValue = Double(displayValue)
            currentOperation = operation
            displayValue = "0"
        }
    }

    func clear() {
        displayValue = "0"
        storedValue = nil
        currentOperation = .none
    }

    func toggleSign() {
        if let value = Double(displayValue) {
            displayValue = "\(value * -1)"
        }
    }

    func calculatePercentage() {
        if let value = Double(displayValue) {
            displayValue = "\(value / 100)"
        }
    }

    var body: some View {
        VStack {
            Spacer()
            Text(displayValue)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { buttonSymbol in
                        CalculatorButton(symbol: buttonSymbol) {
                            switch buttonSymbol {
                            case "C":
                                clear()
                            case "+/-":
                                toggleSign()
                            case "%":
                                calculatePercentage()
                            case "/":
                                performOperation(.division)
                            case "X":
                                performOperation(.multiplication)
                            case "-":
                                performOperation(.subtraction)
                            case "+":
                                performOperation(.addition)
                            case "=":
                                performOperation(.none)
                            default:
                                input(digit: buttonSymbol)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.bottom)
    }
}

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Calculator"

    var body: some View {
        CalculatorScreen()
    }
}

struct GlowbyScreen_Previews: PreviewProvider {
    static var previews: some View {
        GlowbyScreen()
    }
}
