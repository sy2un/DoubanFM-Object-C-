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

- (void)viewDidLoad {
    [super viewDidLoad];
    httpControl = [HttpControl new];
        // Do any additional setup after loading the view, typically from a nib.

    
    audioPlayer = [[STKAudioPlayer alloc] init];
    
    
    httpControl.httpDelegate = self;
    
    songArr = [NSMutableArray arrayWithCapacity:50];    //初始化歌曲列表
    
    channelArr = [NSMutableArray arrayWithCapacity:50];     //初始化频道列表
  
    [btnPlayPause setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [btnPlayPause setImage:[UIImage imageNamed:@"btn_pause"] forState:UIControlStateSelected];
    
    [btnLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    [btnLike setImage:[UIImage imageNamed:@"like2"] forState:UIControlStateNormal];
    
    NSString* url = @"https://douban.fm/j/mine/playlist?from=mainsite&channel=159&kbps=128&type=n";
    
    [httpControl onSearch:url];
    [recordImage setImage:[UIImage imageNamed:@"recordBG"]];

    
    [recordImage initRadius];
    //recordImage.frame = CGRectMake(recordImage.frame.origin.x, recordImage.frame.origin.y, recordImage.frame.size.width, recordImage.frame.size.height);
    //recordImage.layer.masksToBounds = YES;
    //recordImage.layer.cornerRadius = recordImage.frame.size.width / 2;
    
   
   
    
}
     
    
- (void) viewWillDisappear{
    
         
}

- (void) onRotation{
    
    angle = 0.0;
    [self startAnimation];
}

- (void) startAnimation{
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.1];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    recordImage.transform = CGAffineTransformMakeRotation(angle * (M_PI /180.0f));
    
    [UIView commitAnimations];
}

- (void) endAnimation{
    angle += 3;
    
    [self startAnimation];
    
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
            [audioPlayer resume];
        }else{
            btnPlayPause.selected = !btnPlayPause.selected;
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
            [self changeRecordImage:fmSong.picture];
            [audioPlayer play:fmSong.url];
        }
        
        NSLog(@"歌曲列表大小    %d",songArr.count);
    }else if([jsonData containkey:@"data"]){
        NSLog(@"包含频道信息");
        NSDictionary* data = [jsonData objectForKey:@"data"];
        
        [self getChannelData:data];

    }
}


- (void) playMusic:(NSDictionary*) song{
    
    labelSingerName.text = [song objectForKey:@"artist"];
    
    labelSongName.text = [song objectForKey:@"title"];
    
   
    NSURL* musicUrl = [NSURL URLWithString:[song objectForKey:@"title"]];
    

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
