//
//  SecondViewController.h
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassValueDelegate <NSObject>

-(void) passValue: (NSString *)str;

@end

@interface SecondViewController : UIViewController

@property (nonatomic, strong) NSString *str;

@property (weak)id<PassValueDelegate>delegate;

@property (copy) void (^block)(NSString *);

@end
