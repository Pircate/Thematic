// 
//  UserInterfaceTheme.swift
//  Theme
//
//  Created by Pircate(swifter.dev@gmail.com) on 12/23/20
//  
//

import UIKit

@objc public enum UserInterfaceTheme: Int {
    case unspecified
    case `default`
    case light
    case dark
    
    @available(iOS 13.0, *)
    public static var automatic: UserInterfaceTheme {
        switch UITraitCollection.current.userInterfaceStyle {
        case .light:
            return .light
        case .dark:
            return .dark
        case .unspecified:
            return .unspecified
        @unknown default:
            return .default
        }
    }
    
    public internal(set) static var current: UserInterfaceTheme = .default
}

extension UserInterfaceTheme: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .default:
            return "default"
        case .light:
            return "light"
        case .dark:
            return "dark"
        }
    }
    
    var theme: Theme {
        switch self {
        case .unspecified:
            return ThemeManager.shared.currentTheme
        case .default:
            return DefaultTheme()
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
}

extension Theme {
    
    func loadAssets(in bundle: Bundle) -> Assets {
        guard let url = bundle.url(forResource: identifier, withExtension: "plist") else {
            debugPrint("Couldn't found \(identifier).plist.")
            return [:]
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try PropertyListDecoder().decode(Assets.self, from: data)
        } catch {
            debugPrint("Decode \(identifier).plist error: \(error).")
            return [:]
        }
    }
}