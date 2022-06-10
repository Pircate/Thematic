// 
//  DynamicTheme.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import Foundation

@objcMembers
public class DynamicTheme: NSObject, Theme {
    public var identifier: String
    public let assetsDirectory: String
    
    public init(identifier: String, assetsDirectory: String) {
        self.identifier = identifier
        self.assetsDirectory = assetsDirectory
    }
    
    public var colorAssetType: ColorAssetType {
        .mapTable
    }
    
    public var imageAssetType: ImageAssetType {
        .filePath
    }
    
    public var keyboardAppearance: UIKeyboardAppearance {
        .default
    }
    
    public func colorAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    public func colorAssets(in bundle: Bundle) -> Assets {
        let path = "\(assetsDirectory)/\(identifier).plist"
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try PropertyListDecoder().decode(Assets.self, from: data)
        } catch {
            return [:]
        }
    }
    
    public func imageAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    public func imageAssetPath(_ assetName: String) -> String {
        "\(assetsDirectory)/\(assetName)"
    }
}
