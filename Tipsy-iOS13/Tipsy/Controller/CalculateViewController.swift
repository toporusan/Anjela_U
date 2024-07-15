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

    var splitCount = 2  // число для начального отображения полей
    var result = ResultModel()
    var textFields: [UITextField] = [] // массив текстовых полей
    var textLabels: [UILabel] = [] // массив нумераций текстовых полей
    var extraTextField: UITextField! // дополнительное поле для общей суммы

    var textFieldValues: [String] = [] // массив с стоимостями блюд + итоговая стоимость общих блюд

    
    
    
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
        setupExtraTextField()
    }

    @IBAction func splitSteper(_ sender: UIStepper) {
        let tips = sender.value
        splitCount = Int(sender.value + 1)
        splitLabel.text = String(format: "%.0F", tips)
        splitingAndTextFields()
        setupExtraTextField()
    }

    @IBAction func tipsSteper(_ sender: UIStepper) {
        let tips = sender.value
        tipsLabel.text = String(format: "%.0F", tips)
    }

    @IBAction func calculateButton(_ sender: Any) {
        print(textFields.count)
        print(textFields[0].text ?? "0.0")
        
        calculation ()
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
                textField.placeholder = "Введите значение"
                textField.delegate = self
                textField.keyboardType = .decimalPad
                peoples.addSubview(textField)
                textFields.append(textField)

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

    func setupExtraTextField() {
        extraTextField = UITextField()
        extraTextField.borderStyle = .roundedRect
        extraTextField.placeholder = "Общее"
        extraTextField.delegate = self
        extraTextField.keyboardType = .decimalPad
        peoples.addSubview(extraTextField)

        // Setting up constraints for the extra text field
        extraTextField.translatesAutoresizingMaskIntoConstraints = false
        extraTextField.leadingAnchor.constraint(equalTo: peoples.leadingAnchor, constant: 30).isActive = true
        extraTextField.trailingAnchor.constraint(equalTo: peoples.trailingAnchor, constant: -20).isActive = true
        extraTextField.topAnchor.constraint(equalTo: peoples.topAnchor, constant: 20).isActive = true
        extraTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Разрешаем только цифры и одну десятичную точку
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)

        // Проверяем, что вводимые символы разрешены
        if !allowedCharacters.isSuperset(of: characterSet) && !(string == ".") {
            return false
        }

        // Проверяем, что уже введенная строка содержит не более одной десятичной точки
        let currentText = textField.text ?? ""
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

        return true
    }


    
    func calculation (){
        // наполняет массив с со стоимостями блюд
        textFieldValues = textFields.compactMap { $0.text }.filter { !$0.isEmpty }
        guard let last = extraTextField.text else{
            extraTextField.text = "0.0"
            return
        }
        textFieldValues.append(last)
        textFieldValues = textFieldValues.filter { !$0.isEmpty }
        
        
        let totalSum = Double(inputBillSum.text ?? "0.0")
        let tips = Int (tipsLabel.text ?? "0")
        var arrayOfSum: [Double] = []
        
        for sum in textFieldValues {
            let s = Double(sum) ?? 0.0
            arrayOfSum.append(s)
        }
        print (arrayOfSum)
        
        
        
        
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
