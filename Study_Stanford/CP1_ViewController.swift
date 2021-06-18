//
//  ViewController.swift
//  Study_Stanford
//
//  Created by Kang Minsang on 2021/06/18.
//

import UIKit

class CP1_ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet { flipCountLabel.text = "Flips: \(flipCount)" }
    }
    var emojiChoices: [String] = ["👻", "🎃", "👻", "🎃"]
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("cardNumber = \(cardNumber)")
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if(button.currentTitle == emoji) {
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.white
        }
    }
}

