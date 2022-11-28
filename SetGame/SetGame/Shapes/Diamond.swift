//
//  Diamond.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: 0))
            path.closeSubpath()
        }
    }
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
            .stroke()
            .frame(width: 200, height: 100)
    }
}
