// 
//  ThemeManager.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

@objcMembers
public class ThemeManager: NSObject {
    
    public static let shared: ThemeManager = ThemeManager()
    
    /// 当前主题，默认是空主题
    public private(set) var currentTheme: Theme = EmptyTheme() {
        didSet {
            guard currentTheme.identifier != oldValue.identifier else { return }
            
            debugPrint("Theme did change: \(oldValue.identifier) -> \(currentTheme.identifier)")
            
            cacheColorAssets.keys.forEach { bundle in
                reloadAssets(for: currentTheme, in: bundle)
            }
            
            self.viewHashTable.allObjects.forEach { view in
                view.themeDidChange(view.theme)
            }
        }
    }
    
    var viewHashTable = NSHashTable<Themable>(options: .weakMemory)
    
    private var cacheColorAssets: [Bundle: Assets] = [:]
    
    private override init() {
        UIView.methodSwizzling
        UIViewController.methodSwizzling
        UIColor.methodSwizzling
    }
}

public extension ThemeManager {
    
    /// 应用主题
    /// - Parameter theme: 主题
    func applyTheme(_ theme: Theme) {
        currentTheme = theme
    }
    
    /// 添加资源 bundle
    /// - Parameter bundle: 资源所在的 bundle
    func appendResourceBundle(_ bundle: Bundle) {
        reloadAssets(for: currentTheme, in: bundle)
    }
}

extension ThemeManager {
    
    func cacheColorTable(in bundle: Bundle) -> Assets {
        cacheColorAssets[bundle] ?? [:]
    }
    
    func reloadAssets(for theme: Theme, in bundle: Bundle) {
        cacheColorAssets[bundle] = theme.colorAssets(in: bundle)
    }
}

private final class EmptyTheme: Theme {
    
    var identifier: String { "empty" }
    
    var colorAssetType: ColorAssetType {
        .mapTable
    }
    
    var imageAssetType: ImageAssetType {
        .xcassets
    }
    
    var keyboardAppearance: UIKeyboardAppearance {
        .default
    }
    
    public func colorAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    public func colorAssets(in bundle: Bundle) -> Assets {
        [:]
    }
    
    public func imageAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    public func imageAssetPath(_ assetName: String) -> String {
        ""
    }
}
