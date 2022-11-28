//
//  Marketing1Screenshot.swift
//  AppStorePreviews
//
//  Created by Igor Malyarov on 28.11.2022.
//  Copyright © 2022 Igor Malyarov. All rights reserved.
//

import AppStorePreviewing
import Screenshotting
import SwiftUI

struct Marketing1Screenshot: View {
    
    let device: Device
    
    var body: some View {
        ContentView()
            .frame(size: device.size)
    }
}

struct Marketing1Screenshot_Previews: PreviewProvider {
    
    static func contentView(device: Device) -> some View {
        Marketing1Screenshot(device: device)
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
    
    static let devices: [Device] = [
        // 5.5"
        .iPhone8Plus,
        // 12.9" iPad Pro 2nd Gen
        
            .iPadPro12_9_2nd,
        
        // 12.9" iPad Pro 3rd Gen
        // http://docs.fastlane.tools/actions/upload_to_app_store/#uploading-screenshots-for-ipad-pro-129-inch-3rd-generation
            .iPadPro12_9_3rd,
    ]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            contentView(device: .iPhone13Pro)
                .overlayedPreview(device)
        }
    }
}
