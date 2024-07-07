
import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: BMI?

    func getBMIValue() -> String {
        guard let bmi2 = bmi else {
            return "0.0"
        }
        let bmiTo1DecimalPlace = String(format: "%.1F", bmi2.value)
        return bmiTo1DecimalPlace
    }

    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }

    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }

    mutating func calculateBMI(weight: Float, height: Float) {
        let bmiValue = weight / (height * height)

        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: .blue)
            print(bmi?.advice ?? "nil")
        } else if 18.5 < bmiValue && bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Yor weight is normal", color: .green)
            print(bmi?.advice ?? "nil")
        } else {
            bmi = BMI(value: bmiValue, advice: "Stop eating to much", color: .orange)
            print(bmi?.advice ?? "nil")
        }
    }
}
