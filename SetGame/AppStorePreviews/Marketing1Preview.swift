//
//  Marketing1Preview.swift
//  AppStorePreviews
//
//  Created by Igor Malyarov on 28.11.2022.
//  Copyright © 2022 Igor Malyarov. All rights reserved.
//

import AppStorePreviewing
import Screenshotting
import SwiftUI

struct Marketing1Preview: View {
    
    let device: Device
    
    var body: some View {
        AppStorePreview(
            device: device,
            background: Color.green,
            marketing: marketing,
            content: content
        )
    }
    
    private func marketing() -> some View {
        VStack {
            Text("MARKETING1_TITLE")
                .font(.largeTitle.bold())
                .fontDesign(.serif)
                .padding()
            
            Text("MARKETING1_SUBTITLE")
                .italic()
        }
    }
    
    private func content() -> some View {
        ContentView()
            .frame(size: device.size)
    }
}

struct Marketing1Preview_Previews: PreviewProvider {
    
    static func contentView(device: Device) -> some View {
        Marketing1Preview(device: device)
            .overlay {
                Text("Switch to Select Mode")
                    .foregroundStyle(.red)
                    .font(.headline)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(Capsule())
            }
            .previewLayout(
                .fixed(
                    width: device.size.width,
                    height: device.size.height
                )
            )
    }
    
    private static let devices: [Device] = [
        // 5.5"
        .iPhone8Plus,
        // 6.1"
        // .iPhone14Pro,
        // 6.5"
            .iPhone13ProMax,
        // 6.7"
        // .iPhone14ProMax
    ]
    
    static var previews: some View {        
        ForEach(devices, id: \.self) { device in
            contentView(device: .iPhone13Pro)
                .overlayedPreview(device)
        }
    }
}
