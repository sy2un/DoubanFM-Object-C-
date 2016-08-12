//
//  ViewController.m
//  DoubanFM
//
//  Created by Michael on 16/8/1.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+WebCache.h"
#import "RecordUIImageView.h"
#import "FMConfig.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize rightSwipeGestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
    httpControl = [HttpControl new];
        // Do any additional setup after loading the view, typically from a nib.

    
    audioPlayer = [[STKAudioPlayer alloc] init];
    currentIndex = 0;
    
    httpControl.httpDelegate = self;
    
    songArr = [NSMutableArray arrayWithCapacity:50];    //初始化歌曲列表
    
    channelArr = [NSMutableArray arrayWithCapacity:50];     //初始化频道列表
  
    [btnPlayPause setImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateNormal];
    [btnPlayPause setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateSelected];
    
    [btnLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    [btnLike setImage:[UIImage imageNamed:@"like2"] forState:UIControlStateNormal];
    
    NSString* url = @"https://douban.fm/j/mine/playlist?from=mainsite&channel=159&kbps=128&type=n";
    
    [httpControl onSearch:url];
    [recordImage setImage:[UIImage imageNamed:@"recordBG"]];

    
    [recordImage initRadius];
    //recordImage.frame = CGRectMake(recordImage.frame.origin.x, recordImage.frame.origin.y, recordImage.frame.size.width, recordImage.frame.size.height);
    //recordImage.layer.masksToBounds = YES;
    //recordImage.layer.cornerRadius = recordImage.frame.size.width / 2;
    
    [bottomSlider setUserInteractionEnabled:YES];
    rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onNextPlay)];
    [bottomSlider addGestureRecognizer:rightSwipeGestureRecognizer];
    
}
     

- (void) onNextPlay{
    NSLog(@"切换到下一首歌");
    
    currentIndex++;
    if(currentIndex > songArr.count - 1){
        currentIndex = 0;
    }
    FMSong* nextSong = [songArr objectAtIndex:currentIndex];
    [self playMusic:nextSong];
}


- (void) viewWillDisappear{
    
         
}

- (void) onRotation{
    
    angle = 0.0;
    [self startAnimation];
}

- (void) startAnimation{
    
    [UIView animateWithDuration:0.1 animations:^{
        recordImage.transform = CGAffineTransformMakeRotation(angle * (M_PI /180.0f));
    } completion:^(BOOL finished) {
        angle += 3;
        [self startAnimation];
    }];
    

}

- (void) pauseRecordRotation:(CALayer *)layer{
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() toLayer:nil];
    
    layer.speed = 0.0;
    
    layer.timeOffset = pauseTime;
}

- (void) resumeRecordRotation:(CALayer *)layer{
    
    CFTimeInterval pauseTime = [layer timeOffset];
    
    layer.speed = 1.0;
    
    layer.timeOffset = 0.0;
    
    layer.beginTime = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() toLayer:nil] - pauseTime;
    
    layer.beginTime = timeSincePause;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)clickDislikeAction:(id)sender {
    
    
}

- (IBAction)clickPlayAction:(id)sender {
    
    if(audioPlayer != nil){
        if(audioPlayer.state == STKAudioPlayerStatePaused){
            btnPlayPause.selected = !btnPlayPause.selected;
            [self resumeRecordRotation:recordImage.layer];
            [audioPlayer resume];
        }else{
            btnPlayPause.selected = !btnPlayPause.selected;
            [self pauseRecordRotation:recordImage.layer];
            [audioPlayer pause];
        }
    }
    
    
}

- (IBAction)clickChannelMenuAction:(id)sender {

    [httpControl onSearch:channelURL];

}

- (IBAction)clickLikeAction:(id)sender {
    btnLike.selected = !btnLike.selected;
}


- (void) didRecieveData:(NSDictionary*)jsonData{
    
    NSLog(@"开始解析数据");
    //NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"获取的数据：%@",jsonData);
    if([jsonData containkey:@"song"]){
        NSArray *list = [jsonData objectForKey:@"song"];
        [self getSongData:list];
        
        if(audioPlayer != nil){
            FMSong *fmSong = [songArr objectAtIndex:0];
            currentIndex = 0;
            [self playMusic:fmSong];
        }
        
        NSLog(@"歌曲列表大小    %d",songArr.count);
    }else if([jsonData containkey:@"data"]){
        NSLog(@"包含频道信息");
        NSDictionary* data = [jsonData objectForKey:@"data"];
        
        [self getChannelData:data];

    }
}


- (void) playMusic:(FMSong*) song{
    
    [audioPlayer stop];
    [self changeRecordImage:song.picture];
    [audioPlayer play:song.url];
    

}

- (void) changeRecordImage:(NSString *)imageUrl{
    [recordImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"recordBG"]];
    
    [self onRotation];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
         
    


}



- (void)getSongData:(NSArray *)songs{
    [songs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FMSong* fmSong = [FMSong new];
        [fmSong setValuesForKeysWithDictionary:obj];
        [songArr addObject:fmSong];
    }];
}

- (void)getChannelData:(NSDictionary *)channels{
    if([channels containkey:@"channels"]){
        
        NSArray* channelList = [channels objectForKey:@"channels"];
        
        [channelList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FMChannel *channel = [FMChannel new];
            [channel setValuesForKeysWithDictionary:obj];
            [channelArr addObject:channel];
        }];
    }
    
}


@end
