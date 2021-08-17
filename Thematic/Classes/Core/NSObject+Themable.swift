// 
//  NSObject+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

extension NSObject: Themable {
    
    open var theme: Theme {
        ThemeManager.shared.currentTheme
    }
    
    open func themeDidChange(_ theme: Theme) {}
    
    /// 是否开启动态主题
    @objc public var isDynamicThemeEnabled: Bool {
        get {
            ThemeManager.shared.viewHashTable.contains(self)
        }
        set {
            if newValue {
                ThemeManager.shared.viewHashTable.add(self)
            } else {
                ThemeManager.shared.viewHashTable.remove(self)
            }
        }
    }
}
