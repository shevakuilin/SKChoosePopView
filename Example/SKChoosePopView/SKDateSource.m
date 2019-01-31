//
//  SKDateSource.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/25.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKDateSource.h"

@implementation SKDateSource

+ (SKDateSource *)shareDateSource
{
    static SKDateSource * shareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSingleton = [[self alloc] init];
        [shareSingleton dateSource];
    });
    
    return shareSingleton;
}

- (void)dateSource
{
    self.normalIcons = @[@"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_"];
    
    self.selectedIcons = @[@"v3player_0081_25x25_", @"v3player_0081_25x25_", @"v3player_0081_25x25_", @"v3player_0081_25x25_", @"v3player_0081_25x25_", @"v3player_0081_25x25_"];
    
    self.titles = @[@"one", @"two", @"three", @"four", @"five", @"six"];
    
    self.oneTitle = @[@"one"];
    
    self.oneSelectedIcon = @[@"v3player_0081_25x25_"];
    
    self.oneNormalIcon = @[@"mn_icon_setting_25x25_"];
}

@end
