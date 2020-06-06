//
//  CardViewModifier.swift
//  ChartsAndCollectionLibrariesDevelopment
//
//  Created by Igor Malyarov on 02.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    
    /// Wrap View in a Card with background and other parameters
    /// - Parameters:
    ///   - padding: padding of the wrapped view
    ///   - cornerRadius: card cornerRadius
    ///   - background: card background: View (ex, color)
    ///   - blurRadius: card blur radius, default is 0
    ///   - transition: card transition, default opacity
    ///   - animation: card animation, default no animation
    /// - Returns: View wrapped in card
    public func cardify<Background: View>(
        padding: CGFloat = 10,
        cornerRadius: CGFloat = 10,
        background: Background,// = Color(UIColor.quaternarySystemFill) as! Background,
        blurRadius: CGFloat = 0,
        transition: AnyTransition = .opacity,
        animation: Animation = .default
    ) -> some View {
        
        self
            .modifier(
                CardViewModifier(
                    padding: padding,
                    cornerRadius: cornerRadius,
                    background: background,
                    blurRadius: blurRadius,
                    transition: transition,
                    animation: animation
                )
        )
    }
}

@available(iOS 13.0, *)
fileprivate struct CardViewModifier<Background: View>: ViewModifier {
    let padding: CGFloat
    let background: Background
    let blurRadius: CGFloat
    let cornerRadius: CGFloat
    let transition: AnyTransition
    let animation: Animation
    
    init(
        padding: CGFloat,
        cornerRadius: CGFloat,
        background: Background,
        blurRadius: CGFloat,
        transition: AnyTransition = .opacity,
        animation: Animation
    ) {
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.background = background
        self.blurRadius = blurRadius
        self.transition = transition
        self.animation = animation
    }
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(background.blur(radius: blurRadius))
            .cornerRadius(cornerRadius)
            .transition(transition)
            .animation(animation)
    }
}
