//
//  MemorizeApp.swift
//  Shared
//
//  Created by anthony on 2021/10/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        let game = EmojiMemoryGame()
        
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
