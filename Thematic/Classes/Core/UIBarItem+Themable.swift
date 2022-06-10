//
//  UIBarItem+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/18/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

extension UIBarItem: Themable {
    
    open var theme: Theme {
        ThemeManager.shared.currentTheme
    }
    
    open func themeDidChange(_ theme: Theme) {
        if let image = image, image.themable {
            self.image = image.withThemeComponent(theme)
        }
    }
}

extension UITabBarItem {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let selectedImage = selectedImage, selectedImage.themable {
            self.selectedImage = selectedImage.withThemeComponent(theme)
        }
        
        if #available(iOS 10.0, *) {
            if let badgeColor = badgeColor, badgeColor.themable {
                self.badgeColor = badgeColor.withThemeComponent(theme)
            }
        }
        
        UIControl.State.allStates.forEach { state in
            if let titleTextAttributes = titleTextAttributes(for: state) {
                setTitleTextAttributes(titleTextAttributes.withThemeComponent(theme), for: state)
            }
            
            if #available(iOS 10.0, *) {
                if let badgeTextAttributes = badgeTextAttributes(for: state) {
                    setBadgeTextAttributes(badgeTextAttributes.withThemeComponent(theme), for: state)
                }
            }
        }
    }
}

extension UIBarButtonItem {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let tintColor = tintColor, tintColor.themable {
            self.tintColor = tintColor.withThemeComponent(theme)
        }
    }
}
