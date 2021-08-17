//
//  CALayer+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import Foundation

extension CALayer {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let backgroundColor = backgroundColor, backgroundColor.themable {
            self.backgroundColor = backgroundColor.withThemeComponent(theme)
        }
        
        if let borderColor = borderColor, borderColor.themable {
            self.borderColor = borderColor.withThemeComponent(theme)
        }
        
        if let shadowColor = shadowColor, shadowColor.themable {
            self.shadowColor = shadowColor.withThemeComponent(theme)
        }
        
        if let sublayers = sublayers?.filter({ !$0.isMember(of: CALayer.self) }),
           !sublayers.isEmpty {
            sublayers.forEach { $0.themeDidChange(theme) }
        }
    }
}

extension CAGradientLayer {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let colors = colors as? [CGColor], colors.contains(where: { $0.themable }) {
            self.colors = colors.map { $0.withThemeComponent(theme) }
        }
    }
}

extension CAShapeLayer {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let fillColor = fillColor, fillColor.themable {
            self.fillColor = fillColor.withThemeComponent(theme)
        }
        
        if let strokeColor = strokeColor, strokeColor.themable {
            self.strokeColor = strokeColor.withThemeComponent(theme)
        }
    }
}

extension CAReplicatorLayer {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let instanceColor = instanceColor, instanceColor.themable {
            self.instanceColor = instanceColor.withThemeComponent(theme)
        }
    }
}

extension CATextLayer {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let foregroundColor = foregroundColor, foregroundColor.themable {
            self.foregroundColor = foregroundColor.withThemeComponent(theme)
        }
    }
}
