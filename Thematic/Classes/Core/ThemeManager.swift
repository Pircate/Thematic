// 
//  ThemeManager.swift
//  Theme
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/23/20
//  
//

import UIKit

@objcMembers
public class ThemeManager: NSObject {
    
    public static let shared: ThemeManager = ThemeManager()
    
    public private(set) var currentTheme: Theme = EmptyTheme() {
        didSet {
            guard currentTheme.identifier != oldValue.identifier else { return }
            
            debugPrint("Theme did change: \(oldValue.identifier) -> \(currentTheme.identifier)")
            
            cacheColorAssets.keys.forEach { bundle in
                reloadAssets(for: currentTheme, in: bundle)
            }
            
            UIView.animate(withDuration: 0.25) {
                self.viewHashTable.allObjects.forEach { view in
                    view.userInterfaceThemeDidChange(view.userInterfaceTheme)
                }
            }
        }
    }
    
    var viewHashTable = NSHashTable<Themable>(options: .weakMemory)
    
    private var cacheColorAssets: [Bundle: Assets] = [:]
    
    private override init() {
        UIView.methodSwizzling
        UIColor.methodSwizzling
    }
}

public extension ThemeManager {
    
    func applyTheme(_ theme: Theme) {
        currentTheme = theme
    }
    
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
        .xcassets
    }
    
    var imageAssetType: ImageAssetType {
        .xcassets
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
