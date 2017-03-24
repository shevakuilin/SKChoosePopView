//
//  SKPopViewCollectionViewCell.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKPopViewCollectionViewCell.h"
#import "SKMacro.h"

@interface SKPopViewCollectionViewCell ()
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
    self.icon = [UIImageView new];
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    self.title = [UILabel new];
    [self addSubview:self.title];
    self.title.font = [UIFont systemFontOfSize:12];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.icon);
        make.left.equalTo(self);
        make.right.equalTo(self);
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



@end
