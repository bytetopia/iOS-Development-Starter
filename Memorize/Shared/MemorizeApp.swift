//
//  MemorizeApp.swift
//  Shared
//
//  Created by anthony on 2021/10/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
