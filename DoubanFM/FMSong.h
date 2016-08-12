//
//  FMSong.h
//  DoubanFM
//
//  Created by appple on 16/8/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMModel.h"
@interface FMSong : FMModel

@property (nonatomic, copy) NSString *albumtitle; // 专辑名称

@property (nonatomic, copy) NSString *artist; // 艺术家

@property (nonatomic, copy) NSString *picture; // 专辑图片

@property (nonatomic, copy) NSString *url; // 播放url

@property (nonatomic, copy) NSString *title; // 歌曲名

@end
