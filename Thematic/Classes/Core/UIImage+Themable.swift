// 
//  UIImage+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
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
    
    /// UIImage 构造方法
    /// - Parameters:
    ///   - assetName: 资源名称，用来标记资源
    ///   - bundle: 资源所在的 bundle
    ///   - theme: 主题，默认是当前主题
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
    
    /// 根据主题返回对应的 UIImage
    /// - Parameter theme: 主题
    /// - Returns: 主题对应的 UIImage
    @objc func withThemeComponent(_ theme: Theme) -> UIImage {
        guard let assetInfo = assetInfo else { return self }
        
        return UIImage(
            assetName: assetInfo.name,
            in: assetInfo.bundle,
            theme: theme
        ) ?? self
    }
}
