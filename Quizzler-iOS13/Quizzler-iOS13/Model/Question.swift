//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Toporusan on 27.06.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct Question{
    var q: String
    var a: [String]
    var correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        self.q = q
        self.a = a
        self.correctAnswer = correctAnswer
    }
    
    
}
