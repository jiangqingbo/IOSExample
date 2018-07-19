//
//  GestureRecognizerViewController.h
//  IOSExample
//
//  Created by jiangqingbo on 2018/6/6.
//  Copyright © 2018年 jiangqingbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMGestureRecognizer.h"

@interface GestureRecognizerViewController : UIViewController

@property (strong, nonatomic) UIImageView *imgBg;
@property (strong, nonatomic) UIImageView *imgV;
@property (strong, nonatomic) UIImageView *imgV2;
@property (strong, nonatomic) KMGestureRecognizer *customGestureRecognizer;

@end
