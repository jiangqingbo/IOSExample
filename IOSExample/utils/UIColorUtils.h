//
//  UIColorUtils.h
//  IOSExample
//
//  Created by jiangqingbo on 2017/12/28.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColorUtils : UIColor

+ (UIColor *) colorWithHexString: (NSString *) hexString;

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

@end
