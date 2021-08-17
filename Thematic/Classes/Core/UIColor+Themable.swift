// 
//  UIColor+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

extension UIColor {
    
    var assetInfo: AssetInfo? {
        get {
            objc_getAssociatedObject(
                self,
                &AssociatedKeys.colorAsset
            ) as? AssetInfo
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.colorAsset,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var themable: Bool {
        assetInfo != nil
    }
}

public extension UIColor {
    
    @objc convenience init?(
        assetName: String,
        in bundle: Bundle = .main,
        theme: Theme = ThemeManager.shared.currentTheme
    ) {
        switch theme.colorAssetType {
        case .xcassets:
            if #available(iOS 11.0, *) {
                self.init(
                    named: theme.colorAssetName(assetName),
                    in: bundle,
                    compatibleWith: nil
                )
            } else {
                fatalError("Color Set were not supported before iOS 11.")
            }
        case .table:
            let table = theme.isCurrent
                ? ThemeManager.shared.cacheColorTable(in: bundle)
                : theme.colorAssets(in: bundle)
            
            self.init(colorName: assetName, table: table)
        }
        
        self.assetInfo = AssetInfo(bundle: bundle, name: assetName)
        self.cgColor.superUIColor = self
    }
    
    @objc func withThemeComponent(_ theme: Theme) -> UIColor {
        guard let assetInfo = assetInfo else { return self }
        
        let color = UIColor(
            assetName: assetInfo.name,
            in: assetInfo.bundle,
            theme: theme
        ) ?? self
        
        /// 此处不能根据 cgColor 的 alpha 来判断，
        /// 因为设置了透明度的 UIColor 的 cgColor 的 alpha 为 1
        guard let alpha = assetInfo.alpha else {
            return color
        }
        
        return color.withAlphaComponent(alpha)
    }
}

private extension UIColor {
    
    convenience init?(
        colorName: String,
        table: Assets
    ) {
        guard let hexString = table[colorName] else {
            debugPrint("Couldn't found color \(colorName).")
            return nil
        }
        
        self.init(hex: hexString)
    }
    
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#")
            ? String(string.dropFirst())
            : string
        
        guard hex.count == 3 || hex.count == 6 || hex.count == 8 else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        // 兼容 alpha
        if hex.count == 6 {
            hex.append("FF")
        }
        
        guard let intCode = Int(hex, radix: 16) else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        self.init(
            red: CGFloat((intCode >> 24) & 0xFF) / 255.0,
            green: CGFloat((intCode >> 16) & 0xFF) / 255.0,
            blue: CGFloat((intCode >> 8) & 0xFF) / 255.0,
            alpha: CGFloat((intCode) & 0xFF) / 255.0
        )
    }
}

private extension Theme {
    
    var isCurrent: Bool {
        identifier == ThemeManager.shared.currentTheme.identifier
    }
}
