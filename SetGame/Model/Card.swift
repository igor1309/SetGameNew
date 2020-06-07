//
//  Card.swift
//  SetGame
//
//  Created by Igor Malyarov on 06.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Card: Identifiable, Hashable {
    var id = UUID()
    
    var isSelected: Bool = false
    var isMatch: Bool?
    var isHinted: Bool = false
    
    let numberOfShapes: NumberOfShapes
    let shape: CardShape
    let color: CardColor
    let shading: CardShading
    
    enum NumberOfShapes: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum CardShape: String, CaseIterable {
        case diamond, squiggle, oval
        
        var shape: AnyShape {
            switch self {
            case .diamond:
                return Diamond().anyShape()
            case .squiggle:
                return Rectangle().anyShape()//Squiggle()
            case .oval:
                return Ellipse().anyShape()//Oval()
            }
        }
    }
    
    enum CardColor: CaseIterable {
        case red, green, purple
        
        var color: Color {
            switch self {
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .purple:
                return Color.purple
            }
        }
        
    }
    
    enum CardShading: String, CaseIterable {
        case solid, striped, open
        
        var shading: AnyView {
            switch self {
            case .solid:
                return AnyView(Color.primary)
            case .striped:
                let gradient = Gradient(colors: [Color.primary, .clear])
//                let linearGradient = LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
                let angularGradient = AngularGradient(gradient: gradient, center: .center)
                return AnyView(angularGradient)
            case .open:
                return AnyView(Color.clear)
            }
        }
    }
}
