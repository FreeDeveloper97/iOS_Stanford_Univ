# Assignment 1 : Concentration

[Assignment1 Pdfπ](https://github.com/FreeDeveloper97/iOS_Stanford_Univ/files/6765028/1.pdf)
## Required Tasks
1. Get the Concentration game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.
* μλ‘­κ² μ μ
2. Add more cards to the game.
* 4*4 λ°°μ΄μΈ 16κ°μ μΉ΄λλ‘ μμ 
3. Add a βNew Gameβ button to your UI which ends the current game in progress and begins a brand new game.
* λ²νΌ μμ± λ° IBAction μ°κ²° μ½λ
```swift
@IBAction func newGame(_ sender: UIButton) {
    emojiChoices[game.theme!] += removedEmojis
    removedEmojis = []
    game.flipCount = 0
    flipCountLabel.text = "Flips: \(game.flipCount)"
    game = Assign1_Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    updateViewFromModel()
}
```
4. Currently the cards in the Model are not randomized (thatβs why matching cards end up always in the same place in our UI). Shuffle the cards in Concentrationβs init() method.
* init λ©μλ λ΄μμ shuffle() ν¨μλ₯Ό ν΅ν΄ λλ€λ°°μΉ
```swift
init(numberOfPairsOfCards: Int) {
    //μλ΅
    // TODO: Shuffle the cards
    cards.shuffle()
    //μλ΅
}
```
5. Give your game the concept of a βthemeβ. A theme determines the set of emoji from which cards are chosen. All emoji in a given theme are related by that theme. See the Hints for example themes. Your game should have at least 6 different themes and should choose a random theme each time a new game starts.
6. Your architecture must make it possible to add a new theme in a single line of code.
* emojiChoices 1μ°¨μ λ°°μ΄ -> 2μ°¨μ λ°°μ΄λ‘ μμ , 1μ°¨μ μΈλ±μ€λ³λ‘ νλ§ κ΅¬ν
```swift
var emojiChoices: [[String]] =
    [["πΌ", "π", "π¦", "πΆ", "π―", "π€", "πΈ", "π·"],
     ["β½οΈ", "π", "π", "βΎοΈ", "π₯", "πΎ", "π", "π"],
     ["π", "π", "π", "π", "π‘", "π±", "π₯Ά", "π"],
     ["π", "π", "π", "π", "πͺ", "π", "π", "π"],
     ["π", "π", "π", "π", "π", "π₯", "π½", "π"],
     ["π", "π", "π", "π", "π", "π₯ͺ", "π±", "π£"]]
```
* κ²μ μμμ theme λλ€μ§μ (0~5 μΈλ±μ€)
```swift
init(numberOfPairsOfCards: Int) {
    //μλ΅
    // TODO: set Theme
    theme = Int(arc4random_uniform(6))
}
```
* theme μΈλ±μ€ μ§μ  ν μΉ΄λ μΆκ°, μ¬μμμ μ κ±°λ μ΄λͺ¨ν°μ½ μ¬μ©μ μν λ°°μ΄ μΆκ°μμ±
```swift
var removedEmojis : [String] = []
func emoji(for card: Assign1_Card) -> String {
    if(emoji[card.identifier] == nil), emojiChoices[game.theme!].count > 0 {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[game.theme!].count)))
        removedEmojis.append(emojiChoices[game.theme!][randomIndex])
        emoji[card.identifier] = emojiChoices[game.theme!].remove(at: randomIndex)
    }
    
    return emoji[card.identifier] ?? "?"
}
```
7. Add a game score label to your UI. Score the game by giving 2 points for every match and penalizing 1 point for every previously seen card that is involved in a mismatch.
* ScoreCountLebel μμ±, μ°κ²°
```swift
@IBOutlet var scoreCountLabel: UILabel!
```
* struct Card λ΄μ λ€μ§νλμ§ μ¬λΆμΈ isFliped λ³μ μΆκ°
```swift
struct Assign1_Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var isFliped = false
    //μλ΅
}
```
* Concentration(ViewMode) λ΄μ λ³μ scoreCount μΆκ°
* μΉ΄λ λμ₯μ΄ λ€μ§ν μνμμ μνμ λ°λΌ μ μ μ‘°μ  (matched : +2)(isFliped μΉ΄λ κ°κ° : -1)
```swift
class Assign1_Concentration
{
    //μλ΅
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
    //μλ΅
}
```
8. Tracking the flip count almost certainly does not belong in your Controller in a proper MVC architecture. Fix that.
* Concentration(ViewMode) λ΄μ λ³μ flipCount μ΄λ
```swift
class Assign1_Concentration
{
    //μλ΅
    var flipCount = 0
    //μλ΅
    func updateFlipCount() {
        self.flipCount += 1
    }
}
```
* ViewController μμ updateFlipCount() λ©μλλ₯Ό ν΅ν΄ μ¦κ°
```swift
@IBAction func touchCard(_ sender: UIButton) {
    game.updateFlipCount()
    //μλ΅
}

//μλ΅
func updateViewFromModel() {
    flipCountLabel.text = "Flips: \(game.flipCount)"
    scoreCountLabel.text = "Score: \(game.scoreCount)"
    //μλ΅
}
```
9. All new UI you add should be nicely laid out and look good in portrait mode on an iPhone X.
* iPhone 12μ μ λμ€λλ‘ μ€μ 
<p align="center" width="100%">
<img width="99%" src = "https://user-images.githubusercontent.com/65349445/124488339-b09b8500-ddea-11eb-9e78-51afbbdca590.png">
</p>
