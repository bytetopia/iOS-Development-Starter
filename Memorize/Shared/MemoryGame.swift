//
//  MemoryGame.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/10/24.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContentFunc: (Int) -> CardContent) {
        cards = Array<Card>()
        // add cards using the passed in func: createCardContentFunc
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContentFunc(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}





