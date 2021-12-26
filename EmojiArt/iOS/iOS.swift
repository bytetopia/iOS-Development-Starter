//
//  iOS.swift
//  EmojiArt (iOS)
//
//  Created by anthony on 2021/11/29.
//
// some iOS specific code to make the app working well on iOS


import SwiftUI

struct Pasteboard {
    static var imageData: Data? {
        UIPasteboard.general.image?.imageData
    }
    
    static var imageURL: URL? {
        UIPasteboard.general.url?.imageURL
    }
}

extension UIImage {
    var imageData: Data?  {
        jpegData(compressionQuality: 1.0)
    }
}

extension View {
    
    @ViewBuilder
    func wrappedInNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) -> some View {
        // only show dismiss btn on mobile phone
        if UIDevice.current.userInterfaceIdiom != .pad, let dismiss = dismiss {
            NavigationView {
                self
                    .navigationBarTitleDisplayMode(.inline)
                    .dismissable(dismiss)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            self
        }
    }
    
    @ViewBuilder
    func dismissable(_ dismiss: (() -> Void)?) -> some View {
        // only show dismiss btn on mobile phone
        if UIDevice.current.userInterfaceIdiom != .pad, let dismiss = dismiss {
            self.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        } else {
            self
        }
    }
    
    func paletteControlButtonStyle() -> some View {
        self
    }
    
    func popoverPadding() -> some View {
        self
    }
    
}
