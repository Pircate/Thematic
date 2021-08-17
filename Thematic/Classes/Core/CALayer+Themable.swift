//
//  CALayer+Themable.swift
//  Theming
//
//  Created by gaoxiang on 2021/8/17.
//

import Foundation

extension CALayer {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let backgroundColor = backgroundColor, backgroundColor.themable {
            self.backgroundColor = backgroundColor.withUserInterfaceTheme(theme)
        }
        
        if let borderColor = borderColor, borderColor.themable {
            self.borderColor = borderColor.withUserInterfaceTheme(theme)
        }
        
        if let shadowColor = shadowColor, shadowColor.themable {
            self.shadowColor = shadowColor.withUserInterfaceTheme(theme)
        }
        
        if let sublayers = sublayers, !sublayers.isEmpty {
            sublayers.forEach { $0.userInterfaceThemeDidChange(theme) }
        }
    }
}

extension CAGradientLayer {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let colors = colors as? [CGColor], colors.contains(where: { $0.themable }) {
            self.colors = colors.map { $0.withUserInterfaceTheme(theme) }
        }
    }
}

extension CAShapeLayer {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let fillColor = fillColor, fillColor.themable {
            self.fillColor = fillColor.withUserInterfaceTheme(theme)
        }
        
        if let strokeColor = strokeColor, strokeColor.themable {
            self.strokeColor = strokeColor.withUserInterfaceTheme(theme)
        }
    }
}

extension CAReplicatorLayer {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let instanceColor = instanceColor, instanceColor.themable {
            self.instanceColor = instanceColor.withUserInterfaceTheme(theme)
        }
    }
}

extension CATextLayer {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let foregroundColor = foregroundColor, foregroundColor.themable {
            self.foregroundColor = foregroundColor.withUserInterfaceTheme(theme)
        }
    }
}
