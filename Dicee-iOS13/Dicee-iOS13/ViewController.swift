//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var diceImageView1: UIImageView!
    @IBOutlet var diceImageView2: UIImageView!
    @IBOutlet var scores: UILabel!

    var leftDiceNumber = 0
    var leftDiceNumber1 = 0
    var rightDiceNumber = 0
    var rightDiceNumber1 = 0
    var scoresTotal = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func rollButton(_ sender: UIButton) {
        let imageArray = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
        
        leftDiceNumber = Int.random(in: 0 ... imageArray.count - 1) // задали диапазон рандомных чисел от 0 до размера массива минус 1 (6-1=5)
        rightDiceNumber = Int.random(in: 0 ... imageArray.count - 1)

        let scoreArray = [1, 2, 3, 4, 5, 6]  // создали массив для того чтобы брать оттуда числа для поля scores
        leftDiceNumber1 = scoreArray[leftDiceNumber]
        rightDiceNumber1 = scoreArray[rightDiceNumber]

        diceImageView1.image = imageArray[leftDiceNumber]
        diceImageView2.image = imageArray[rightDiceNumber]

        scoresTotal = String(rightDiceNumber1 + leftDiceNumber1)
        scores.text = String("Your score is:  \(scoresTotal)")
        
    }
}
