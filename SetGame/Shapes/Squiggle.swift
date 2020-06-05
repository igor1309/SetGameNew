//
//  Squiggle.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.maxY))
            path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                          control1: CGPoint(x: rect.midX, y: 0),
                          control2: CGPoint())
//            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY / 3 * 2), control: CGPoint(x: 0, y: 0))
        }
    }
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle()
            .stroke()
            .background(Color(UIColor.secondarySystemFill))
            .padding()
    }
}
