//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet var hightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!

    @IBOutlet var hightSlider: UISlider!
    @IBOutlet var weightSlider: UISlider!


    var calculatorBrain = CalculatorBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderHeight(_ sender: UISlider) {
        let hight = String(format: "%.2F", sender.value)
        hightLabel.text = "\(hight)m"
    }

    @IBAction func sliderWeight(_ sender: UISlider) {
        let weight = String(format: "%.0F", sender.value)
        weightLabel.text = "\(weight)Kg"
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = hightSlider.value
        let weight = weightSlider.value

        calculatorBrain.calculateBMI(weight: weight, height: height)

        performSegue(withIdentifier: "goToResults", sender: self) // данный метод перемещает нас на следующее окно
        // withIdentifier: "goToResults" - идентификатор данного плавного перехода на другое окно
        // sender: self - опрпеделяет кто данного перехода - отправитель: сам класс(CalculateViewController), поэтому поставили self
    }

    // Для того чтобы настроить переход используется данный метод:

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiResult = calculatorBrain.getBMIValue()
            destinationVC.bmiAdvice = calculatorBrain.getAdvice()
            destinationVC.bmiColor = calculatorBrain.getColor() 
        }
    }
}
