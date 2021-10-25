//
//  EmojiMemoryGame.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/10/24.
//

import SwiftUI


class EmojiMemoryGame {
    
    static let emojis = ["🚄", "🚀", "🚁", "🏍️", "🚗", "🚑", "✈️", "🚌", "🚛", "🚕", "⛵️", "🚴‍♀️", "🚜", "🚲", "🚓", "🚒", "🛸", "🛺", "🚠", "🛵", "🚊", "🚂"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) {pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}

