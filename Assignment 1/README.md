# Assignment 1 : Concentration

[Assignment1 Pdf📎](https://github.com/FreeDeveloper97/iOS_Stanford_Univ/files/6765028/1.pdf)
## Required Tasks
1. Get the Concentration game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.
* 새롭게 제작
2. Add more cards to the game.
* 4*4 배열인 16개의 카드로 수정
3. Add a “New Game” button to your UI which ends the current game in progress and begins a brand new game.
* 버튼 생성 및 IBAction 연결 코드
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
4. Currently the cards in the Model are not randomized (that’s why matching cards end up always in the same place in our UI). Shuffle the cards in Concentration’s init() method.
* init 메소드 내에서 shuffle() 함수를 통해 랜덤배치
```swift
init(numberOfPairsOfCards: Int) {
    //생략
    // TODO: Shuffle the cards
    cards.shuffle()
    //생략
}
```
5. Give your game the concept of a “theme”. A theme determines the set of emoji from which cards are chosen. All emoji in a given theme are related by that theme. See the Hints for example themes. Your game should have at least 6 different themes and should choose a random theme each time a new game starts.
6. Your architecture must make it possible to add a new theme in a single line of code.
* emojiChoices 1차원 배열 -> 2차원 배열로 수정, 1차원 인덱스별로 테마 구현
```swift
var emojiChoices: [[String]] =
    [["🐼", "🐔", "🦄", "🐶", "🐯", "🐤", "🐸", "🐷"],
     ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
     ["😀", "😇", "😎", "😍", "😡", "😱", "🥶", "😈"],
     ["👍", "👎", "👉", "👈", "💪", "👏", "👋", "👊"],
     ["🍏", "🍎", "🍊", "🍉", "🍌", "🥝", "🌽", "🍇"],
     ["🍔", "🍙", "🍗", "🍕", "🍟", "🥪", "🍱", "🍣"]]
```
* 게임 시작시 theme 랜덤지정(0~5 인덱스)
```swift
init(numberOfPairsOfCards: Int) {
    //생략
    // TODO: set Theme
    theme = Int(arc4random_uniform(6))
}
```
* theme 인덱스 지정 후 카드 추가, 재시작시 제거된 이모티콘 사용을 위한 배열 추가생성
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
* ScoreCountLebel 생성, 연결
```swift
@IBOutlet var scoreCountLabel: UILabel!
```
* struct Card 내에 뒤집혔는지 여부인 isFliped 변수 추가
```swift
struct Assign1_Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var isFliped = false
    //생략
}
```
* Concentration(ViewMode) 내에 변수 scoreCount 추가
* 카드 두장이 뒤집힌 상태에서 상태에 따라 점수 조절 (matched : +2)(isFliped 카드 각각 : -1)
```swift
class Assign1_Concentration
{
    //생략
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
    //생략
}
```
8. Tracking the flip count almost certainly does not belong in your Controller in a proper MVC architecture. Fix that.
* Concentration(ViewMode) 내에 변수 flipCount 이동
```swift
class Assign1_Concentration
{
    //생략
    var flipCount = 0
    //생략
    func updateFlipCount() {
        self.flipCount += 1
    }
}
```
* ViewController 에서 updateFlipCount() 메소드를 통해 증가
```swift
@IBAction func touchCard(_ sender: UIButton) {
    game.updateFlipCount()
    //생략
}

//생략
func updateViewFromModel() {
    flipCountLabel.text = "Flips: \(game.flipCount)"
    scoreCountLabel.text = "Score: \(game.scoreCount)"
    //생략
}
```
9. All new UI you add should be nicely laid out and look good in portrait mode on an iPhone X.
* iPhone 12에 잘 나오도록 설정
<p align="center" width="100%">
<img width="99%" src = "https://user-images.githubusercontent.com/65349445/124488339-b09b8500-ddea-11eb-9e78-51afbbdca590.png">
</p>
