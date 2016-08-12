//
//  UIRecordImage.m
//  DoubanFM
//
//  Created by appple on 16/8/3.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "RecordUIImageView.h"
#import "UIImageView+WebCache.h"


@implementation UIImageView(UIRecordImage)

- (void)initRadius{
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    
    
}






- (void) loadImgUrl:(NSString*) imgURL{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imgURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // 下载进度block
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        
    }];    //[ sd_setImageWithURL:@"http://pic2.ooopic.com/11/11/41/37b1OOOPIC87.jpg" placeholderImage:[UIImage imageNamed:@"recordBG"]];

}


@end
