//
//  SKPopAnimationMange.h
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/24.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SK_ANIMATION_TYPE) {// 动画类型
    SK_ANIMATION_TYPE_SPRING,// 弹簧效果
    SK_ANIMATION_TYPE_ROTATION,// 旋转效果
    SK_ANIMATION_TYPE_FADE,// 渐变效果
    SK_ANIMATION_TYPE_LARGEN,// 变大效果
    SK_ANIMATION_TYPE_ROTATION_LARGEN,// 旋转变大效果
    SK_ANIMATION_TYPE_TRANSFORMATION// 变形效果
//    SK_ANIMATION_TYPE_CUSTOM// 自定义效果----> 只需要处理效果，进场路线无需处理
};

typedef NS_ENUM(NSInteger, SK_ANIMATION_SUBTYPE) {// 动画方向
    SK_ANIMATION_SUBTYPE_FROMRIGHT,// 从右侧进入
    SK_ANIMATION_SUBTYPE_FROMLEFT,// 从左侧进入
    SK_ANIMATION_SUBTYPE_FROMTOP,// 从顶部进入
    SK_ANIMATION_SUBTYPE_FROMBOTTOM,// 从底部进入
    SK_ANIMATION_SUBTYPE_FROMCENTER// 从屏幕中间进入
};

@interface SKPopAnimationMange : NSObject

/** 进场动画设置 --->不需要完成后继续进行操作
 * @param duration 持续时间
 * @param type 动画类型
 * @param direction 动画方向
 */
- (void)animateWithView:(UIView *)view Duration:(NSTimeInterval)duration animationType:(SK_ANIMATION_TYPE)type animationDirection:(SK_ANIMATION_SUBTYPE)direction;

/** 退场动画设置
 * @param view 根视图
 */
- (void)dismissAnimationForRootView:(UIView *)view;

/** 点击动画
 * @param view 需要执行动画的view
 */
- (void)clickEffectAnimationForView:(UIView *)view;

@property (nonatomic, assign) SK_ANIMATION_TYPE type;// 动画类型
@property (nonatomic, assign) SK_ANIMATION_SUBTYPE animationDirection;// 动画方向

@end
