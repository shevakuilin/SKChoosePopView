//
//  SKPopViewCollectionViewCell.h
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKPopViewCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString * optionsTitle;// 选项标题
@property (nonatomic, strong) NSString * optionsIconNormal;// 默认状态图标
@property (nonatomic, strong) NSString * optionsIconSelected;// 选中状态图标
@property (nonatomic, strong) UIColor * textColor;// 标题颜色, 默认亮灰色
@property (nonatomic, assign) BOOL enableClickEffect;// 开启点击效果, 默认为NO

@end
