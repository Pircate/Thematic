//
//  AssetInfo.swift
//  Theming
//
//  Created by gaoxiang on 2021/8/17.
//

import Foundation

class AssetInfo: NSObject {
    let bundle: Bundle
    let name: String
    var alpha: CGFloat?
    
    init(bundle: Bundle, name: String, alpha: CGFloat? = nil) {
        self.bundle = bundle
        self.name = name
        self.alpha = alpha
    }
}
