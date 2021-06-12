//
//  NumberFormatter.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    /// Returns a string containing the formatted value of the provided floating-point scalar value.
    ///
    /// - Parameters:
    ///   - cgFloat: A floating-point scalar value that is parsed to create the returned string object.
    func string(from cgFloat: CGFloat) -> String {
        return string(from: NSNumber(value: Double(cgFloat))) ?? String()
    }
    
}
