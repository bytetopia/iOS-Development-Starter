//
//  EmojiArtApp.swift
//  Shared
//
//  Created by anthony on 2021/11/16.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    let document = EmojiArtDocument()
    let paletteStore = PaletteStore(named: "default")
     
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
