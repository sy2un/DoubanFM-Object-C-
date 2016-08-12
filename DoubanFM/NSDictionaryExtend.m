//
//  NSDictionaryExtend.m
//  DoubanFM
//
//  Created by appple on 16/8/11.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "NSDictionaryExtend.h"

@implementation NSDictionary(NSDictionaryExtend)

- (BOOL) containkey:(NSString*)key{
    if(![self objectForKey:key]){
        return NO;
    }
    
    id obj = [self objectForKey:key];    
    return ![obj isEqual:[NSNull null]];
}

@end
