//
//  StoryBrain.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct StoryBrain{
    var title: String
    var right: String
    var left: String
    var id: Int
    
    init(title: String, right: String, left: String, id: Int) {
        self.title = title
        self.right = right
        self.left = left
        self.id = id
    }
    
}
