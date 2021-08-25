// 
//  DefaultTheme.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import Foundation

@objcMembers
public class DefaultTheme: NSObject, Theme {
    
    public override init() {}
    
    public var identifier: String { UserInterfaceTheme.default.description }
    
    public var colorAssetType: ColorAssetType {
        if #available(iOS 11, *) {
            return .xcassets
        } else {
            return .mapTable
        }
    }
    
    public var imageAssetType: ImageAssetType {
        .xcassets
    }
    
    public func colorAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    public func colorAssets(in bundle: Bundle) -> Assets {
        loadAssets(in: bundle)
    }
    
    public func imageAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    public func imageAssetPath(_ assetName: String) -> String {
        ""
    }
}
