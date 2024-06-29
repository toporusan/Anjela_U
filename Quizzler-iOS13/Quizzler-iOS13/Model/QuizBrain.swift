//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Toporusan on 28.06.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    var quiz = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia"),
    ]

    var questionNumber = 0
    var scores = 0

    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].correctAnswer {
            scores += 1
            return true
        } else {
            return false
        }
    }

    mutating func getScore() -> Int {
        return scores
    }

    func getQuestinonText() -> String {
        return quiz[questionNumber].q
    }

    func getCurrentAnswers() -> [String] {
           return quiz[questionNumber].a
       }
    
    func getCorrextAnswers() -> String {
           return quiz[questionNumber].correctAnswer
       }


    func getProgress() -> Float {
        let progress = Float(questionNumber) / Float(quiz.count)
        return progress
    }

    mutating func nextQuestion() {
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
            scores = 0
        }
    }
}
