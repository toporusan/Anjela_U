//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var inputBillSum: UITextField!
    @IBOutlet var peoples: UIScrollView!

    @IBOutlet var tipsLabel: UILabel!
    @IBOutlet var splitLabel: UILabel!
    @IBOutlet var splitStepper: UIStepper!
    @IBOutlet var tipsStepper: UIStepper!
    @IBOutlet var calculateButton: UIButton!

    var textFields: [UITextField] = [] // массив текстовых полей
    var textLabels: [UILabel] = [] // массив нумераций текстовых полей
    var splitCount = 2 // число для начального отображения полей

    var result1: ResultModel = ResultModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputBillSum.delegate = self
        inputBillSum.keyboardType = .decimalPad

        splitStepper.minimumValue = 2
        splitStepper.maximumValue = 100
        splitStepper.stepValue = 1
        splitStepper.value = 2

        tipsStepper.minimumValue = 0
        tipsStepper.maximumValue = 100
        tipsStepper.stepValue = 1
        tipsStepper.value = 15

        splitingAndTextFields()

        // Добавление цели и действия для текстового поля inputBillSum
        inputBillSum.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // Изначально кнопка неактивна
        calculateButton.backgroundColor = .gray
        calculateButton.isEnabled = false
        

    }

    @IBAction func splitSteper(_ sender: UIStepper) {
        let tips = sender.value
        splitCount = Int(sender.value)
        splitLabel.text = String(format: "%.0F", tips)
        
        splitingAndTextFields()
    }

    @IBAction func tipsSteper(_ sender: UIStepper) {
        let tips = sender.value
        tipsLabel.text = String(format: "%.0F", tips)
    }

    @IBAction func calculateButton(_ sender: Any) {
        performSegue(withIdentifier: "totalCalcultion", sender: self)
    }

    func splitingAndTextFields() {
        // Удаление всех предыдущих текстовых полей
        textFields.forEach { $0.removeFromSuperview() }
        textLabels.forEach { $0.removeFromSuperview() }
        textFields.removeAll()
        textLabels.removeAll()

        // Получение количества людей из inputBillSum
        if splitCount != 0, splitCount > 0 {
            var previousTextField: UITextField?

            // Добавление текстовых полей в UIScrollView
            for e in 0 ..< splitCount {
                let textLabel = UILabel()
                textLabel.text = "\(e + 1)."
                textLabel.textColor = .lightGray
                peoples.addSubview(textLabel)
                textLabels.append(textLabel)

                let textField = UITextField()
                textField.borderStyle = .roundedRect
                textField.placeholder = "Основное блюдо"
                textField.delegate = self
                textField.keyboardType = .decimalPad
                peoples.addSubview(textField)
                textFields.append(textField)
                
                // Добавление цели и действия для каждого нового текстового поля
                textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

                // Установка ограничений для каждого текстового поля
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.leadingAnchor.constraint(equalTo: peoples.leadingAnchor, constant: 30).isActive = true
                textField.trailingAnchor.constraint(equalTo: peoples.trailingAnchor, constant: -20).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 40).isActive = true

                if let previousTextField = previousTextField {
                    textField.topAnchor.constraint(equalTo: previousTextField.bottomAnchor, constant: 20).isActive = true
                } else {
                    textField.topAnchor.constraint(equalTo: peoples.topAnchor, constant: 20).isActive = true
                }

                // Установка ограничений для каждого текстового поля
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.leadingAnchor.constraint(equalTo: peoples.leadingAnchor, constant: 0).isActive = true
                textLabel.trailingAnchor.constraint(equalTo: peoples.trailingAnchor, constant: -20).isActive = true
                textLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

                if let previousTextField = previousTextField {
                    textLabel.topAnchor.constraint(equalTo: previousTextField.bottomAnchor, constant: 20).isActive = true
                } else {
                    textLabel.topAnchor.constraint(equalTo: peoples.topAnchor, constant: 20).isActive = true
                }

                previousTextField = textField
            }

            // Установка ограничений для последнего текстового поля

            if let lastTextField = textFields.last {
                lastTextField.bottomAnchor.constraint(equalTo: peoples.bottomAnchor, constant: -20).isActive = true
            }

        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Разрешаем только цифры и одну десятичную точку
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)

        // Проверяем, что вводимые символы разрешены
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }

        // Получаем текущий текст
        let currentText = textField.text ?? ""

        // Создаем новую строку с вводимыми символами
        let newString = (currentText as NSString).replacingCharacters(in: range, with: string)

        // Ограничиваем длину текста до 15 символов
        let maxLength = 15
        if newString.count > maxLength {
            return false
        }

        // Проверяем, что в строке не больше одной десятичной точки
        let components = newString.components(separatedBy: ".")
        if components.count > 2 {
            return false
        }

        // Проверка на ввод нескольких нулей подряд
        if currentText == "0" && string == "0" {
            return false
        }

        // Проверка на ввод нуля перед любой другой цифрой (например, 05)
        if currentText == "" && string == "0" {
            return true
        }
        if currentText.hasPrefix("0") && !newString.hasPrefix("0.") {
            return false
        }

        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultViewController

        result1.billTotal = inputBillSum.text ?? "0.0"
        result1.split = splitLabel.text ?? "0"
        result1.tip = tipsLabel.text ?? "0"
        result1.totaLSums = textFields

        resultViewController.result2 = result1
    }
    
    
        // данный метод проверяет заполненный ли поля а также меняет цвет кнопки на зелёный если все поля заполнены
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Проверяем все текстовые поля, включая inputBillSum
        var allFieldsFilled = true

        if inputBillSum.text?.isEmpty == true {
            allFieldsFilled = false
        }

        for textField in textFields {
            if textField.text?.isEmpty == true {
                allFieldsFilled = false
                break
            }
        }

        // Активируем или деактивируем кнопку и изменяем ее цвет в зависимости от результата
        if allFieldsFilled {
            calculateButton.isEnabled = true
            calculateButton.backgroundColor = UIColor(hex: "#00B06B")
        } else {
            calculateButton.isEnabled = false
            calculateButton.backgroundColor = .gray
        }
    }
}




// расширение для того чтобы приложение работало по хекс цвету
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
