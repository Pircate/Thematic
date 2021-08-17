// 
//  DynamicTheme.swift
//  Theming
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/27/20
//  
//

import Foundation

public class DynamicTheme: Theme {
    public var identifier: String
    let assetsDirectory: String
    
    public init(identifier: String, assetsDirectory: String) {
        self.identifier = identifier
        self.assetsDirectory = assetsDirectory
    }
    
    public var colorAssetType: ColorAssetType {
        .table
    }
    
    public var imageAssetType: ImageAssetType {
        .filePath
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
