// 
//  Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

public typealias Assets = [String: String]

@objc public enum ColorAssetType: Int {
    /// Xcode 资源目录
    @available(iOS 11, *)
    case xcassets
    /// 资源映射表，可以是 plist、json 等格式
    case mapTable
}

@objc public enum ImageAssetType: Int {
    /// Xcode 资源目录
    case xcassets
    /// 文件路径，APP 根目录或者沙盒自定义路径
    case filePath
}

@objc public protocol Theme {
    
    /// 主题唯一标志符
    var identifier: String { get }
    
    /// 颜色资源加载方式
    var colorAssetType: ColorAssetType { get }
    
    /// 图片资源加载方式
    var imageAssetType: ImageAssetType { get }
    
    /// 键盘显示风格
    var keyboardAppearance: UIKeyboardAppearance { get }
    
    /// 颜色资源名称，当 colorAssetType 为 xcassets 时调用，
    /// 用于加载 xcassets 中的颜色资源，一般用文件夹对主题进行区分
    /// - Parameter assetName: 资源名称
    func colorAssetName(_ assetName: String) -> String
    
    /// 颜色资源合集，当 colorAssetType 为 table 时调用，返回一组颜色配置表
    /// - Parameter bundle: 颜色资源合集所在的 bundle
    func colorAssets(in bundle: Bundle) -> Assets
    
    /// 图片资源名称，当 imageAssetType 为 xcassets 时调用，
    /// 用于加载 xcassets 中的图片资源，一般用文件夹对主题进行区分
    /// - Parameter assetName: 资源名称
    func imageAssetName(_ assetName: String) -> String
    
    /// 图片资源路径，当 imageAssetType 为 file 时调用，用于以文件路径方式加载图片
    /// - Parameter assetName: 资源名称
    func imageAssetPath(_ assetName: String) -> String
}

@objc public protocol Themable {
    
    /// 主题
    var theme: Theme { get }
    
    /// 主题发生变化
    /// - Parameter theme: 主题
    func themeDidChange(_ theme: Theme)
}
