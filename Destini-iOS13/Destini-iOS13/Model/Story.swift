//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Storry {
    var story = [
        StoryBrain(title: "You see a fork in the road", right: "Take a right.", left: "Take a left.", id: 0),
        StoryBrain(title: "You see a tiger.", right: "Shout for help.", left: "Play dead.", id: 1),
        StoryBrain(title: "You find tresure chest", right: "Open wdsa.", left: "Check asasd.", id: 2),
        StoryBrain(title: "Y334343434", right: "Open .", left: "asdastraps.", id: 3),
        StoryBrain(title: "Ye chest", right: "Oasdasd it.", left: "Cdasdastraps.", id: 4),
    ]

    var storyId = 0

    func getTitle() -> String {
        let story = story[storyId].title
        return story
    }

    func rightButtonTitle() -> String {
        let rightTitle = story[storyId].right
        return rightTitle
    }

    func leftButtonTitle() -> String {
        let leftTitle = story[storyId].left
        return leftTitle
    }

    mutating func storryIdChanger() {
        if storyId < story.count - 1 {
            return
        }else{
            storyId = 0
        }
    }
}
