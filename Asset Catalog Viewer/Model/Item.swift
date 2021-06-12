//
//  Item.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//


/// A tree structure that represents the hierarchy of rendition data in an asset catalog.
struct Item {
    
    /// The name of the asset.
    let name: String
    
    /// A contiguously stored array containing the child nodes.
    let children: ContiguousArray<Item>
    
    /// The kind of the asset.
    let kind: Kind
    
    /// A Boolean that indicates whether the item is a group node.
    let isGroup: Bool
    
    /// A Boolean that indicates whether the item is a leaf node.
    let isLeaf: Bool
    
    
    /// Initializes a newly allocated item without child node.
    /// - Parameters:
    ///   - name: The name of the asset.
    ///   - isGroup: A Boolean that indicates whether the item is a group node.
    ///   - kind: The kind of the asset.
    init(name: String, isGroup: Bool, kind: Kind) {
        self.name = name
        self.isGroup = isGroup
        self.isLeaf = false
        self.kind = kind
        self.children = .init()
    }
    
    /// Initializes a newly allocated group node with child nodes with the given asset names.
    /// - Parameters:
    ///   - names: A set of asset names that will be used to create the child nodes.
    ///   - kind: The kind of the assets.
    init(names: Set<String>, kind: Kind) {
        var children = ContiguousArray<Item>()
        children.reserveCapacity(names.count)
        names.sorted { $0.lowercased() < $1.lowercased() }.forEach {
            children.append(Item(name: $0, isGroup: false, kind: kind))
        }
        switch kind {
        case .ImageSet: self.name = "Image Set"
        case .Data:     self.name = "Raw Data"
        default:        self.name = kind.string
        }
        self.isGroup = true
        self.isLeaf = true
        self.kind = kind
        self.children = children
    }
    
}


extension ContiguousArray where Element == Item {
    
    /// Adds a new tree hierarchy to the root node with a given set of asset names.
    /// - Parameters:
    ///   - keys: A set of asset names.
    ///   - kind: The kind of the assets.
    mutating func append(keys: Set<String>, kind: Kind) {
        guard !keys.isEmpty else { return }
        append(Item(names: keys, kind: kind))
    }
    
}
