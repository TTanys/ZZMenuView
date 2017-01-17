//
//  ZZMenuViewController.h
//  ZZMenu_Demo
//
//  Created by zhajianjun on 2017/1/17.
//  Copyright © 2017年 TTanys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

typedef void (^DataBlock)(DataModel *model);

@interface ZZMenuViewController : UIViewController

@property (nonatomic, copy) DataBlock dataBlock;

@end
