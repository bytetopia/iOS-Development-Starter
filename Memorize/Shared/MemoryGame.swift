//
//  MemoryGame.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/10/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    // computed property
    private var indexOfFaceUpCard: Int? {
        get {
            // get oneAndOnly faced up card id or return nil
            return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
        }
        set {
            // newValue is predefined in the setter
            cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue)})
        }
    }
    
    mutating func choose(_ card: Card) {
        // find the clicked card, and card should not be faced up, and card should not be already matched
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            // if one card already faced up, check the two matches or not
            if let faceUpId = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[faceUpId].content {
                    // if content matches, set isMatched to true
                    cards[chosenIndex].isMatched = true
                    cards[faceUpId].isMatched = true
                }
                // make the clicked card face up
                cards[chosenIndex].isFaceUp = true
            }
            else {
                // if faced up count != 1, update the indexOfFaceUpCard
                // and in the setter, it will handle the logic to make the clicked card faced up, and make others faced down
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContentFunc: (Int) -> CardContent) {
        cards = []
        // add cards using the passed in func: createCardContentFunc
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContentFunc(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

// extend Array to support get oneAndOnly/nil element
extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}



