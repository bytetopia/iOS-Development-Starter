//
//  EmojiMemoryGame.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/10/24.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚄", "🚀", "🚁", "🏍️", "🚗", "🚑", "✈️", "🚌", "🚛", "🚕", "⛵️", "🚴‍♀️", "🚜", "🚲", "🚓", "🚒", "🛸", "🛺", "🚠", "🛵", "🚊", "🚂"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards:10) {pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}

