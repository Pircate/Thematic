//
//  CGColor+Themable.swift
//  Theming
//
//  Created by gaoxiang on 2021/8/17.
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
    
    func withUserInterfaceTheme(_ theme: Theme) -> CGColor {
        guard let superUIColor = superUIColor, superUIColor.themable else { return self }
        
        return superUIColor.withUserInterfaceTheme(theme).cgColor
    }
}
