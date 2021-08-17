//
//  CGColor+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import Foundation

extension CGColor {
    
    weak var superUIColor: UIColor? {
        get {
            objc_getAssociatedObject(
                self,
                &AssociatedKeys.superUIColor
            ) as? UIColor
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.superUIColor,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var themable: Bool {
        superUIColor?.themable == true
    }
}

extension CGColor {
    
    func withThemeComponent(_ theme: Theme) -> CGColor {
        guard let superUIColor = superUIColor, superUIColor.themable else { return self }
        
        return superUIColor.withThemeComponent(theme).cgColor
    }
}
