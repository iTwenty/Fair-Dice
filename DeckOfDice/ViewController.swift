//
//  ViewController.swift
//  DeckOfDice
//
//  Created by Jaydeep Joshi on 01/06/2018.
//  Copyright © 2018 Helpshift Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private static let diceCharacters: [String] = ["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"]

    @IBOutlet weak var rollBtn: UIButton!
    @IBOutlet weak var dice1View: UIPickerView!
    @IBOutlet weak var dice2View: UIPickerView!

    private var diceRoll: DiceRoll!

    override func viewDidLoad() {
        super.viewDidLoad()
        diceRoll = FairDiceRoll(withResetCount: 5)
        dice1View.dataSource = self
        dice2View.dataSource = self
        dice1View.delegate = self
        dice2View.delegate = self
    }

    @IBAction func didClickRollBtn(_ sender: UIButton) {
        let rolls = diceRoll!.performRoll()
        dice1View.selectRow(10001 + rolls.0, inComponent: 0, animated: true)
        dice2View.selectRow(10001 + rolls.1, inComponent: 0, animated: true)
    }

    // MARK: UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(UInt16.max)
    }

    // MARK: UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.superview?.frame.height ?? 144
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel = view as? UILabel ?? UILabel()
        label.text = ViewController.diceCharacters[row % ViewController.diceCharacters.count]
        label.font = label.font.withSize(72)
        label.textAlignment = .center
        return label
    }
}
