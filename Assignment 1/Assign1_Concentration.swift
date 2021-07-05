//
//  CP2_Concentration.swift
//  Study_Stanford
//
//  Created by Kang Minsang on 2021/06/22.
//

import Foundation

class Assign1_Concentration
{
    var cards: [Assign1_Card] = []
    var theme: Int?
    var flipCount = 0
    var scoreCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                if(cards[index].isMatched == false) {
                    if(cards[matchIndex].isFliped == true) { scoreCount -= 1 }
                    if(cards[index].isFliped == true) { scoreCount -= 1 }
                }
                cards[matchIndex].isFliped = true
                cards[index].isFliped = true
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Assign1_Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
        // TODO: set Theme
        theme = Int(arc4random_uniform(6))
    }
    
    func updateFlipCount() {
        self.flipCount += 1
    }
}
