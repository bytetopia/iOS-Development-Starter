//
//  macOS.swift
//  EmojiArt (macOS)
//
//  Created by anthony on 2021/11/28.
//

// some macOS specific code to make the app working well on macOS

import SwiftUI

// several ways to make code compatible between different platforms

// 1) use typealias. only works when the two type have very similar functions

typealias UIImage = NSImage

typealias PaletteManager = EmptyView

// 2) write some platform specific extension to overwrite/add functions
extension Image {
    init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}

extension View {
    func wrappedInNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) -> some View {
        self
    }
    
    func paletteControlButtonStyle() -> some View {
        self.buttonStyle(PlainButtonStyle()).foregroundColor(.accentColor).padding(.vertical)
    }
    
    func popoverPadding() -> some View {
        self.padding(.horizontal)
    }
}

// 3) create some fake/empty view, and combine with typealias to replace the broken view
struct CantDoItPhotoPicker: View {
    var handlePickedImage: (UIImage?) -> Void
    
    static let isAvailable = false
    
    var body: some View {
        EmptyView()
    }
}

typealias Camera = CantDoItPhotoPicker
typealias PhotoLibrary = CantDoItPhotoPicker

// 4) create abstraction and implement it differently on different platforms
// eg. add imageData to UIImage and have different implementations on iOS and macOS
extension UIImage {
    var imageData: Data?  {
        tiffRepresentation
    }
}


struct Pasteboard {
    static var imageData: Data? {
        NSPasteboard.general.data(forType: .tiff) ?? NSPasteboard.general.data(forType: .png)
    }
    
    static var imageURL: URL? {
        (NSURL(from: NSPasteboard.general) as URL?)?.imageURL
    }
}


