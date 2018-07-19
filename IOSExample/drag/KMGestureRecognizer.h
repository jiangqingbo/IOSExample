//
//  KMGestureRecognizer.h
//  IOSExample
//
//  Created by jiangqingbo on 2018/6/6.
//  Copyright © 2018年 jiangqingbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionUnknown,
    DirectionLeft,
    DirectionRight
};

@interface KMGestureRecognizer : UIGestureRecognizer

@property (assign, nonatomic) NSUInteger tickleCount; //挠痒次数
@property (assign, nonatomic) CGPoint currentTickleStart; //当前挠痒开始坐标位置
@property (assign, nonatomic) Direction lastDirection; //最后一次挠痒方向

@end
