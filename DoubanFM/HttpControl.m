//
//  HttpControl.m
//  DoubanFM
//
//  Created by Michael on 16/8/2.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "HttpControl.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "NSDictionaryExtend.h"

@implementation HttpControl

- (void) onGetRequest:(NSString *)url{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //这里可以获取到目前的数据请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功，解析数据
        //NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //[self.httpDelegate didRecieveData:responseObject];
        //string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary* resObj = (NSDictionary*) responseObject;
        //NSLog(@"str = %@",resObj);
        [self.httpDelegate didRecieveData:resObj];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"网络请求失败");
    }];
    
    
    
}


- (void) onPostRequest:(NSDictionary *)params{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:@"http://www.douban.com/j/app/login" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //这里可以获取到目前的数据请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"登录结果:%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"登录失败");
    }];
    
}

@end
