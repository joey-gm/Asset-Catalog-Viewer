//
//  RawRepresentable.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//



extension RawRepresentable {
    
    /// Returns the name of the given enum case.
    var string: String { return String(describing: self) }
    
}


extension RawRepresentable where RawValue == UInt16 {
    
    /// Initializes a UInt16 Raw Representable with an Int64 number.
    /// - Parameter keyValue: Int64 rendition key value.
    ///
    /// This is a convenience initializer to convert the attributes in the CUIRenditionKey in form of long long to a compact rendition key attribute in form of UInt16.
    ///
    /// There is no out of bound check given the number of attributes are not expected to exceed UInt16.max.
    init(_ keyValue: Int64) {
        self = Self.init(rawValue: UInt16(keyValue))!
    }
    
    /// Returns a Boolean value indicating whether the value of the first argument is less than that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    /// Returns a Boolean value indicating whether the value of the first argument is greater than that of the second argument.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
}
