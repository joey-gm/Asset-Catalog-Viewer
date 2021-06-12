//
//  PreviewViewController.swift
//  Asset Catalog Previewer
//
//  Copyright © 2021 Joey. All rights reserved.
//

import AppKit
import Quartz

/// Asset Catalog QuickLook Previewing Controller.
final class PreviewViewController: NSViewController, QLPreviewingController {
    
    /// A strong reference of the CoreUI Catalog class.
    private var catalog: CUICatalog!
    
    /// A contiguously stored array of tuples representing the asset name, rendition name and the image of the renditions to be previewed.
    private var renditions: ContiguousArray<(assetName: String, renditionName: String, image: NSImage)>
    
    /// The total number of renditions in the asset catalog file.
    private var totalCount: Int
    
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.renditions = .init()
        self.totalCount = .init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view = NSScrollView()
    }
    
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        // Initializes a CUICatalog object at the specified URL
        do {
            catalog = try CUICatalog(url: url)
        } catch  {
            handler(error)
            return
        }
        let themeStore = catalog._themeStore()
        let allKeys = themeStore.store().allAssetKeys()
        totalCount = allKeys.endIndex
        
        // Preview the first 100 items only (in reverse order such that packed assets will be shown last)
        let renditionKeys = allKeys.reversed().prefix(100)
        renditions.reserveCapacity(renditionKeys.count)
        
        // Parse the renditions
        for key in renditionKeys {
            
            // Load the rendition
            let keyList = key.keyList()
            guard let cuiRendition = themeStore.rendition(withKey: keyList),
                  let layout = Layout(rawValue: cuiRendition.type) else { continue }
            
            // Set the rendition name
            var renditionName = cuiRendition.name()
            
            // Set the asset name if available
            let assetName: String
            if let name = themeStore.renditionName(forKeyList: keyList) {
                assetName = name
            } else {
                assetName = renditionName.hasPrefix("ZZZZPackedAsset") ? String(renditionName.prefix(21).dropFirst(4)) : renditionName
            }
            
            // Create preview image
            let previewImage: NSImage
            let pixelFormat = PixelFormat(rawValue: cuiRendition.pixelFormat())
            
            switch layout {
            
            // Unsupported layouts
            case .Effect, .Gradient, .LayerStack, .InternalLink, .ExternalLink, .NamedContent, .ThinningPlaceholder, .TextStyle, .Texture, .TextureImage, .ModelAsset, .ModelMesh, .ModelSubMesh, .RecognitionGroup, .RecognitionObject, .MultisizeImageSet:
                continue
                
            case .Color:
                let length: CGFloat = 100
                previewImage = NSImage(size: CGSize(width: length, height: length), flipped: false) {
                    // CF Get Function -> takeUnretainedValue
                    let cgColor = cuiRendition.cgColor().takeUnretainedValue()
                    if cgColor.alpha != 1 {
                        NSColor.black.drawSwatch(in: $0)
                        let path = NSBezierPath()
                        path.move(to: .zero)
                        path.line(to: CGPoint(x: length, y: 0))
                        path.line(to: CGPoint(x: length, y: length))
                        path.close()
                        NSColor.white.setFill()
                        path.fill()
                    }
                    NSColor(cgColor: cgColor)?.drawSwatch(in: $0)
                    return true
                }
                
            case .Vector:
                guard pixelFormat == .PDF else { continue }
                let cgImage = cuiRendition.createImageFromPDFRendition(withScale: NSScreen.scale).takeRetainedValue()
                let previewSize = CGSize(width: cgImage.width, height: cgImage.height).scaleAspectFit
                previewImage = NSImage(size: previewSize, flipped: false) {
                    NSImage(cgImage: cgImage, size: previewSize).draw(in: $0)
                    return true
                }
                
            case .VectorGlyph:
                guard #available(OSX 10.15, *),
                      pixelFormat == .SVG,
                      let canvasSize = CGSize(svgData: cuiRendition.rawData()) else { continue }
                let themeIndex = catalog.storageRef
                let previewSize = canvasSize.scaleAspectFit
                previewImage = NSImage(size: previewSize, flipped: false) {
                    let namedVector = CUINamedVectorGlyph(name: nil, using: CUIRenditionKey(keyList: keyList), fromTheme: themeIndex)
                    // CF Object-creation Function
                    let cgImage = namedVector.rasterizeImage(usingScaleFactor: NSScreen.scale, forTargetSize: previewSize).takeRetainedValue()
                    NSImage(cgImage: cgImage, size: previewSize).draw(in: $0)
                    return true
                }
                
            case .RawData:
                // The rendition name of _CUIRawDataRendition is "CoreStructuredImage".
                // The file name appears in the asset name without the filename extension.
                renditionName = assetName
                var fileType = cuiRendition.utiType()
                if fileType == "dyn.age8u" {
                    // dyn.age8u = data file without extension
                    // Swaps the universal type identifier to "Office Open XML", which will return a default macOS file icon.
                    fileType = "org.openxmlformats.openxml"
                }
                let fileIcon = NSWorkspace.shared.icon(forFileType: fileType)
                fileIcon.size = CGSize(width: 64, height: 64)
                previewImage = fileIcon
                
            default:
                guard pixelFormat != nil else { continue }
                let previewSize = cuiRendition.unslicedSize().scaleAspectFit
                previewImage = NSImage(size: previewSize, flipped: false) {
                    // CF Get Function
                    NSImage(cgImage: cuiRendition.unslicedImage().takeUnretainedValue(), size: previewSize).draw(in: $0)
                    return true
                }
                
            }
            // Adds the rendition preview tuple to the end of the collection
            renditions.append((assetName, renditionName, previewImage))
        }
        
        // Configure collection view
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 100, height: 145)
        flowLayout.minimumInteritemSpacing = 30
        flowLayout.minimumLineSpacing = 30
        flowLayout.sectionInset = NSEdgeInsets(top: 10, left: 30, bottom: 30, right: 30)
        flowLayout.headerReferenceSize = CGSize(width: .zero, height: 60)
        let gridView = NSCollectionView()
        gridView.wantsLayer = true
        gridView.collectionViewLayout = flowLayout
        gridView.register(GridViewItem.self, forItemWithIdentifier: GridViewItem.reuseIdentifier)
        gridView.register(HeaderView.self, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: HeaderView.reuseIdentifier)
        gridView.dataSource = self
        
        // Add the collection view to the scroll view and call the completion handler
        if let scrollView = view as? NSScrollView {
            scrollView.documentView = gridView
        }
        handler(nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PreviewViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return renditions.endIndex
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let viewItem = collectionView.makeItem(withIdentifier: GridViewItem.reuseIdentifier, for: indexPath) as? GridViewItem else { fatalError() }
        let rendition = renditions[indexPath.item]
        viewItem.renditionView.image = rendition.image
        viewItem.primaryLabel.stringValue =  rendition.assetName
        viewItem.secondaryLabel.stringValue =  rendition.renditionName
        return viewItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        guard let headerView = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else { fatalError() }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var text = "Previewing "
        text += String(renditions.endIndex)
        text += " of "
        text += numberFormatter.string(from: NSNumber(value: totalCount))!
        text += totalCount > 1 ? " Renditions" : " Rendition"
        headerView.textField.stringValue = text
        return headerView
    }
    
}


/// A header view showing the number of preview items
private final class HeaderView: NSView {
    
    /// The reuse identifier for the header view.
    static let reuseIdentifier = NSUserInterfaceItemIdentifier("HeaderViewID")
    
    /// Text displayed in the header view.
    unowned let textField: NSTextField
    
    override init(frame frameRect: NSRect) {
        let textField = NSTextField(labelWithString: String())
        self.textField = textField
        super.init(frame: frameRect)
        textField.wantsLayer = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.cell?.lineBreakMode = .byTruncatingTail
        textField.alignment = .center
        textField.textColor = .secondaryLabelColor
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
