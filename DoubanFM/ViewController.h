//
//  ViewController.h
//  DoubanFM
//
//  Created by Michael on 16/8/1.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpControl.h"
#import <AVFoundation/AVFoundation.h>
#import "FMSong.h"
#import "FMChannel.h"
#import "STKAutoRecoveringHTTPDataSource.h"
#import "STKAudioPlayer.h"
#import "NSDictionaryExtend.h"
#import "CircleProgress.h"
#import <Foundation/Foundation.h>


@interface ViewController : UIViewController<HttpDelegate,AVAudioPlayerDelegate>
{
    HttpControl* httpControl;
    
    __weak IBOutlet UILabel *labelSongName;
    __weak IBOutlet UIImageView *recordImage;
    __weak IBOutlet UILabel *labelSingerName;
    
    __weak IBOutlet UIButton *btnLike;
    __weak IBOutlet UIButton *btnPlayPause;
    __weak IBOutlet UIImageView *imgProgress;
    
    __weak IBOutlet CircleProgress *progress;
    
    STKAudioPlayer* audioPlayer;
    NSMutableArray *songArr;
    NSMutableArray *channelArr;
    float angle;
    
    int currentIndex;   //当前播放歌曲的索引
    
    NSTimer* timer;
    
    __weak IBOutlet UIImageView *bottomSlider;

}


@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
- (void) onRotation;

- (void) startAnimation;


- (void) playMusic:(FMSong*) song;

- (void) onNextPlay;

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;


- (void)changeRecordImage:(NSString*)imageUrl;

//获取频道列表信息
- (void)getChannelData:(NSDictionary*) channels;
//获取歌曲信息
- (void)getSongData:(NSArray*) songs;
//暂停转动唱片背景
- (void)pauseRecordRotation:(CALayer*) layer;
//继续转动唱片背景
- (void)resumeRecordRotation:(CALayer*) layer;

- (IBAction)clickChannelMenuAction:(id)sender;
#pragma 讨厌按钮点击事件
- (IBAction)clickDislikeAction:(id)sender;
#pragma 播放按钮点击事件
- (IBAction)clickPlayAction:(id)sender;
#pragma 喜欢按钮点击事件
- (IBAction)clickLikeAction:(id)sender;

- (void) updateProgress;

//获取到网络数据
- (void) didRecieveData:(NSDictionary*) jsonData;

@end

