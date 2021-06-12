//
//  NSScreen.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit

extension NSScreen {
    
    /// The pixel scale factor of the NSScreen in double-precision, floating-point.
    ///
    /// Default to @1x
    static let scale = Double(cgScale)
    
    /// The pixel scale factor of the NSScreen in floating-point scalar.
    ///
    /// Default to @1x
    static let cgScale = main?.backingScaleFactor ?? 1
    
}
