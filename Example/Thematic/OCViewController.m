//
//  OCViewController.m
//  Thematic_Example
//
//  Created by gaoxiang on 2021/8/18.
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
}

- (void)themeDidChange:(id<Theme>)theme {
    [super themeDidChange:theme];
    
}

@end
