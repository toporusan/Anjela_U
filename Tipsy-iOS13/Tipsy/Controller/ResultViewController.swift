//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Toporusan on 09.07.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var splitView: UILabel!
    @IBOutlet weak var tipsView: UILabel!
    @IBOutlet var peoples: UIScrollView!

    var splitCount = 2 // число для начального отображения полей
    var textFields: [UILabel] = [] // массив текстовых полей
    var textLabels: [UILabel] = [] // массив нумераций текстовых полей

    //  Поля для расчетов

    var billTotal = 0.0
    var split = 0
    var tips = 0
    
    var sums: [Double] = []
    var additionalSum = 0.0
    var tipsSum = 0.0

    var result2 = ResultModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        calculate()
        sumsWithAdditional()
        
        splitView.text = String(split)
        tipsView.text = String(tips)
        splitingAndTextFields()
    }
    
    
    @IBAction func recalculateButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func splitingAndTextFields() {
        // Удаление всех предыдущих текстовых полей
        textFields.forEach { $0.removeFromSuperview() }
        textLabels.forEach { $0.removeFromSuperview() }
        textFields.removeAll()
        textLabels.removeAll()

        // Получение количества людей из inputBillSum
        if splitCount != 0, splitCount > 0 {
            var previousTextField: UILabel?

            // Добавление текстовых полей в UIScrollView
            for e in 0 ..< split {
                let textLabel = UILabel()

                textLabel.text = "\(e + 1)."
                textLabel.font = UIFont.systemFont(ofSize: 25)
                textLabel.textColor = .darkGray
                peoples.addSubview(textLabel)
                textLabels.append(textLabel)

                let textField = UILabel()
                textField.text = String(format: "%.2F", sums[e])
                textField.textColor = .darkGray
                textField.font = UIFont.systemFont(ofSize: 30)
                peoples.addSubview(textField)
                textFields.append(textField)

                // Установка ограничений для каждого текстового поля
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.leadingAnchor.constraint(equalTo: peoples.leadingAnchor, constant: 40).isActive = true
                textField.trailingAnchor.constraint(equalTo: peoples.trailingAnchor, constant: -20).isActive = true
                textField.heightAnchor.constraint(equalToConstant: 40).isActive = true

                if let previousTextField = previousTextField {
                    textField.topAnchor.constraint(equalTo: previousTextField.bottomAnchor, constant: 20).isActive = true
                } else {
                    textField.topAnchor.constraint(equalTo: peoples.topAnchor, constant: 20).isActive = true
                }

                // Установка ограничений для каждого текстового поля
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                textLabel.leadingAnchor.constraint(equalTo: peoples.leadingAnchor, constant: 10).isActive = true
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

    
    func calculate() {
        billTotal = Double(result2.billTotal) ?? 0.0
        split = Int(result2.split) ?? 0
        tips = Int(result2.tip) ?? 0
        
        for e in result2.totaLSums {
            sums.append(Double(e.text ?? "0.0") ?? 0.0)
        }
        
        var sumInt = 0
        for e in sums {
            sumInt += Int(e)
        }
        additionalSum = (((billTotal * 100.00) / Double((100 + tips)))) - Double(sumInt)
        tipsSum = billTotal - Double(sumInt) - additionalSum
    }

    func sumsWithAdditional(){
        
        let sum = (additionalSum + tipsSum) / Double(split)
        var arr: [Double] = []
        for e in sums{
            arr.append(e + sum)
        }
        sums = arr
    }
    

    
    
}
