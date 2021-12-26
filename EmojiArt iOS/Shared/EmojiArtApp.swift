//
//  EmojiArtApp.swift
//  Shared
//
//  Created by anthony on 2021/11/16.
//

import SwiftUI

@main
struct EmojiArtApp: App {// ReferenceFileDocument conforms to ObservableObject
    
    @StateObject var paletteStore = PaletteStore(named: "default")
     
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)
                .environmentObject(paletteStore)  // inject the environment object to be passed throught views and sub views
        }
    }
}
