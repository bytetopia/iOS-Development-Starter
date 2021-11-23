//
//  EmojiArtApp.swift
//  Shared
//
//  Created by anthony on 2021/11/16.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    @StateObject var document = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "default")
     
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
                .environmentObject(paletteStore)  // inject the environment object to be passed throught views and sub views
        }
    }
}
