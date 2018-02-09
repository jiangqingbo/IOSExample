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

//不同的方式创建单例
+(DefaultInstance *)sharedDefault;

@property (nonatomic,strong) NSString *str;

@end
