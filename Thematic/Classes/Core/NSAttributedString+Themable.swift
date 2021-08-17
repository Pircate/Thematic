// 
//  NSAttributedString+Themable.swift
//  Theming
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/30/20
//  
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
