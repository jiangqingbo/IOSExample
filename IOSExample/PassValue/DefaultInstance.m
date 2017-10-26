//
//  DefaultInstance.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "DefaultInstance.h"

@implementation DefaultInstance

//通过类方法创建单例
+(instancetype)sharedInstance{
    
    static DefaultInstance *instance = nil;
    
    if (instance == nil) {
        instance = [[DefaultInstance alloc]init];
    }
    return instance;
}

@end
