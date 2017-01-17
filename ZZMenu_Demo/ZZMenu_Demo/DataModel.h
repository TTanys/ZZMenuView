//
//  DataModel.h
//  WSDropMenuView
//
//  Created by zhajianjun on 2017/1/16.
//  Copyright © 2017年 Senro Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemID;
@property (nonatomic, strong) NSArray *itemCatagory;

@end
