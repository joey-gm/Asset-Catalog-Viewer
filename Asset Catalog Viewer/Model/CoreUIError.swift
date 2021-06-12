//
//  CoreUIError.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import Foundation

/// An enumeration that captures various kinds of errors that can occur when parsing an asset catalog or exporting a rendition.
enum CoreUIError: LocalizedError {
    
    /// Error: Invalid Asset Catalog File.
    case invalidFile
    
    /// Error: Invalid Export Destination.
    case invalidURL
    
    /// Error: Export Failure.
    case exportFailure
    
    var errorDescription: String? {
        switch self {
        case .invalidFile:      return "Invalid Asset Catalog File."
        case .invalidURL:       return "Invalid Export Destination."
        case .exportFailure:    return "Export Failure."
        }
    }
    
}
