import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Unit Converter"

    @State private var inputValue: String = ""
    @State private var outputValue: String = ""
    @State private var selectedUnitInput = 0
    @State private var selectedUnitOutput = 0
    let unitTypes = ["Meters", "Kilometers", "Miles", "Feet"]

    var body: some View {
        VStack {
            Text("Unit Converter")
                .font(.largeTitle)

            TextField("Enter value", text: $inputValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Picker("From Unit", selection: $selectedUnitInput) {
                ForEach(0..<unitTypes.count) {
                    Text(self.unitTypes[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Picker("To Unit", selection: $selectedUnitOutput) {
                ForEach(0..<unitTypes.count) {
                    Text(self.unitTypes[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Button("Convert") {
                self.convertUnits()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text(outputValue)
                .font(.title)
                .padding()
        }
        .frame(maxWidth: 360)
    }

    func convertUnits() {
        guard let input = Double(inputValue) else {
            outputValue = "Invalid input"
            return
        }

        let conversionResult = UnitConverter.convert(value: input, from: unitTypes[selectedUnitInput], to: unitTypes[selectedUnitOutput])
        outputValue = String(format: "%.2f", conversionResult)
    }
}

struct UnitConverter {
    static func convert(value: Double, from inputUnit: String, to outputUnit: String) -> Double {
        let conversionFactors = [
            "Meters": 1.0,
            "Kilometers": 0.001,
            "Miles": 0.000621371,
            "Feet": 3.28084
        ]

        let inputInMeters = value * (conversionFactors[inputUnit] ?? 1.0)
        return inputInMeters / (conversionFactors[outputUnit] ?? 1.0)
    }
}

struct GlowbyScreen_Previews: PreviewProvider {
    static var previews: some View {
        GlowbyScreen()
    }
}
