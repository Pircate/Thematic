//
//  UIResponder+Themable.swift
//  Thematic
//
//  Created by Pircate on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit

extension UIResponder: Themable {
    
    @objc open var theme: Theme {
        overrideTheme ?? ThemeManager.shared.currentTheme
    }
    
    @objc open func themeDidChange(_ theme: Theme) {}
    
    @objc var overrideTheme: Theme? {
        get {
            objc_getAssociatedObject(
                self,
                &AssociatedKeys.overrideTheme
            ) as? Theme
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.overrideTheme,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

extension UIViewController {
    
    private var barItems: [UIBarItem] {
        var items: [UIBarItem] = []
        
        if let leftBarButtonItems = navigationItem.leftBarButtonItems,
            !leftBarButtonItems.isEmpty {
            items += leftBarButtonItems
        }
        if let rightBarButtonItems = navigationItem.rightBarButtonItems,
            !rightBarButtonItems.isEmpty {
            items += rightBarButtonItems
        }
        if let tabBarItem = tabBarItem {
            items.append(tabBarItem)
        }
        
        return items
    }
    
    override var overrideTheme: Theme? {
        didSet {
            guard isViewLoaded else { return }
            
            themeDidChange(theme)
            view.overrideTheme = overrideTheme
        }
    }
    
    @objc open func overrideTheme(for child: UIViewController) -> Theme? {
        child.overrideTheme
    }
    
    @objc open func setOverrideTheme(_ theme: Theme, for child: UIViewController) {
        child.overrideTheme = theme
    }
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        setNeedsStatusBarAppearanceUpdate()

        barItems.forEach { $0.themeDidChange(theme) }
    }
}

extension UIView {
    
    override var overrideTheme: Theme? {
        didSet {
            themeDidChange(theme)
            
            subviews.forEach {
                $0.overrideTheme = theme
            }
        }
    }
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let backgroundColor = backgroundColor,
           let assetInfo = backgroundColorAssetInfo {
            backgroundColor.assetInfo = assetInfo
            
            self.backgroundColor = backgroundColor.withThemeComponent(theme)
        }
        
        if let tintColor = tintColor, tintColor.themable {
            self.tintColor = tintColor.withThemeComponent(theme)
        }
        
        layer.themeDidChange(theme)
    }
}

extension UILabel {

    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let textColor = textColor, textColor.themable {
            self.textColor = textColor.withThemeComponent(theme)
        }

        if let highlightedTextColor = highlightedTextColor, highlightedTextColor.themable {
            self.highlightedTextColor = highlightedTextColor.withThemeComponent(theme)
        }

        if let shadowColor = shadowColor, shadowColor.themable {
            self.shadowColor = shadowColor.withThemeComponent(theme)
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText.withThemeComponent(theme)
        }
    }
}

extension UINavigationBar {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let barTintColor = barTintColor,
           barTintColor.themable {
            self.barTintColor = barTintColor.withThemeComponent(theme)
        }

        if let attributes = titleTextAttributes {
            self.titleTextAttributes = attributes.withThemeComponent(theme)
        }

        if #available(iOS 13.0, *), let largeTitleTextAttributes = largeTitleTextAttributes {
            self.largeTitleTextAttributes = largeTitleTextAttributes.withThemeComponent(theme)
        }
    }
}

extension UIButton {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        UIControl.State.allStates.forEach { state in
            if let titleColor = titleColor(for: state), titleColor.themable {
                setTitleColor(titleColor.withThemeComponent(theme), for: state)
            }
            
            if let attributedTitle = attributedTitle(for: state) {
                setAttributedTitle(attributedTitle.withThemeComponent(theme), for: state)
            }
            
            if let image = image(for: state), image.themable {
                setImage(image.withThemeComponent(theme), for: state)
            }
            
            if let bgImage = backgroundImage(for: state), bgImage.themable {
                setBackgroundImage(bgImage.withThemeComponent(theme), for: state)
            }
        }
    }
}

extension UIImageView {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        guard let image = image, image.themable else { return }
        
        self.image = image.withThemeComponent(theme)
    }
}

extension UITabBar {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let barTintColor = barTintColor, barTintColor.themable {
            self.barTintColor = barTintColor.withThemeComponent(theme)
        }

        if #available(iOS 10.0, *) {
            if let unselectedItemTintColor = unselectedItemTintColor,
               unselectedItemTintColor.themable {
                self.unselectedItemTintColor = unselectedItemTintColor.withThemeComponent(theme)
            }
        }
    }
}

