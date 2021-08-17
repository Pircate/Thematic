//
//  ThemeManager+ApplyTheme.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import Foundation

public extension ThemeManager {
    
    /// 当前UI主题
    var currentUserInterfaceTheme: UserInterfaceTheme {
        UserInterfaceTheme.current
    }
    
    /// 设置UI主题，支持默认几种主题的设置
    /// - Parameter theme: UI主题
    func applyUserInterfaceTheme(_ theme: UserInterfaceTheme) {
        guard theme != .unspecified else {
            assertionFailure("Unspecified theme please use applyDynamicTheme(_:).")
            return
        }
        
        UserInterfaceTheme.current = theme
        
        applyTheme(theme.theme)
    }
    
    /// 设置动态主题，一般用于从云端下载主题资源文件生成DynamicTheme来配置动态主题
    /// - Parameter theme: 动态主题
    func applyDynamicTheme(_ theme: DynamicTheme) {
        UserInterfaceTheme.current = .unspecified
        
        applyTheme(theme)
    }
    
    /// 设置自动主题，跟随系统自动切换
    /// - Parameter automatic: 自动主题
    @available(iOS 13.0, *)
    func applyAutomaticTheme(_ automatic: Bool) {
        let notificationName = UIApplication.didBecomeActiveNotification
        
        guard automatic else {
            NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
            return
        }
        
        applyUserInterfaceTheme(.automatic)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: notificationName,
            object: nil
        )
    }
    
    @available(iOS 13.0, *)
    @objc private func applicationDidBecomeActive() {
        applyUserInterfaceTheme(.automatic)
    }
}
