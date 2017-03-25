//
//  ViewController.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//
#define kDate [SKDateSource shareDateSource]

#import "ViewController.h"
#import "Masonry.h"
#import "SKPopView.h"
#import "SKDateSource.h"

@interface ViewController () <SKPopViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * exampleList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.exampleList = @[@{@"title":@"SPRING", @"sel":NSStringFromSelector(@selector(spring))},
                           @{@"title":@"ROTATION", @"sel":NSStringFromSelector(@selector(rotation))},
                           @{@"title":@"FADE", @"sel":NSStringFromSelector(@selector(fade))},
                           @{@"title":@"LARGEN", @"sel":NSStringFromSelector(@selector(largen))},
                           @{@"title":@"ROTATION_LARGEN", @"sel":NSStringFromSelector(@selector(rotationAndLargen))},
                           @{@"title":@"TRANSFORMATION", @"sel":NSStringFromSelector(@selector(transformation))},
                           @{@"title":@"NO_ANIMATION", @"sel":NSStringFromSelector(@selector(noAnimation))},
                           @{@"title":@"NO_RECORD", @"sel":NSStringFromSelector(@selector(noRecord))},
                           @{@"title":@"ENABLE_CLICKEFFECT", @"sel":NSStringFromSelector(@selector(enableClickEffect))},
                           @{@"title":@"ONE_OPTION", @"sel":NSStringFromSelector(@selector(oneOption))}];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.exampleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.exampleList[indexPath.row][@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = NSSelectorFromString(self.exampleList[indexPath.row][@"sel"]);
    IMP imp = [self methodForSelector:selector];
    void (* func)(id, SEL) = (void *)imp;
    func(self, selector);

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - 类型展示
- (void)spring// 弹簧效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_SPRING;
    popView.animationDirection = SK_SUBTYPE_FROMBOTTOM;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];
}

- (void)rotation// 旋转效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_ROTATION;// 动画类型
    popView.animationDirection = SK_SUBTYPE_FROMCENTER;// 动画进场方向
    popView.animationDuration = 0.5;// 动画持续时间
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)fade// 渐变效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_FADE;
    popView.animationDirection = SK_SUBTYPE_FROMCENTER;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)largen// 变大效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_LARGEN;
    popView.animationDirection = SK_SUBTYPE_FROMCENTER;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)rotationAndLargen// 旋转变大效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_ROTATION_LARGEN;
    popView.animationDirection = SK_SUBTYPE_FROMCENTER;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)transformation// 变形效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_TRANSFORMATION;
    popView.animationDirection = SK_SUBTYPE_FROMBOTTOM;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)noAnimation// 无动画
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = NO;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)noRecord// 无记录选择
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_ROTATION;
    popView.animationDirection = SK_SUBTYPE_FROMLEFT;
    popView.animationDuration = 0.5;
    popView.enableRecord = NO;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)enableClickEffect// 开启点击效果
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.titles OptionsIconNormal:kDate.normalIcons  OptionsIconSelected:kDate.selectedIcons selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_ROTATION;
    popView.animationDirection = SK_SUBTYPE_FROMTOP;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 2;// 行数设置
    popView.optionsRow = 3;// 列数设置
    popView.enableClickEffect = YES;
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

- (void)oneOption// 单选项
{
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:kDate.oneTitle OptionsIconNormal:kDate.oneNormalIcon  OptionsIconSelected:kDate.oneSelectedIcon selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
        // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_FADE;
    popView.animationDirection = SK_SUBTYPE_FROMRIGHT;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.optionsLine = 1;// 行数设置
    popView.optionsRow = 1;// 列数设置
    popView.minLineSpacing = 10;// 最小行间距
    // TODO: 显示
    [popView show];

}

#pragma mark SKPopViewDelegate
- (void)selectedWithRow:(NSUInteger)row
{
    // TODO:处理选择
}


@end
