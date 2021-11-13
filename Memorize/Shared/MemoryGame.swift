//
//  MemoryGame.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/10/24.
//

import Foundation
import SwiftUI

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
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContentFunc: (Int) -> CardContent) {
        cards = []
        // add cards using the passed in func: createCardContentFunc
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContentFunc(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time
        
        // This could give matching bonus points
        // if the user matcheds the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval =  6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)\
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transistions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
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



