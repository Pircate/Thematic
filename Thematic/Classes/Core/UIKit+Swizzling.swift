// 
//  UIView+Swizzling.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

private func method_exchange(_ cls: AnyClass, s1: Selector, s2: Selector) {
    if let m1 = class_getInstanceMethod(cls, s1),
       let m2 = class_getInstanceMethod(cls, s2) {
        method_exchangeImplementations(m1, m2)
    }
}

extension UIView {
    
    static let methodSwizzling: Void = {
        method_exchange(
            UIView.self,
            s1: #selector(didMoveToSuperview),
            s2: #selector(theme_didMoveToSuperview)
        )
        method_exchange(
            UIView.self,
            s1: #selector(setter: backgroundColor),
            s2: #selector(setter: theme_backgroundColor)
        )
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
        
        themeDidChange(theme)
        
        isDynamicThemeEnabled = true
    }
}

extension UIViewController {
    
    static let methodSwizzling: Void = {
        method_exchange(
            UIViewController.self,
            s1: #selector(viewDidLoad),
            s2: #selector(theme_viewDidLoad)
        )
    }()
    
    @objc func theme_viewDidLoad() {
        theme_viewDidLoad()
        
        themeDidChange(theme)
        
        isDynamicThemeEnabled = true
    }
}

extension UIColor {
    
    static let methodSwizzling: Void = {
        if let cls = objc_getClass("UIDeviceRGBColor") as? AnyClass {
            method_exchange(
                cls,
                s1: #selector(withAlphaComponent(_:)),
                s2: #selector(theme_withAlphaComponent1(_:))
            )
        }
        
        if let cls = objc_getClass("UICGColor") as? AnyClass {
            method_exchange(
                cls,
                s1: #selector(withAlphaComponent(_:)),
                s2: #selector(theme_withAlphaComponent2(_:))
            )
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