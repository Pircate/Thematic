// 
//  UIView+Swizzling.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

infix operator <=>

private extension Selector {
    
    static func <=> (left: Selector, right: Selector) {
        if let m1 = class_getInstanceMethod(UIView.self, left),
           let m2 = class_getInstanceMethod(UIView.self, right) {
            method_exchangeImplementations(m1, m2)
        }
    }
}

extension UIView {
    
    static let methodSwizzling: Void = {
        #selector(didMoveToSuperview) <=> #selector(theme_didMoveToSuperview)
        #selector(setter: backgroundColor) <=> #selector(setter: theme_backgroundColor)
    }()
    
    var backgroundColorAssetInfo: AssetInfo? {
        get {
            objc_getAssociatedObject(
                self,
                &AssociatedKeys.backgroundColorAsset
            ) as? AssetInfo
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.backgroundColorAsset,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    @objc var theme_backgroundColor: UIColor? {
        get {
            backgroundColor
        }
        set {
            self.backgroundColorAssetInfo = newValue?.assetInfo
            self.theme_backgroundColor = newValue
        }
    }
    
    @objc func theme_didMoveToSuperview() {
        theme_didMoveToSuperview()
        
        userInterfaceThemeDidChange(userInterfaceTheme)
        
        isDynamicThemeEnabled = true
    }
}

extension UIColor {
    
    static let methodSwizzling: Void = {
        if let cls = objc_getClass("UIDeviceRGBColor") as? AnyClass,
           let m1 = class_getInstanceMethod(cls, #selector(withAlphaComponent(_:))),
           let m2 = class_getInstanceMethod(cls, #selector(theme_withAlphaComponent1(_:))) {
            method_exchangeImplementations(m1, m2)
        }
        
        if let cls = objc_getClass("UICGColor") as? AnyClass,
           let m1 = class_getInstanceMethod(cls, #selector(withAlphaComponent(_:))),
           let m2 = class_getInstanceMethod(cls, #selector(theme_withAlphaComponent2(_:))) {
            method_exchangeImplementations(m1, m2)
        }
    }()
    
    @objc func theme_withAlphaComponent1(_ alpha: CGFloat) -> UIColor {
        let color = theme_withAlphaComponent1(alpha)
        
        color.assetInfo = assetInfo
        color.assetInfo?.alpha = alpha
        color.cgColor.superUIColor = self
        
        return color
    }
    
    @objc func theme_withAlphaComponent2(_ alpha: CGFloat) -> UIColor {
        let color = theme_withAlphaComponent2(alpha)
        
        color.assetInfo = assetInfo
        color.assetInfo?.alpha = alpha
        color.cgColor.superUIColor = self
        
        return color
    }
}
