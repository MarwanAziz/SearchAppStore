//
//  Extension.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import Foundation
import SwiftUI

extension Double {
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIDevice {
    var currentDeviceType: UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

    var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}

extension View {

    var isPreview: Bool {
        UIDevice.current.isPreview
    }

    func setPreviewFor(preview: PreviewDevices) -> some View {
        modifier(PreviewDeviceSupport(preview: preview))
    }
}

extension Color {
    static let systemSecondary = Color("secondary")
}
