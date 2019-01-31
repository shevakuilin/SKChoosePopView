//
//  SKDateSource.h
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/25.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKDateSource : NSObject

+ (SKDateSource *)shareDateSource;

@property (nonatomic, copy) NSArray * normalIcons;
@property (nonatomic, copy) NSArray * selectedIcons;
@property (nonatomic, copy) NSArray * titles;

@property (nonatomic, copy) NSArray * oneNormalIcon;
@property (nonatomic, copy) NSArray * oneSelectedIcon;
@property (nonatomic, copy) NSArray * oneTitle;

@end
