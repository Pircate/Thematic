//
//  OCViewController.m
//  Thematic_Example
//
//  Created by Pircate on 2021/8/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "OCViewController.h"
@import Thematic;

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ThemeManager.shared appendResourceBundle:NSBundle.mainBundle];
    [ThemeManager.shared applyUserInterfaceTheme:UserInterfaceThemeLight];
    id<Theme> theme = [[DarkTheme alloc] init];
    DynamicTheme *dynamicTheme = [[DynamicTheme alloc] initWithIdentifier:@"" assetsDirectory:@""];
    [ThemeManager.shared applyTheme:theme];
    [ThemeManager.shared applyDynamicTheme:dynamicTheme];
    if (@available(iOS 13.0, *)) {
        [ThemeManager.shared applyAutomaticTheme:YES];
    } else {
        // Fallback on earlier versions
    }
}

- (void)themeDidChange:(id<Theme>)theme {
    [super themeDidChange:theme];
    
}

@end
