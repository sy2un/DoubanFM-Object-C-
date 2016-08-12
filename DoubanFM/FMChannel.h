//
//  FMChannel.h
//  DoubanFM
//
//  Created by appple on 16/8/11.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMModel.h"
@interface FMChannel : FMModel

@property (nonatomic, copy) NSString *name; // 频道名称

@property (nonatomic, assign) NSInteger channelID;      //频道 ID

@end
