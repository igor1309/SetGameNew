//
//  CardBack.swift
//  CardBackDesignTesting
//
//  Created by Igor Malyarov on 17.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CardFrame: Shape {
    private let radiusApprox: CGFloat
    private let indentationApprox: CGFloat
    
    init(radiusApprox: CGFloat? = nil, indentationApprox: CGFloat? = nil) {
        self.radiusApprox = radiusApprox ?? 10/100
        self.indentationApprox = indentationApprox ?? 0
    }
    
    func path(in rect: CGRect) -> Path {
        let radius = (min(rect.width, rect.height) * radiusApprox).rounded(.up)
        let indentation: CGFloat = (radius * indentationApprox).rounded(.up)
        
        return Path { path in
            //            path.addRelativeArc(center: CGPoint(x: radius/2,
            //                                                y: radius/2),
            //                                radius: radius/5,
            //                                startAngle: Angle.radians(0),
            //                                delta: Angle.radians(2 * .pi))
            
            //            path.addLines([
            //                CGPoint(x: indentation, y: indentation),
            //                CGPoint(x: indentation, y: rect.maxY - indentation),
            //                CGPoint(x: rect.maxX - indentation, y: rect.maxY - indentation),
            //                CGPoint(x: rect.maxX - indentation, y: indentation),
            //                CGPoint(x: indentation, y: indentation)
            //            ])
            //
            path.move(to: CGPoint(x: indentation,
                                  y: radius + indentation))
            path.addLine(to: CGPoint(x: indentation,
                                     y: rect.maxY - (radius + indentation)))
            path.addArc(center: CGPoint(x: indentation,
                                        y: rect.maxY - indentation),
                        radius: radius,
                        startAngle: Angle.radians(-.pi/2),
                        endAngle: Angle.radians(0),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - (radius + indentation),
                                     y: rect.maxY - indentation))
            path.addArc(center: CGPoint(x: rect.maxX - indentation,
                                        y: rect.maxY - indentation),
                        radius: radius,
                        startAngle: Angle.radians(-.pi),
                        endAngle: Angle.radians(-.pi/2),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - indentation,
                                     y: radius + indentation))
            path.addArc(center: CGPoint(x: rect.maxX - indentation,
                                        y: indentation),
                        radius: radius,
                        startAngle: Angle.radians(-.pi*3/2),
                        endAngle: Angle.radians(-.pi),
                        clockwise: false)
            path.addLine(to: CGPoint(x: radius + indentation,
                                     y: indentation))
            path.addArc(center: CGPoint(x: indentation,
                                        y: indentation),
                        radius: radius,
                        startAngle: Angle.radians(-2 * .pi),
                        endAngle: Angle.radians(-.pi*3/2),
                        clockwise: false)
            path.closeSubpath()
            
        }
    }
}

struct CardBack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CardFrame(radiusApprox: 10/100, indentationApprox: 4/10)
                .stroke(Color.white, lineWidth: 8)
                .background(Color.white.opacity(0.1))
                .frame(width: 300, height: 400)
                .padding()
                .border(Color.black.opacity(0.3))
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple)
        .edgesIgnoringSafeArea(.all)
//        .previewColorSchemes(.dark)
    }
}
