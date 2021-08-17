//
//  AssetInfo.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
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
