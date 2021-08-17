// 
//  DarkTheme.swift
//  Theming
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/27/20
//  
//

import Foundation

public class DarkTheme: Theme {
    
    public init() {}
    
    public var identifier: String { UserInterfaceTheme.dark.description }
    
    public var colorAssetType: ColorAssetType {
        .table
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
