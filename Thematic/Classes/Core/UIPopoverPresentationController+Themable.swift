//
//  UIPopoverPresentationController+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/18/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

extension UIPopoverPresentationController: Themable {
    
    public var theme: Theme {
        ThemeManager.shared.currentTheme
    }
    
    open func themeDidChange(_ theme: Theme) {
        if let backgroundColor = backgroundColor, backgroundColor.themable {
            self.backgroundColor = backgroundColor.withThemeComponent(theme)
        }
    }
}
