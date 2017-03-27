//
//  SKPopAnimationMange.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/24.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKPopAnimationManger.h"
#import "SKMacro.h"

@interface SKPopAnimationManger () <CAAnimationDelegate>
@property (nonatomic, strong) UIView * animationView;// 执行动画的view
@property (nonatomic, assign) NSTimeInterval animationDuration;// 动画持续时间

@end

@implementation SKPopAnimationManger

- (instancetype)init
{
    if ([super init]) {
        if (self) {

        }
    }
    
    return self;
}


- (void)animateWithView:(UIView *)view Duration:(NSTimeInterval)duration animationType:(SK_ANIMATION_TYPE)type animationDirection:(SK_ANIMATION_SUBTYPE)direction
{
    _animationView = view;
    _animationDuration = duration;
    _animationDirection = direction;
    
    switch (type) {
        case SK_ANIMATION_TYPE_SPRING:// 弹簧效果
            [self springAnimation];
            break;
            
        case SK_ANIMATION_TYPE_ROTATION:// 旋转效果
            [self rotationAnimation];
            break;
            
        case SK_ANIMATION_TYPE_FADE:// 渐变效果
            [self fadeAnimation];
            break;
            
        case SK_ANIMATION_TYPE_LARGEN:// 变大效果
            [self largenAnimation];
            break;
            
        case SK_ANIMATION_TYPE_ROTATION_LARGEN:// 旋转变大效果
            [self rotationAndLargenAnimation];
            break;
            
        case SK_ANIMATION_TYPE_TRANSFORMATION:// 变形效果
            [self transformationAnimation];
            break;
    }
}

#pragma mark ------------------------ 进场动画 ---------------------------------
#pragma mark - 动画方向初始化
- (void)animationDirectionInitialize
{
    if (_animationDirection == SK_ANIMATION_SUBTYPE_FROMRIGHT) {
        _animationView.center = CGPointMake(MyWidth + 1000, WindowCenter.y);
        
    } else if (_animationDirection == SK_ANIMATION_SUBTYPE_FROMLEFT) {
        _animationView.center = CGPointMake(MyWidth - 1000, WindowCenter.y);
        
    } else if (_animationDirection == SK_ANIMATION_SUBTYPE_FROMTOP) {
        _animationView.center = CGPointMake(WindowCenter.x, MyHeight - 1000);
        
    } else if (_animationDirection == SK_ANIMATION_SUBTYPE_FROMBOTTOM) {
        _animationView.center = CGPointMake(WindowCenter.x, MyHeight + 1000);
        
    } else {
        _animationView.center = WindowCenter;
    }

}

#pragma mark - 动画通用位移
- (CAKeyframeAnimation *)partOfTheAnimationGroupPosition:(CGPoint)startPosition
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue * startValue, * endValue;
    startValue = [NSValue valueWithCGPoint:startPosition];
    endValue = [NSValue valueWithCGPoint:WindowCenter];
    animation.values = @[startValue, endValue];
    animation.duration = _animationDuration;
    
    return animation;
}


#pragma mark - 弹簧效果
- (void)springAnimation
{
    [self animationDirectionInitialize];
    [self displacementWithStartPosition:_animationView.center];
}

/** 弹簧效果位移部分
 * @param startPosition 位移起始坐标
 */
- (void)displacementWithStartPosition:(CGPoint)startPosition{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];// 创建关键帧动画
    NSValue * startValue, * endValue;
    startValue = [NSValue valueWithCGPoint:startPosition];
    endValue = [NSValue valueWithCGPoint:WindowCenter];
    animation.values = @[startValue, endValue];
    animation.duration = _animationDuration;
    animation.delegate = self;
    [_animationView.layer addAnimation:animation forKey:@"pathAnimation"];
}

/** 弹簧效果晃动部分
 */
- (void)partOfTheSpringGroupShaking
{
    NSString * keyPath = @"";
    if (_animationDirection == SK_ANIMATION_SUBTYPE_FROMLEFT || _animationDirection == SK_ANIMATION_SUBTYPE_FROMRIGHT) {// 判断弹窗的来向
        keyPath = @"transform.translation.x";
    } else {
        keyPath = @"transform.translation.y";
    }
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = [NSNumber numberWithFloat:-20.0];
    animation.toValue = [NSNumber numberWithFloat:20.0];
    animation.duration = 0.1;
    animation.autoreverses = YES;// 是否重复
    animation.repeatCount = 2;// 重复次数
    [_animationView.layer addAnimation:animation forKey:@"shakeAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self partOfTheSpringGroupShaking];
}

#pragma mark - 旋转效果
- (void)rotationAnimation
{
    [self animationDirectionInitialize];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self partOfTheAnimationGroupPosition:_animationView.center], [self rotationAnimationGroup]];
    animationGroup.duration = _animationDuration;
    [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];
    
}

- (CABasicAnimation *)rotationAnimationGroup
{
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = _animationDuration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;// 无限旋转
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return rotationAnimation;
}

#pragma mark - 渐变效果
- (void)fadeAnimation
{
    [self animationDirectionInitialize];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self partOfTheAnimationGroupPosition:_animationView.center], [self fadeAnimationGroup]];
    animationGroup.duration = _animationDuration;
    [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];

}

- (CABasicAnimation *)fadeAnimationGroup
{
    CABasicAnimation * fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeAnimation.duration = _animationDuration;
    
    return fadeAnimation;
}

#pragma mark - 变大效果
- (void)largenAnimation
{
    [self animationDirectionInitialize];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self partOfTheAnimationGroupPosition:_animationView.center], [self largenAnimationGroup]];
    animationGroup.duration = _animationDuration;
    [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];

}

- (CABasicAnimation *)largenAnimationGroup
{
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = _animationDuration;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return scaleAnimation;
}

#pragma mark - 旋转变大效果
- (void)rotationAndLargenAnimation
{
    [self animationDirectionInitialize];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self partOfTheAnimationGroupPosition:_animationView.center], [self largenAnimationGroup], [self rotationAnimationGroup]];
    animationGroup.duration = _animationDuration;
    [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];
}

#pragma mark - 变形效果
- (void)transformationAnimation
{
    [self animationDirectionInitialize];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self partOfTheAnimationGroupPosition:_animationView.center], [self transformationAnimationGroup]];
    animationGroup.duration = _animationDuration;
    [_animationView.layer addAnimation:animationGroup forKey:@"groupAnimation"];

}


- (CABasicAnimation *)transformationAnimationGroup
{
    CABasicAnimation * boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(_animationView.bounds.origin.x, _animationView.bounds.origin.y, 0, 0)];
    boundsAnimation.byValue = [NSValue valueWithCGRect:CGRectMake(_animationView.bounds.origin.x, _animationView.bounds.origin.y, 100, 100)];
    boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(_animationView.bounds.origin.x, _animationView.bounds.origin.y, MyWidth - 120, 180)];
    boundsAnimation.duration = _animationDuration;
    boundsAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    boundsAnimation.repeatCount = 1;
    boundsAnimation.autoreverses = YES;

    return boundsAnimation;
}


#pragma mark ------------------------ 退场动画 ---------------------------------
- (void)dismissAnimationForRootView:(UIView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        _animationView.center = CGPointMake(WindowCenter.x, MyHeight + 1000);
        
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

#pragma mark ------------------------ 选项点击动画 ------------------------------
- (void)clickEffectAnimationForView:(UIView *)view
{
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.8];
    scaleAnimation.duration = 0.1;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:scaleAnimation forKey:nil];
}

@end
