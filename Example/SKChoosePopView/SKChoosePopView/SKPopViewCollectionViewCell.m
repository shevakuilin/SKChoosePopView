//
//  SKPopViewCollectionViewCell.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKPopViewCollectionViewCell.h"
#import "SKMacro.h"
#import "SKPopAnimationManage.h"

@interface SKPopViewCollectionViewCell ()
@property (nonatomic, strong) UIView * basementView;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * title;

@end

@implementation SKPopViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            [self customView];
        }
    }
    
    return self;
}

#pragma mark - 创建界面
- (void)customView
{
    self.basementView = [UIView new];
    [self addSubview:self.basementView];
    self.basementView.backgroundColor = [UIColor clearColor];
    [self.basementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.icon = [UIImageView new];
    [self.basementView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basementView);
        make.centerY.equalTo(self).with.offset(-10);
        
    }];
    
    self.title = [UILabel new];
    [self.basementView addSubview:self.title];
    self.title.font = [UIFont systemFontOfSize:12];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.icon);
        make.left.equalTo(self.basementView);
        make.right.equalTo(self.basementView);
    }];
}

#pragma mark - 数据源
- (void)setOptionsTitle:(NSString *)optionsTitle
{
    _optionsTitle = optionsTitle;
    self.title.text = optionsTitle;
}

- (void)setOptionsIconNormal:(NSString *)optionsIconNormal
{
    _optionsIconNormal = optionsIconNormal;
    self.icon.image = [UIImage imageNamed:optionsIconNormal];
}

- (void)setOptionsIconSelected:(NSString *)optionsIconSelected
{
    if (optionsIconSelected) {
        _optionsIconSelected = optionsIconSelected;
        self.icon.image = [UIImage imageNamed:optionsIconSelected];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if (textColor) {
        _textColor = textColor;
        self.title.textColor = textColor;
    } else {
        self.title.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark - 外部配置
- (void)setEnableClickEffect:(BOOL)enableClickEffect
{
    _enableClickEffect = enableClickEffect;
    if (enableClickEffect == YES) {
        SKPopAnimationManage * animationManage = [[SKPopAnimationManage alloc] init];
        [animationManage clickEffectAnimationForView:self.basementView];
    }
}

@end
