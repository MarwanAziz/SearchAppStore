//
//  ViewModifiers.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import Foundation
import SwiftUI

enum PreviewDevices: String {
    case iPhone14Pro = "iPhone 14 Pro"
    case iPadPro12_9 = "iPad Pro (12.9-inch) (6th generation)"
}

struct PreviewDeviceSupport: ViewModifier {
    let preview: PreviewDevices
    func body(content: Content) -> some View {
        content
            .previewDevice(PreviewDevice(rawValue: preview.rawValue))
            .previewDisplayName(preview.rawValue)
    }
}