extension UITableView {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let separatorColor = separatorColor, separatorColor.themable {
            self.separatorColor = separatorColor.withThemeComponent(theme)
        }

        if let sectionIndexColor = sectionIndexColor, sectionIndexColor.themable {
            self.sectionIndexColor = sectionIndexColor.withThemeComponent(theme)
        }

        if let sectionIndexBackgroundColor = sectionIndexBackgroundColor,
           sectionIndexBackgroundColor.themable {
            self.sectionIndexBackgroundColor = sectionIndexBackgroundColor.withThemeComponent(theme)
        }
    }
}

extension UITextField {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let textColor = textColor, textColor.themable {
            self.textColor = textColor.withThemeComponent(theme)
        }

        if let attributedPlaceholder = attributedPlaceholder {
            self.attributedPlaceholder = attributedPlaceholder.withThemeComponent(theme)
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText.withThemeComponent(theme)
        }
    }
}

extension UITextView {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let textColor = textColor, textColor.themable {
            self.textColor = textColor.withThemeComponent(theme)
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText.withThemeComponent(theme)
        }
    }
}

extension UISearchBar {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let barTintColor = barTintColor, barTintColor.themable {
            self.barTintColor = barTintColor.withThemeComponent(theme)
        }
    }
}

extension UIProgressView {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let progressTintColor = progressTintColor, progressTintColor.themable {
            self.progressTintColor = progressTintColor.withThemeComponent(theme)
        }

        if let trackTintColor = trackTintColor, trackTintColor.themable {
            self.trackTintColor = trackTintColor.withThemeComponent(theme)
        }
    }
}

extension UIPageControl {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let pageIndicatorTintColor = pageIndicatorTintColor,
           pageIndicatorTintColor.themable {
            self.pageIndicatorTintColor = pageIndicatorTintColor.withThemeComponent(theme)
        }

        if let currentPageIndicatorTintColor = currentPageIndicatorTintColor,
           currentPageIndicatorTintColor.themable {
            self.currentPageIndicatorTintColor = currentPageIndicatorTintColor.withThemeComponent(theme)
        }
    }
}

extension UIActivityIndicatorView {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let color = color, color.themable {
            self.color = color.withThemeComponent(theme)
        }
    }
}

extension UIToolbar {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let barTintColor = barTintColor, barTintColor.themable {
            self.barTintColor = barTintColor.withThemeComponent(theme)
        }
    }
}

extension UISegmentedControl {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if #available(iOS 13.0, *) {
            if let selectedSegmentTintColor = selectedSegmentTintColor,
               selectedSegmentTintColor.themable {
                self.selectedSegmentTintColor = selectedSegmentTintColor.withThemeComponent(theme)
            }
        }

        UIControl.State.allStates.forEach { state in
            if let titleTextAttributes = titleTextAttributes(for: state) {
                setTitleTextAttributes(titleTextAttributes.withThemeComponent(theme), for: state)
            }
        }
    }
}

extension UISwitch {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        
        if let tintColor = tintColor, tintColor.themable {
            self.tintColor = tintColor.withThemeComponent(theme)
        }

        if let thumbTintColor = thumbTintColor, thumbTintColor.themable {
            self.thumbTintColor = thumbTintColor.withThemeComponent(theme)
        }
        
        if let onTintColor = onTintColor, let assetInfo = onTintColor.assetInfo {
            assetInfo.alpha = assetInfo.alpha == 0 ? 1 : assetInfo.alpha
            self.onTintColor = onTintColor.withThemeComponent(theme)
        }
        
        if let onImage = onImage, onImage.themable {
            self.onImage = onImage.withThemeComponent(theme)
        }
        
        if let offImage = offImage, offImage.themable {
            self.offImage = offImage.withThemeComponent(theme)
        }
    }
}

extension UISlider {
    
    open override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)

        if let thumbTintColor = thumbTintColor, thumbTintColor.themable {
            self.thumbTintColor = thumbTintColor.withThemeComponent(theme)
        }

        if let minimumTrackTintColor = minimumTrackTintColor, minimumTrackTintColor.themable {
            self.minimumTrackTintColor = minimumTrackTintColor.withThemeComponent(theme)
        }

        if let maximumTrackTintColor = maximumTrackTintColor, maximumTrackTintColor.themable {
            self.maximumTrackTintColor = maximumTrackTintColor.withThemeComponent(theme)
        }
    }
}

extension UIControl.State {
    
    static var allStates: [UIControl.State] {
        [
            .normal,
            .highlighted,
            .selected,
            .disabled,
            [.selected, .highlighted]
        ]
    }
}
