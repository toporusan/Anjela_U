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

    var result = ResultModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputBillSum.delegate = self
        inputBillSum.keyboardType = .decimalPad
    }

    @IBAction func persentAsignBtn(_ sender: UIButton) {
        switch sender.currentTitle {
        case "0%": result.tip = 0
            break
        case "10%": result.tip = 10
            break
        default: result.tip = 20
        }
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
    

    
}
