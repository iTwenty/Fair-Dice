//
//  FairDiceRoll.swift
//  DeckOfDice
//
//  Created by Jaydeep Joshi on 02/06/2018.
//  Copyright © 2018 Helpshift Inc. All rights reserved.
//

import Foundation

class FairDiceRoll : DiceRoll {

    public static let resetCountRange: ClosedRange = 1...36
    private static let rollProbabilities: [Int : Int] = [2 : 1, 12 : 1,
                                                         3 : 2, 11 : 2,
                                                         4 : 3, 10 : 3,
                                                         5 : 4, 9 : 4,
                                                         6 : 5, 8 : 5,
                                                         7 : 6]

    private var currentRollProbabilities: [Int : Int]
    private let resetCount: Int
    private let basicDiceRoll: BasicDiceRoll

    init(withResetCount resetCount: Int) {
        if !FairDiceRoll.resetCountRange.contains(resetCount) {
            fatalError("resetCount should be in range \(FairDiceRoll.resetCountRange)")
        }
        self.currentRollProbabilities = FairDiceRoll.rollProbabilities
        self.resetCount = resetCount
        self.basicDiceRoll = BasicDiceRoll()
    }

    func performRoll() -> (Int, Int) {
        let currentPendingRolls = currentRollProbabilities.values.reduce(0) { $0 + $1 }
        if currentPendingRolls <= resetCount {
            currentRollProbabilities = FairDiceRoll.rollProbabilities
        }

        let rolls = basicDiceRoll.performRoll()
        let rollSum = rolls.0 + rolls.1

        if let currentRollProbability = currentRollProbabilities[rollSum],
            currentRollProbability != 0 {
            currentRollProbabilities[rollSum] = currentRollProbability - 1
            return rolls
        } else {
            return performRoll()
        }
    }
}
