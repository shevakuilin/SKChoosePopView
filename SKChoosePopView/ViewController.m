//
//  ViewController.m
//  SKChoosePopView
//
//  Created by shevchenko on 17/3/23.
//  Copyright © 2017年 shevchenko. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SKPopView.h"

@interface ViewController () <SKPopViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button = [UIButton new];
    [self.view addSubview:button];
    [button setTitle:@"点击弹窗" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);

    }];
    [button addTarget:self action:@selector(showPopView) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPopView
{
    // TODO: 初始化
    SKPopView * popView = [[SKPopView alloc] initWithOptionsTitle:@[@"发生时", @"提前1小时", @"提前1天", @"提前一周", @"提前一小时", @"自定义"] OptionsIconNormal:@[@"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_", @"mn_icon_setting_25x25_"]  OptionsIconSelected:@[@"new_album_dele_12x12_", @"new_album_dele_12x12_", @"new_album_dele_12x12_", @"new_album_dele_12x12_", @"new_album_dele_12x12_", @"new_album_dele_12x12_"] selectedTitleColor:[UIColor orangeColor] delegate:self completion:^{
            // TODO: 如果这里不需要就nil
    }];
    popView.animationType = SK_TYPE_TRANSFORMATION;
    popView.animationDirection = SK_SUBTYPE_FROMCENTER;
    popView.animationDuration = 0.5;
    popView.enableRecord = YES;// 开启选择记录
    popView.enableAnimation = YES;// 开启动画
    popView.enableClickEffect = YES;// 开启点击效果
    popView.ratio = 6;// 选项数量
    // TODO: 显示
    [popView show];
}

- (void)selectedWithRow:(NSUInteger)row
{
    // TODO:处理选择
}


@end
