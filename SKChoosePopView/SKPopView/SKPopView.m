//
//  SKPopView.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//
#define MyWidth   [UIScreen mainScreen].bounds.size.width
#define MyHeight    [UIScreen mainScreen].bounds.size.height

#import "SKPopView.h"
#import "Masonry.h"
#import "SKPopViewCollectionViewCell.h"

@interface SKPopView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * optionsCollectionView;// 选项collectionView
@property (nonatomic, strong) UIView * popView;// 弹窗部分
@property (nonatomic, strong) NSArray * optionsTitle;// 选项标题
@property (nonatomic, strong) NSArray * optionsIconNormal;// 默认状态图标
@property (nonatomic, strong) NSArray * optionsIconSelected;// 选中状态图标
@property (nonatomic, strong) UIColor * titleColor;// 选项标题字体颜色
@property (nonatomic, assign) NSInteger selectedRow;// 已选择的选项row
@property (nonatomic, weak) id <SKPopViewDelegate> delegate;
@property (nonatomic, copy) SKPopViewChooseCompletion completion;

@end

@implementation SKPopView

- (instancetype)initWithOptionsTitle:(NSArray *)title OptionsIconNormal:(NSArray *)iconNormal OptionsIconSelected:(NSArray *)iconSelected selectedTitleColor:(UIColor *)titleColor
                            delegate:(id <SKPopViewDelegate>)delegate completion:(SKPopViewChooseCompletion)completion
{
    if ([super init]) {
        if (self) {
            self.frame = CGRectMake(0, 0, MyWidth, MyHeight);
            
            _optionsTitle = [self getNoneNilArray:title];
            _optionsIconNormal = [self getNoneNilArray:iconNormal];
            _optionsIconSelected = [self getNoneNilArray:iconSelected];
            if (titleColor) {
                _titleColor = titleColor;
            } else {
                _titleColor = [UIColor lightGrayColor];
            }
            _delegate = delegate;
            _completion = completion;
            
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            if ([userDefault integerForKey:@"selectedRow"]) {
                NSUInteger row = [userDefault integerForKey:@"selectedRow"];
                _selectedRow = row;
            } else {
                _selectedRow = -1;
            }
            
            [self customView];
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
    }
    
    return self;
}

#pragma mark - 创建界面
- (void)customView
{
    // 灰色背景
    UIImageView * grayBackground = [UIImageView new];
    [self addSubview:grayBackground];
    grayBackground.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];;
    grayBackground.userInteractionEnabled = YES;
    [grayBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UITapGestureRecognizer * dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelShare)];
    [grayBackground addGestureRecognizer:dismissGesture];
    
    // 弹窗部分
    self.popView = [UIView new];
    [self insertSubview:self.popView aboveSubview:grayBackground];
    self.popView.backgroundColor = [UIColor whiteColor];
    self.popView.layer.masksToBounds = YES;
    self.popView.layer.cornerRadius = 20;
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.offset(180);
        make.left.equalTo(self).with.offset(60);
        make.right.equalTo(self).with.offset(-60);
        
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView 通过一个布局策略layout来创建
    self.optionsCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    [self.popView addSubview:self.optionsCollectionView];
    self.optionsCollectionView.delegate = self;
    self.optionsCollectionView.dataSource = self;
    self.optionsCollectionView.backgroundColor = [UIColor clearColor];
    self.optionsCollectionView.scrollEnabled = NO;
    self.optionsCollectionView.showsVerticalScrollIndicator = NO;
    self.optionsCollectionView.showsHorizontalScrollIndicator = NO;
    [self.optionsCollectionView registerClass:[SKPopViewCollectionViewCell class] forCellWithReuseIdentifier:@"PopView"];
    [self.optionsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.popView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}

#pragma mark - 手势响应
- (void)cancelShare
{
    [self dismissAnimation];
}

#pragma mark - 动画设置
- (void)displayAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
        }];
        self.popView.center = CGPointMake(self.center.x, self.center.y);
    }];
}

- (void)dismissAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(180);
        }];
        self.popView.center = CGPointMake(self.center.x, MyHeight + 10);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _optionsTitle.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SKPopViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopView" forIndexPath:indexPath];
    cell.optionsTitle = _optionsTitle[indexPath.row];
    if (_selectedRow >= 0 && _selectedRow == indexPath.row) {
        cell.optionsIconNormal = _optionsIconSelected[indexPath.row];
        cell.textColor = _titleColor;
    } else {
        cell.optionsIconNormal = _optionsIconNormal[indexPath.row];
        cell.textColor = nil;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(selectedWithRow:)]) {
        [_delegate selectedWithRow:indexPath.row];
    }
    _selectedRow = indexPath.row;
    [self.optionsCollectionView reloadData];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:_selectedRow forKey:@"selectedRow"];
    [userDefault synchronize];
    
    if (_completion) {
        self.completion();
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.popView.frame.size.width / 4, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark - 安全处理
/**
 * 防崩溃处理 --->该方法将传入的参数自动转换为NSArray类型，并将空值替换为空数组，以保证数据赋值时的安全性
 @param obj 传入的参数
 */
- (NSArray *)getNoneNilArray:(id)obj
{
    NSArray * array = @[];
    if (![obj isKindOfClass:[NSNull class]] && [obj isKindOfClass:[NSArray class]]) {
        array = obj;
    }
    if (obj == nil) {
        array = @[];
    }
    if ([obj isKindOfClass:[NSArray class]] && [obj isKindOfClass:[NSNull class]]) {
        array = @[];
    }
    return array;
}


@end
