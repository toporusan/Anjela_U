//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var choise_1: UIButton!
    @IBOutlet var choise_2: UIButton!
    @IBOutlet var choise_3: UIButton!

    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnsewr = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnsewr)

        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }

        quizBrain.nextQuestion()

        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }

    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestinonText()
        progressBar.progress = quizBrain.getProgress()
        buttonTitle(quizBrain.getCurrentAnswers())
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        choise_1.backgroundColor = UIColor.clear
        choise_2.backgroundColor = UIColor.clear
        choise_3.backgroundColor = UIColor.clear
    }

    func buttonTitle( _ arr: [String]) {
        choise_1.setTitle(arr[0], for: .normal)
        choise_2.setTitle(arr[1], for: .normal)
        choise_3.setTitle(arr[2], for: .normal)
    }
}
