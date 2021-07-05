//
//  ViewController.swift
//  Study_Stanford
//
//  Created by Kang Minsang on 2021/06/18.
//

import UIKit

class CP3_ViewController: UIViewController {
    
    lazy var game = CP3_Concentration(numberOfPairsOfCards: numberOfPairsOfCards) //사용될 때 초기화가 진행, didSet은 사용 불가
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2 //읽기 전용 변수
    }
    var flipCount = 0 {
        didSet { flipCountLabel.text = "Flips: \(flipCount)" }
    }
    var emojiChoices: [String] = ["👻", "🎃", "😈", "👽", "💀", "🤢", "🤡", "💩"]
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices { //배열 -> 셀수있는 구간
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    
    var emoji : [Int:String] = [:]
    func emoji(for card: CP2_Card) -> String {
        if(emoji[card.identifier] == nil), emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

