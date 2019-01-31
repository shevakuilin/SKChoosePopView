//
//  SKPopView.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "SKPopView.h"
#import "SKMacro.h"
#import "SKPopViewCollectionViewCell.h"
#import "SKPopAnimationManage.h"

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
@property (nonatomic, strong) SKPopAnimationManage * animationManage;

@property (nonatomic, assign) NSUInteger itemHeight;// 选项高度
@property (nonatomic, assign) NSUInteger itemWidth;// 选项宽度

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
            _selectedRow = -1;
            
            self.itemHeight = 0;
            self.itemWidth = 0;
            
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
    UITapGestureRecognizer * dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [grayBackground addGestureRecognizer:dismissGesture];
    
    // 弹窗部分
    self.popView = [UIView new];
    [self insertSubview:self.popView aboveSubview:grayBackground];
    self.popView.backgroundColor = [UIColor whiteColor];
    self.popView.layer.masksToBounds = YES;
    self.popView.layer.cornerRadius = 20;
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(60);
        make.right.equalTo(self).with.offset(-60);
        
        make.height.mas_offset(180);
    }];
    
    // 弹窗内选项
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
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
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(60);
        make.right.equalTo(self).with.offset(-60);
        
        // 设置约束优先级, 限制最大高度
        make.height.mas_lessThanOrEqualTo(180).priorityHigh();
        make.height.mas_offset(180);
    }];

}

#pragma mark - 手势响应
- (void)cancel
{
    [self dismissAnimation];
}

#pragma mark - 外部调用
- (void)show
{
    if (self.enableAnimation == YES) {
        [self displayAnimation];
    }
}

- (void)dismiss
{
    if (self.enableAnimation == YES) {
        [self dismissAnimation];
    } else {
        [self removeFromSuperview];
    }
}

#pragma mark - 外部配置
- (void)setEnableRecord:(BOOL)enableRecord
{
    _enableRecord = enableRecord;
    if (_enableRecord == YES) {
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault integerForKey:@"selectedRow"]) {
            NSUInteger row = [userDefault integerForKey:@"selectedRow"];
            _selectedRow = row;
        } else {
            _selectedRow = -1;
        }
    } else {
        _selectedRow = -1;
    }

}

- (void)setOptionsLine:(NSUInteger)optionsLine
{
    _optionsLine = optionsLine;
    NSUInteger lines = self.optionsTitle.count / optionsLine;
    self.itemHeight = 180 / lines;
    if (self.itemHeight < 60) {// 限制最小高度
        self.itemHeight = 60;
        
    } else if (self.itemHeight * optionsLine > 180 ) {// 限制最大高度
        self.itemHeight = 180 / optionsLine;
    }
    [self.optionsCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(self.itemHeight * optionsLine);
    }];
    [self.optionsCollectionView reloadData];
}

- (void)setOptionsRow:(NSUInteger)optionsRow
{
    _optionsRow = optionsRow;
    self.itemWidth = (MyWidth - 140) / (optionsRow);
    [self.optionsCollectionView reloadData];
}

- (void)setMinLineSpacing:(NSUInteger)minLineSpacing
{
    _minLineSpacing = minLineSpacing;
}

- (void)setMinRowSpacing:(NSUInteger)minRowSpacing
{
    _minRowSpacing = minRowSpacing;
}

#pragma mark - 动画设置
- (void)displayAnimation
{
    self.animationManage = [[SKPopAnimationManage alloc] init];
    switch (self.animationType) {
        case SK_TYPE_SPRING:
            self.animationManage.type = SK_ANIMATION_TYPE_SPRING;
            break;
        case SK_TYPE_ROTATION:
            self.animationManage.type = SK_ANIMATION_TYPE_ROTATION;
            break;
        case SK_TYPE_FADE:
            self.animationManage.type = SK_ANIMATION_TYPE_FADE;
            break;
        case SK_TYPE_LARGEN:
            self.animationManage.type = SK_ANIMATION_TYPE_LARGEN;
            break;
        case SK_TYPE_ROTATION_LARGEN:
            self.animationManage.type = SK_ANIMATION_TYPE_ROTATION_LARGEN;
            break;
        case SK_TYPE_TRANSFORMATION:
            self.animationManage.type = SK_ANIMATION_TYPE_TRANSFORMATION;
            break;
    }
    
    switch (self.animationDirection) {
        case SK_SUBTYPE_FROMRIGHT:
            self.animationManage.animationDirection = SK_ANIMATION_SUBTYPE_FROMRIGHT;
            break;
        case SK_SUBTYPE_FROMLEFT:
            self.animationManage.animationDirection = SK_ANIMATION_SUBTYPE_FROMLEFT;
            break;
        case SK_SUBTYPE_FROMTOP:
            self.animationManage.animationDirection = SK_ANIMATION_SUBTYPE_FROMTOP;
            break;

        case SK_SUBTYPE_FROMBOTTOM:
            self.animationManage.animationDirection = SK_ANIMATION_SUBTYPE_FROMBOTTOM;
            break;

        case SK_SUBTYPE_FROMCENTER:
            self.animationManage.animationDirection = SK_ANIMATION_SUBTYPE_FROMCENTER;
            break;

            
        default:
            break;
    }
    
    [self.animationManage animateWithView:self.popView Duration:self.animationDuration animationType:self.animationManage.type animationDirection:self.animationManage.animationDirection];
}

- (void)dismissAnimation
{
    if (self.enableAnimation == YES) {
        [self.animationManage dismissAnimationForRootView:self];
    } else {
        [self removeFromSuperview];
    }
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
        if (self.enableRecord == YES) {
            cell.textColor = _titleColor;
        } else {
            cell.textColor = nil;
        }
        cell.enableClickEffect = self.enableClickEffect;
    } else {
        cell.optionsIconNormal = _optionsIconNormal[indexPath.row];
        cell.textColor = nil;
        cell.enableClickEffect = NO;
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
    return CGSizeMake(self.itemWidth, self.itemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minRowSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minLineSpacing;
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
