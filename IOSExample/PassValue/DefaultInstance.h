//
//  DefaultInstance.h
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultInstance : NSObject

+(instancetype)sharedInstance;

@property (nonatomic,strong) NSString *str;

@end
