//
//  ViewController.swift
//  Study_Stanford
//
//  Created by Kang Minsang on 2021/06/18.
//

import UIKit

class Assign1_ViewController: UIViewController {
    
    lazy var game = Assign1_Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2) //사용될 때 초기화가 진행, didSet은 사용 불가
    var emojiChoices: [[String]] =
        [["🐼", "🐔", "🦄", "🐶", "🐯", "🐤", "🐸", "🐷"],
         ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
         ["😀", "😇", "😎", "😍", "😡", "😱", "🥶", "😈"],
         ["👍", "👎", "👉", "👈", "💪", "👏", "👋", "👊"],
         ["🍏", "🍎", "🍊", "🍉", "🍌", "🥝", "🌽", "🍇"],
         ["🍔", "🍙", "🍗", "🍕", "🍟", "🥪", "🍱", "🍣"]]
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var flipCountLabel: UILabel!
    @IBOutlet var scoreCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.updateFlipCount()
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        emojiChoices[game.theme!] += removedEmojis
        removedEmojis = []
        game.flipCount = 0
        flipCountLabel.text = "Flips: \(game.flipCount)"
        game = Assign1_Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        updateViewFromModel()
    }
    
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.scoreCount)"
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
    var removedEmojis : [String] = []
    func emoji(for card: Assign1_Card) -> String {
        if(emoji[card.identifier] == nil), emojiChoices[game.theme!].count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[game.theme!].count)))
            removedEmojis.append(emojiChoices[game.theme!][randomIndex])
            emoji[card.identifier] = emojiChoices[game.theme!].remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

