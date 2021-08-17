// 
//  NSObject+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

extension NSObject: Themable {
    
    open var userInterfaceTheme: Theme {
        ThemeManager.shared.currentTheme
    }
    
    open func userInterfaceThemeDidChange(_ theme: Theme) {}
    
    /// 是否开启动态主题
    @objc public var isDynamicThemeEnabled: Bool {
        get {
            ThemeManager.shared.viewHashTable.contains(self)
        }
        set {
            if newValue {
                ThemeManager.shared.viewHashTable.add(self)
            } else {
                ThemeManager.shared.viewHashTable.remove(self)
            }
        }
    }
}

extension UIView {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let backgroundColor = backgroundColor,
           let assetInfo = backgroundColorAssetInfo {
            backgroundColor.assetInfo = assetInfo
            
            self.backgroundColor = backgroundColor.withUserInterfaceTheme(theme)
        }
        
        if let tintColor = tintColor, tintColor.themable {
            self.tintColor = tintColor.withUserInterfaceTheme(theme)
        }
        
        layer.userInterfaceThemeDidChange(theme)
    }
}

extension UILabel {

    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let textColor = textColor, textColor.themable {
            self.textColor = textColor.withUserInterfaceTheme(theme)
        }

        if let highlightedTextColor = highlightedTextColor, highlightedTextColor.themable {
            self.highlightedTextColor = highlightedTextColor.withUserInterfaceTheme(theme)
        }

        if let shadowColor = shadowColor, shadowColor.themable {
            self.shadowColor = shadowColor.withUserInterfaceTheme(theme)
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText.withUserInterfaceTheme(theme)
        }
    }
}

extension UINavigationBar {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let barTintColor = barTintColor,
           barTintColor.themable {
            self.barTintColor = barTintColor.withUserInterfaceTheme(theme)
        }

        if let attributes = titleTextAttributes {
            self.titleTextAttributes = attributes.withUserInterfaceTheme(theme)
        }

        if #available(iOS 13.0, *), let largeTitleTextAttributes = largeTitleTextAttributes {
            self.largeTitleTextAttributes = largeTitleTextAttributes.withUserInterfaceTheme(theme)
        }
    }
}

extension UIButton {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        let allStates: [UIControl.State] = [
            .normal,
            .highlighted,
            .selected,
            .disabled,
            [.selected, .highlighted]
        ]
        
        allStates.forEach { state in
            if let titleColor = titleColor(for: state), titleColor.themable {
                setTitleColor(titleColor.withUserInterfaceTheme(theme), for: state)
            }
            
            if let attributedTitle = attributedTitle(for: state) {
                setAttributedTitle(attributedTitle.withUserInterfaceTheme(theme), for: state)
            }
            
            if let image = image(for: state), image.themable {
                setImage(image.withUserInterfaceTheme(theme), for: state)
            }
            
            if let bgImage = backgroundImage(for: state), bgImage.themable {
                setBackgroundImage(bgImage.withUserInterfaceTheme(theme), for: state)
            }
        }
    }
}

extension UIImageView {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        guard let image = image, image.themable else { return }
        
        self.image = image.withUserInterfaceTheme(theme)
    }
}

extension UIBarButtonItem {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let tintColor = tintColor, tintColor.themable {
            self.tintColor = tintColor.withUserInterfaceTheme(theme)
        }
        
        if let image = image, image.themable {
            self.image = image.withUserInterfaceTheme(theme)
        }
    }
}

extension UIBarItem {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let image = image, image.themable {
            self.image = image.withUserInterfaceTheme(theme)
        }
    }
}

extension UITabBar {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let barTintColor = barTintColor, barTintColor.themable {
            self.barTintColor = barTintColor.withUserInterfaceTheme(theme)
        }

        if #available(iOS 10.0, *) {
            if let unselectedItemTintColor = unselectedItemTintColor,
               unselectedItemTintColor.themable {
                self.unselectedItemTintColor = unselectedItemTintColor.withUserInterfaceTheme(theme)
            }
        }
    }
}

extension UITabBarItem {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let selectedImage = selectedImage, selectedImage.themable {
            self.selectedImage = selectedImage.withUserInterfaceTheme(theme)
        }
    }
}

