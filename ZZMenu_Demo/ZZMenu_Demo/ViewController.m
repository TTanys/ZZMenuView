//
//  ViewController.m
//  ZZMenu_Demo
//
//  Created by zhajianjun on 2017/1/17.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import "ViewController.h"
#import "UIView+frame.h"
#import "ZZMenuViewController.h"

@interface ViewController ()
{
    UILabel *_label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-150)/2.0, 200, 150, 50)];
    _label.backgroundColor = [UIColor redColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(_label.left+40, _label.bottom+40, 70, 40);
    [btn setTitle:@"分类列表" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClicked:(UIButton *)btn{
    ZZMenuViewController *menuVc = [ZZMenuViewController new];
    menuVc.dataBlock = ^(DataModel *model){
        _label.text = model.itemName;
        NSLog(@"===%@===",model.itemID);
    };
    [self.navigationController pushViewController:menuVc animated:YES];
}

@end
