//
//  AppStorePreviewsTests.swift
//  AppStorePreviewsTests
//
//  Created by Igor Malyarov on 28.11.2022.
//  Copyright © 2022 Igor Malyarov. All rights reserved.
//

@testable import AppStorePreviews
import Screenshotting
import XCTest

final class AppStorePreviewsTests: XCTestCase {
    
    func test_1Marketing_screenshot() throws {
        let devices: [Device] = [
            // 5.5"
            .iPhone8Plus,
            // 12.9" iPad Pro 2nd Gen
            
            .iPadPro12_9_2nd,
            
            // 12.9" iPad Pro 3rd Gen
            // http://docs.fastlane.tools/actions/upload_to_app_store/#uploading-screenshots-for-ipad-pro-129-inch-3rd-generation
            .iPadPro12_9_3rd,
        ]
        let locales: [Locale] = [.ru, .en_US]
        
        try screenshots(
            Marketing1Screenshot.init,
            with: locales,
            on: devices
        )
    }
    
    func test_1Marketing_preview() throws {
        let devices: [Device] = [
            // 5.5"
            // .iPhone8Plus,
            // 6.1"
            // .iPhone14Pro,
            // 6.5"
            .iPhone13ProMax,
            // 6.7"
            // .iPhone14ProMax
            
            // 12.9" iPad Pro 2nd Gen
            .iPadPro12_9_2nd,
            
            // 12.9" iPad Pro 3rd Gen
            // http://docs.fastlane.tools/actions/upload_to_app_store/#uploading-screenshots-for-ipad-pro-129-inch-3rd-generation
            .iPadPro12_9_3rd,
        ]
        let locales: [Locale] = [.ru, .en_US]
        
        try screenshots(
            Marketing1Preview.init,
            with: locales,
            on: devices
        )
    }
}

extension Locale {
    static let ru: Self = .init(identifier: "ru")
    static let en_US: Self = .init(identifier: "en-US")
}
