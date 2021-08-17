// 
//  NSAttributedString+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    
    @objc func withUserInterfaceTheme(_ theme: Theme) -> NSAttributedString {
        let range = NSRange(location: 0, length: length)
        let mAttrText = NSMutableAttributedString(attributedString: self)
        
        enumerateAttributes(
            in: range,
            options: []
        ) { attributes, range, _ in
            mAttrText.setAttributes(
                attributes.withUserInterfaceTheme(theme),
                range: range
            )
        }
        
        return mAttrText
    }
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    
    func withUserInterfaceTheme(_ theme: Theme) -> Self {
        var attrs = self
        
        if let color = self[.foregroundColor] as? UIColor, color.themable {
            attrs[.foregroundColor] = color.withUserInterfaceTheme(theme)
        }
        
        if let color = self[.backgroundColor] as? UIColor, color.themable {
            attrs[.backgroundColor] = color.withUserInterfaceTheme(theme)
        }
        
        if let color = self[.strokeColor] as? UIColor, color.themable {
            attrs[.strokeColor] = color.withUserInterfaceTheme(theme)
        }
        
        if let color = self[.underlineColor] as? UIColor, color.themable {
            attrs[.underlineColor] = color.withUserInterfaceTheme(theme)
        }
        
        if let color = self[.strikethroughColor] as? UIColor, color.themable {
            attrs[.strikethroughColor] = color.withUserInterfaceTheme(theme)
        }
        
        return attrs
    }
}
