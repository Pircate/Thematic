# Thematic

[![CI Status](https://img.shields.io/travis/gao497868860@163.com/Thematic.svg?style=flat)](https://travis-ci.org/gao497868860@163.com/Thematic)
[![Version](https://img.shields.io/cocoapods/v/Thematic.svg?style=flat)](https://cocoapods.org/pods/Thematic)
[![License](https://img.shields.io/cocoapods/l/Thematic.svg?style=flat)](https://cocoapods.org/pods/Thematic)
[![Platform](https://img.shields.io/cocoapods/p/Thematic.svg?style=flat)](https://cocoapods.org/pods/Thematic)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0
* Swift 5.2

## Installation

Thematic is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Thematic'
```

## Usage

* ### 创建一个主题

```swift
public class DarkTheme: Theme {
    
    public init() {}
    
    /// 资源的唯一标识符
    public var identifier: String { UserInterfaceTheme.dark.description }
    
    /// 颜色资源的加载方式，分为 xcassets 和 映射表两种方式
    public var colorAssetType: ColorAssetType {
        .mapTable
    }
    
    /// 图片资源的加载方式，分为 xcassets 和文件路径两种方式
    public var imageAssetType: ImageAssetType {
        .xcassets
    }
    
    /// 如果是 xcassets 方式加载颜色，需要实现格式化名字的方法，一般用标识符做文件夹加以区分。
    /// eg. dark/[colorName]，可以查看 Demo 里面的 Theme.xcassets
    public func colorAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    /// 如果是映射表方式加载颜色，需要提供一张颜色资源映射表
    public func colorAssets(in bundle: Bundle) -> Assets {
        loadAssets(in: bundle)
    }
    
    /// 如果是 xcassets 方式加载图片，需要实现格式化名字的方法，一般用标识符做文件夹加以区分。
    /// eg. dark/[imageName]，，可以查看 Demo 里面的 Theme.xcassets
    public func imageAssetName(_ assetName: String) -> String {
        "\(identifier)/\(assetName)"
    }
    
    /// 如果是文件路径方式加载图片，如果生成文件所在的路径名称
    public func imageAssetPath(_ assetName: String) -> String {
        "\(assetsDirectory)/\(assetName)"
    }
}
```

* ### 应用主题

```swift
/// 添加资源所在的 bundle，比如资源文件在主工程就添加 main bundle
ThemeManager.shared.appendResourceBundle(.main)

if #available(iOS 13.0, *) {
  /// iOS 13 之后可以设置跟随系统，会在 APP 激活的时候自动切换主题
  ThemeManager.shared.applyAutomaticTheme(true)
} else {
  /// 应用 light 主题
  ThemeManager.shared.applyUserInterfaceTheme(.light)
}
```

* ### 设置颜色或图片

```swift
/// 设置主题颜色
view.backgroundColor = UIColor(assetName: "main", in: .main)

/// 设置主题图片
imageView.image = UIImage(assetName: "sleep", in: .main)

```

## Author

gao497868860@163.com, Pircate

## License

Thematic is available under the MIT license. See the LICENSE file for more info.
