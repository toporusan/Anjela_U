//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Toporusan on 09.07.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var peoples: UIScrollView!

    var splitCount = 13// число для начального отображения полей
    var textFields: [UILabel] = [] // массив текстовых полей
    var textLabels: [UILabel] = [] // массив нумераций текстовых полей
    var extraTextField: UILabel! // дополнительное поле для общей суммы
    
    //  Поля для расчетов
    
    var billTotal = 0.0
    var split = 0
    var tips = 0
    var sums: [Double] = []
    var additionalSum = 0.0
    
    var result2 = ResultModel()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        splitingAndTextFields()
        calculate()
        
    }

    func splitingAndTextFields() {
        //Удаление всех предыдущих текстовых полей
        textFields.forEach { $0.removeFromSuperview() }
        textLabels.forEach { $0.removeFromSuperview() }
        textFields.removeAll()
        textLabels.removeAll()

        // Получение количества людей из inputBillSum
        if splitCount != 0, splitCount > 0 {
            var previousTextField: UILabel?

            // Добавление текстовых полей в UIScrollView
            for e in 0 ..< splitCount {
                let textLabel = UILabel()

                textLabel.text = "\(e + 1)."
                textLabel.textColor = .darkGray
                peoples.addSubview(textLabel)
                textLabels.append(textLabel)

                let textField = UILabel()
                textField.text = "__суммы__"
                textField.textColor = .darkGray
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
    
    func calculate (){
        
        billTotal = Double (result2.billTotal) ?? 0.0
        split = Int (result2.split) ?? 0
        tips = Int (result2.tip) ?? 0
        additionalSum = Double(result2.totalResult) ?? 0.0
        
        for e in result2.totaLSums{
            sums.append(Double (e.text ?? "0.0") ?? 0.0)
        }
        
        print(billTotal)
        print(split)
        print(tips)
        print(additionalSum)
        print(sums)
        
        
    }
    
    

}
