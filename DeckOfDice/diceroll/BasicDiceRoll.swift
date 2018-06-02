//
//  BasicDiceRoll.swift
//  DeckOfDice
//
//  Created by Jaydeep Joshi on 02/06/2018.
//  Copyright © 2018 Helpshift Inc. All rights reserved.
//

import Foundation

class BasicDiceRoll: DiceRoll {

    func performRoll() -> (Int, Int) {
        let roll1 = Int(arc4random_uniform(6) + 1)
        let roll2 = Int(arc4random_uniform(6) + 1)
        return (roll1, roll2)
    }

}
