//
//  ZZMenuViewController.m
//  ZZMenu_Demo
//
//  Created by zhajianjun on 2017/1/17.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import "ZZMenuViewController.h"
#import "UIView+frame.h"
#import "ZZMenuView.h"
#import "DataModel.h"
#import "MJExtension.h"

@interface ZZMenuViewController ()<ZZMenuViewDelegate,ZZMenuViewDataSource>
{
    NSMutableArray *_dictArr;
}
@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation ZZMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dictArr = [NSMutableArray arrayWithObjects:
                @{@"itemName":@"家用电器",
                  @"itemID":@"0",
                  @"itemCatagory":@[@{@"itemName":@"冰箱",
                                      @"itemID":@"1",
                                      @"itemCatagory":@[]},
                                    @{@"itemName":@"洗衣机",
                                      @"itemID":@"2",
                                      @"itemCatagory":@[]},
                                    @{@"itemName":@"电视",
                                      @"itemID":@"3",
                                      @"itemCatagory":@[]}]},
                @{@"itemName":@"电子产品",
                  @"itemID":@"10",
                  @"itemCatagory":@[@{@"itemName":@"无人机",
                                      @"itemID":@"11",
                                      @"itemCatagory":@[]},
                                    @{@"itemName":@"苹果系列",
                                      @"itemID":@"12",
                                      @"itemCatagory":@[@{@"itemName":@"iPhone7",
                                                          @"itemID":@"14",
                                                          @"itemCatagory":@[]},
                                                        @{@"itemName":@"iPad Air 2",
                                                          @"itemID":@"15",
                                                          @"itemCatagory":@[]},
                                                        @{@"itemName":@"Apple TV",
                                                          @"itemID":@"16",
                                                          @"itemCatagory":@[]}]},
                                    @{@"itemName":@"遥控器",
                                      @"itemID":@"13",
                                      @"itemCatagory":@[]}]},
                @{@"itemName":@"男装",
                  @"itemID":@"20",
                  @"itemCatagory":@[]}, nil];
    _modelArr = [DataModel mj_objectArrayWithKeyValuesArray:_dictArr];
    
    ZZMenuView *menuView = [[ZZMenuView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    menuView.delegate = self;
    menuView.dataSource = self;
    [self.view addSubview:menuView];
    
}

#pragma mark - ZZMenuViewDataSource
- (NSInteger)menuView:(ZZMenuView *)menuView numberOfRowsWithIndexPath:(ZZIndexPath *)indexPath{
    if (indexPath.row == ZZNotFound) {
        return _modelArr.count;
    }
    if (indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        return model0.itemCatagory.count;
    }
    if (indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank == ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        DataModel *model1 = model0.itemCatagory[indexPath.item];
        return model1.itemCatagory.count;
    }
    return 0;
}

- (NSString *)menuView:(ZZMenuView *)menuView titleOfRowWithIndexPath:(ZZIndexPath *)indexPath{
    if (indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        return model0.itemName;
    }
    if (indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank == ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        DataModel *model1 = model0.itemCatagory[indexPath.item];
        return model1.itemName;
    }
    if (indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank != ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        DataModel *model1 = model0.itemCatagory[indexPath.item];
        DataModel *model2 = model1.itemCatagory[indexPath.rank];
        return model2.itemName;
    }
    return @"";
}

#pragma mark - ZZMenuViewDelegate
- (void)menuView:(ZZMenuView *)menuView didSelectWithIndexPath:(ZZIndexPath *)indexPath{
    if (indexPath.row != ZZNotFound && indexPath.item == ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        [UIView animateWithDuration:0.3 animations:^{
            if (model0.itemCatagory.count == 0) {
                [UIView animateWithDuration:0.3 animations:^{
                    menuView.tableView_1.left = ScreenWidth;
                    menuView.tableView_2.left = ScreenWidth;
                } completion:^(BOOL finished) {
                    if (self.dataBlock) {
                        self.dataBlock(model0);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    menuView.tableView_1.left = ScreenWidth/2.0;
                    menuView.tableView_2.left = ScreenWidth;
                }];
            }
        }];
    }
    if (indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank == ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        DataModel *model1 = model0.itemCatagory[indexPath.item];
        if (model1.itemCatagory.count == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                menuView.tableView_1.left = ScreenWidth/2.0;
                menuView.tableView_2.left = ScreenWidth;
            } completion:^(BOOL finished) {
                if (self.dataBlock) {
                    self.dataBlock(model1);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                menuView.tableView_1.left = ScreenWidth/3.0;
                menuView.tableView_2.left = (ScreenWidth/3.0)*2;
            }];
        }
    }
    if (indexPath.row != ZZNotFound && indexPath.item != ZZNotFound && indexPath.rank != ZZNotFound) {
        DataModel *model0 = _modelArr[indexPath.row];
        DataModel *model1 = model0.itemCatagory[indexPath.item];
        DataModel *model2 = model1.itemCatagory[indexPath.rank];
        NSLog(@"--%@--%@--",model2.itemName,model2.itemID);
        if (self.dataBlock) {
            self.dataBlock(model2);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
