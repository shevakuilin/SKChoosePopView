//
//  SKPopView.h
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SK_TYPE) {// 动画类型
    SK_TYPE_SPRING,// 弹簧效果
    SK_TYPE_ROTATION,// 旋转效果
    SK_TYPE_FADE,// 渐变效果
    SK_TYPE_LARGEN,// 变大效果
    SK_TYPE_ROTATION_LARGEN,// 旋转变大效果
    SK_TYPE_TRANSFORMATION// 变形效果
};

typedef NS_ENUM(NSInteger, SK_SUBTYPE) {// 动画方向
    SK_SUBTYPE_FROMRIGHT,// 从右侧进入
    SK_SUBTYPE_FROMLEFT,// 从左侧进入
    SK_SUBTYPE_FROMTOP,// 从顶部进入
    SK_SUBTYPE_FROMBOTTOM,// 从底部进入
    SK_SUBTYPE_FROMCENTER// 从屏幕中间进入
};

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
 * @param iconSelected 选中图标数组, 若不需要传入nil即可
 * @param titleColor 选中的选项标题字体颜色, 若不需要传入nil即可
 * @param delegate 代理协议
 * @param completion 弹窗出现后的回调操作，若不需要传入nil即可
 */
- (instancetype)initWithOptionsTitle:(NSArray *)title
                OptionsIconNormal:(NSArray *)iconNormal
                 OptionsIconSelected:(NSArray *)iconSelected
                  selectedTitleColor:(UIColor *)titleColor
                            delegate:(id <SKPopViewDelegate>)delegate
                          completion:(SKPopViewChooseCompletion)completion;

- (void)show;// 显示弹窗
- (void)dismiss;// 消失弹窗

@property (nonatomic, assign) BOOL enableRecord;// 开启选择记录, 会自动记录上一次的选择情况，默认为NO
@property (nonatomic, assign) BOOL enableAnimation;// 开启动画，默认为NO
@property (nonatomic, assign) BOOL enableClickEffect;// 开启点击效果, 默认为NO
@property (nonatomic, assign) NSUInteger optionsLine;// 显示的行数--->纵向
@property (nonatomic, assign) NSUInteger optionsRow;// 显示的列数---->横向
@property (nonatomic, assign) NSUInteger minLineSpacing;// 最小行间距, 默认为0
@property (nonatomic, assign) NSUInteger minRowSpacing;// 最小列间距, 默认为0
@property (nonatomic, assign) SK_TYPE animationType;// 动画类型
@property (nonatomic, assign) SK_SUBTYPE animationDirection;// 动画出现的方向
@property (nonatomic, assign) NSTimeInterval animationDuration;// 动画持续时间
// TODO:弹窗弹出的速率Speed

@end
