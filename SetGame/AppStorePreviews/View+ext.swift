//
//  View+fixedOverlay.swift
//  AppStorePreviews
//
//  Created by Igor Malyarov on 23.11.2022.
//

import Screenshotting
import SwiftUI

extension View {
    
    func overlayedPreview(_ device: Device) -> some View {
        self
            .overlay {
                Text("View in Selectable Preview Mode")
                    .foregroundStyle(.red)
                    .font(.headline)
                    .padding()
                    .background(.thickMaterial)
                    .clipShape(Capsule())
            }
            .previewLayout(
                .fixed(
                    width: device.size.width,
                    height: device.size.height
                )
            )
            .previewDisplayName(device.name)
    }
}
