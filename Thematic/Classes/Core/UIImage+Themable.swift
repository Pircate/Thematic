// 
//  UIImage+Themable.swift
//  Theme
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/25/20
//  
//

import UIKit

extension UIImage {
    
    var assetInfo: AssetInfo? {
        get {
            objc_getAssociatedObject(
                self,
                &AssociatedKeys.imageAsset
            ) as? AssetInfo
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.imageAsset,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var themable: Bool {
        assetInfo != nil
    }
}

public extension UIImage {
    
    @objc convenience init?(
        assetName: String,
        in bundle: Bundle = .main,
        theme: Theme = ThemeManager.shared.currentTheme
    ) {
        switch theme.imageAssetType {
        case .xcassets:
            self.init(
                named: theme.imageAssetName(assetName),
                in: bundle,
                compatibleWith: nil
            )
        case .filePath:
            self.init(contentsOfFile: theme.imageAssetPath(assetName))
        }
        
        self.assetInfo = AssetInfo(bundle: bundle, name: assetName)
    }
    
    @objc func withUserInterfaceTheme(_ theme: Theme) -> UIImage {
        guard let assetInfo = assetInfo else { return self }
        
        return UIImage(
            assetName: assetInfo.name,
            in: assetInfo.bundle,
            theme: theme
        ) ?? self
    }
}
