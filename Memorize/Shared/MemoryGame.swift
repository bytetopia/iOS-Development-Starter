//
//  MemoryGame.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/10/24.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContentFunc: (Int) -> CardContent) {
        cards = Array<Card>()
        // add cards using the passed in func: createCardContentFunc
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContentFunc(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}





