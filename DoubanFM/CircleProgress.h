//
//  CircleProgress.h
//  DoubanFM
//
//  Created by Michael on 16/8/13.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircleProgress : UIView
{
    CGPoint center;
    CGFloat radius;
    CGFloat startVal;
    CGFloat endVal;
    UIColor* fillinColor;
    UIColor* borderColor;
    
}

- (void) setProgress:(CGFloat) currProgress;

- (void) initProgress:(CGPoint) cirlePoint circleRadius:(CGFloat)radiusValue fillinColor:(UIColor*)fillColorValue borderColor:(UIColor*)borderColorValue;


- (void) drawProgress;













@end
