//
//  AnyShape.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

extension Shape {
    func anyShape() -> AnyShape {
        return AnyShape(self)
    }
}

struct AnyShape: Shape {
    private let path: (CGRect) -> Path
    
    init<T: Shape> (_ shape: T) {
        path = { rect in
            return shape.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return path(rect)
    }
}