extension UITableView {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let separatorColor = separatorColor, separatorColor.themable {
            self.separatorColor = separatorColor.withUserInterfaceTheme(theme)
        }

        if let sectionIndexColor = sectionIndexColor, sectionIndexColor.themable {
            self.sectionIndexColor = sectionIndexColor.withUserInterfaceTheme(theme)
        }

        if let sectionIndexBackgroundColor = sectionIndexBackgroundColor, sectionIndexBackgroundColor.themable {
            self.sectionIndexBackgroundColor = sectionIndexBackgroundColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UITextField {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let textColor = textColor, textColor.themable {
            self.textColor = textColor.withUserInterfaceTheme(theme)
        }

        if let attributedPlaceholder = attributedPlaceholder {
            self.attributedPlaceholder = attributedPlaceholder.withUserInterfaceTheme(theme)
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText.withUserInterfaceTheme(theme)
        }
    }
}

extension UITextView {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let textColor = textColor, textColor.themable {
            self.textColor = textColor.withUserInterfaceTheme(theme)
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText.withUserInterfaceTheme(theme)
        }
    }
}

extension UISearchBar {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let barTintColor = barTintColor, barTintColor.themable {
            self.barTintColor = barTintColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UIProgressView {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let progressTintColor = progressTintColor, progressTintColor.themable {
            self.progressTintColor = progressTintColor.withUserInterfaceTheme(theme)
        }

        if let trackTintColor = trackTintColor, trackTintColor.themable {
            self.trackTintColor = trackTintColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UIPageControl {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let pageIndicatorTintColor = pageIndicatorTintColor,
           pageIndicatorTintColor.themable {
            self.pageIndicatorTintColor = pageIndicatorTintColor.withUserInterfaceTheme(theme)
        }

        if let currentPageIndicatorTintColor = currentPageIndicatorTintColor, currentPageIndicatorTintColor.themable {
            self.currentPageIndicatorTintColor = currentPageIndicatorTintColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UIActivityIndicatorView {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let color = color, color.themable {
            self.color = color.withUserInterfaceTheme(theme)
        }
    }
}

extension UIToolbar {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let barTintColor = barTintColor, barTintColor.themable {
            self.barTintColor = barTintColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UISegmentedControl {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if #available(iOS 13.0, *) {
            if let selectedSegmentTintColor = selectedSegmentTintColor,
               selectedSegmentTintColor.themable {
                self.selectedSegmentTintColor = selectedSegmentTintColor.withUserInterfaceTheme(theme)
            }
        }

        let allStates: [UIControl.State] = [
            .normal,
            .highlighted,
            .selected,
            .disabled,
            [.selected, .highlighted]
        ]

        allStates.forEach { state in
            if let titleTextAttributes = titleTextAttributes(for: state) {
                setTitleTextAttributes(titleTextAttributes.withUserInterfaceTheme(theme), for: state)
            }
        }
    }
}

extension UISwitch {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let tintColor = tintColor, tintColor.themable {
            self.tintColor = tintColor.withUserInterfaceTheme(theme)
        }

        if let thumbTintColor = thumbTintColor, thumbTintColor.themable {
            self.thumbTintColor = thumbTintColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UISlider {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)

        if let thumbTintColor = thumbTintColor, thumbTintColor.themable {
            self.thumbTintColor = thumbTintColor.withUserInterfaceTheme(theme)
        }

        if let minimumTrackTintColor = minimumTrackTintColor, minimumTrackTintColor.themable {
            self.minimumTrackTintColor = minimumTrackTintColor.withUserInterfaceTheme(theme)
        }

        if let maximumTrackTintColor = maximumTrackTintColor, maximumTrackTintColor.themable {
            self.maximumTrackTintColor = maximumTrackTintColor.withUserInterfaceTheme(theme)
        }
    }
}

extension UIPopoverPresentationController {
    
    open override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        if let backgroundColor = backgroundColor, backgroundColor.themable {
            self.backgroundColor = backgroundColor.withUserInterfaceTheme(theme)
        }
    }
}
