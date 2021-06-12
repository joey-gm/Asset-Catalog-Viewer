//
//  CollectionView.swift
//  Asset Catalog Viewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import Foundation
import Quartz

/// A collection view that displays the selected renditions.
final class CollectionView: NSCollectionView {
    
    override func keyDown(with theEvent: NSEvent) {
        // Invoke Quicklook preview panel when the user has pressed space bar (keyCode 49 = space key)
        if theEvent.keyCode == 49, !selectionIndexPaths.isEmpty {
            guard let panel = QLPreviewPanel.shared() else { return }
            if QLPreviewPanel.sharedPreviewPanelExists() && panel.isVisible {
                panel.orderOut(nil)
            } else {
                panel.makeKeyAndOrderFront(nil)
            }
        } else {
            super.keyDown(with: theEvent)
        }
    }
    
}
