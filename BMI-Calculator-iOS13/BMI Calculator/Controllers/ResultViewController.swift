//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Toporusan on 07.07.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var bmiResult:String?
    var bmiAdvice:String?
    var bmiColor:UIColor?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backgroundColor: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = bmiResult
        adviceLabel.text = bmiAdvice
        backgroundColor.backgroundColor = bmiColor
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     Метод self.dismiss(animated:completion:) используется для закрытия (отмены)
     текущего представленного модально view controller и возврата к предыдущему view controller
    
     animated: true:
     Этот параметр указывает, должно ли закрытие быть анимированным. Если установлено значение true, закрытие будет анимированным.
     Если установлено значение false, закрытие будет мгновенным.
     
     completion: nil:
     Этот параметр принимает замыкание, которое выполняется после завершения анимации закрытия view controller. В данном случае
     установлено значение nil, что означает отсутствие дополнительных действий после завершения закрытия.
     */
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
