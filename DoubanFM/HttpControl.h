//
//  HttpControl.h
//  DoubanFM
//
//  Created by Michael on 16/8/2.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HttpDelegate;

@interface HttpControl: NSObject
{
    NSString *string;
}
@property(nonatomic,weak)id<HttpDelegate>httpDelegate;

- (void) onGetRequest:(NSString*) url;

- (void) onPostRequest:(NSDictionary*) params;
@end




@protocol HttpDelegate <NSObject>

- (void) didRecieveData:(NSString*) jsonData;

@end

