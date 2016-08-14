//
//  CircleProgress.m
//  DoubanFM
//
//  Created by Michael on 16/8/13.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "CircleProgress.h"
@interface CircleProgress ()

@property (nonatomic, assign) CGFloat progressValue;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end


@implementation CircleProgress

- (void) initProgress:(CGPoint)cirlePoint circleRadius:(CGFloat)radiusValue fillinColor:(UIColor *)fillColorValue borderColor:(UIColor *)borderColorValue{
    center = cirlePoint;     //这是圆形进度条位置
    radius = radiusValue;      //设置半径
    startVal = - M_PI_2;      //设置起点位置
    endVal =  startVal;    //设置进度条终点位置  ,初始化跟起点位置一样
    fillinColor = fillColorValue;
    borderColor = borderColorValue;
}

//重写 UIView的渲染方法，在每次调用 setNeedsDisplay 时会重新绘制
- (void) drawRect:(CGRect)rect{
    [self drawProgress];
}

- (void) setProgress:(CGFloat)currProgress{
    
    _progressValue = currProgress;
    _progressLayer.opacity = 0;
    [self setNeedsDisplay];     //调用渲染方法
}

- (void) drawProgress{
    
    //CGPoint center = CGPointMake(150, 100);
   // CGFloat radius = 120;
    //CGFloat startA = - M_PI_2;  //设置进度条起点位置
    endVal = -M_PI_2 + M_PI * 2 * _progressValue;  //设置进度条终点位置
    
    _progressLayer = [CAShapeLayer layer];          //创建一个 ShapeLayer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [fillinColor CGColor];       //设置圆形区域内部颜色
    _progressLayer.strokeColor = [borderColor CGColor];     //设置环形边框颜色，即进度条颜色
    _progressLayer.opacity = 1;         //背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;           //设置进度条顶端的形状
    _progressLayer.lineWidth = 10;          //进度条粗细
    
    //根据参数构建圆形顺时针形状
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startVal endAngle:endVal clockwise:YES];
    
    _progressLayer.path = [path CGPath];//把圆形曲线的 Path 传递给 layer供 layer 渲染，与 CoreGraph 逻辑相同
    
    [self.layer addSublayer:_progressLayer];
}


















@end
