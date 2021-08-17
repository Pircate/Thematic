// 
//  UIKit+Theme.swift
//  Theming
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/31/20
//  
//

import UIKit

extension UIView {
    
    @objc open var overrideUserInterfaceTheme: UserInterfaceTheme {
        .current
    }
    
    open override var userInterfaceTheme: Theme {
        overrideUserInterfaceTheme.theme
    }
}

extension UIViewController {
    
    @objc open var overrideUserInterfaceTheme: UserInterfaceTheme {
        .current
    }
    
    open override var userInterfaceTheme: Theme {
        overrideUserInterfaceTheme.theme
    }
}

public extension UIColor {
    
    @objc convenience init(dynamicTheme: (UserInterfaceTheme) -> UIColor) {
        self.init(cgColor: dynamicTheme(.current).cgColor)
    }
    
    @objc static func themeColor(
        dynamicTheme: (UserInterfaceTheme) -> UIColor
    ) -> UIColor {
        dynamicTheme(.current)
    }
}

public extension UIImage {
    
    @objc convenience init?(dynamicTheme: (UserInterfaceTheme) -> UIImage) {
        guard let cgImage = dynamicTheme(.current).cgImage else { return nil }
        
        self.init(cgImage: cgImage)
    }
    
    static func themeImage(
        dynamicTheme: (UserInterfaceTheme) -> UIImage
    ) -> UIImage {
        dynamicTheme(.current)
    }
}

public extension UIStatusBarStyle {
    
    init(dynamicTheme: (UserInterfaceTheme) -> UIStatusBarStyle) {
        self = dynamicTheme(.current)
    }
}

public extension UIBarStyle {
    
    init(dynamicTheme: (UserInterfaceTheme) -> UIBarStyle) {
        self = dynamicTheme(.current)
    }
}
