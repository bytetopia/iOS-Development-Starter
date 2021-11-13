//
//  Cardify.swift
//  Memorize (iOS)
//
//  Created by anthony on 2021/11/11.
//

import SwiftUI

// Customize a ViewModifier to modify views (turn view into a card).

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // make rotation as the animatableData but keep the variable name rotation
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
        
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10 // it's necessary to specify the type CGFloat here or Swift will treat it as Int or 20.0 as double, but we need CGFloat to be passed as the cornerRadius param
        static let lineWidth: CGFloat = 3
    }
        
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
