//
//  SKPopView.h
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SKPopViewChooseCompletion)(void);

@class SKPopView;

@protocol SKPopViewDelegate <NSObject>

/**
 * @param row 已选择的选项row
 */
- (void)selectedWithRow:(NSUInteger)row;

@end

@interface SKPopView : UIView

/** 初始化方法
 * @param title 标题数组
 * @param iconNormal 默认图标数组
 * @param iconSelected 选中图标数组
 * @param titleColor 选中的选项标题字体颜色
 * @param delegate 代理协议
 */
- (instancetype)initWithOptionsTitle:(NSArray *)title
                OptionsIconNormal:(NSArray *)iconNormal
                 OptionsIconSelected:(NSArray *)iconSelected
                  selectedTitleColor:(UIColor *)titleColor
                            delegate:(id <SKPopViewDelegate>)delegate
                          completion:(SKPopViewChooseCompletion)completion;

- (void)displayAnimation;// 从底部弹出选项框的动画


@end
