//
//  ViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "NSMutableStringViewController.h"
#import "HttpViewController.h"
#import "UIColorUtils.h"

#define mScreenWidth [[UIScreen mainScreen] bounds].size.width
#define mScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

//进入学习6种传值的方法
@property (nonatomic, strong) UIButton *passValueButton;
//进入学习可变数组的常用用法
@property (nonatomic, strong) UIButton *enterArrayButton;
//进入学习网络框架请求GET，POST方式
@property (nonatomic, strong) UIButton *httpButton;

@end

@implementation ViewController

- (UIButton *)addPassValueButtonView {
    if (_passValueButton == nil) {
        _passValueButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 350, 40)];
        _passValueButton.backgroundColor = [UIColor redColor];
        [_passValueButton setTitle:@"测试6种传值的方法" forState:UIControlStateNormal];
        [_passValueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_passValueButton addTarget:self action:@selector(passValueClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passValueButton;
}

- (UIButton *)addEnterArrayButtonView {
    if(_enterArrayButton == nil){
        _enterArrayButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 350, 40)];
        _enterArrayButton.backgroundColor = [UIColor redColor];
        [_enterArrayButton setTitle:@"学习NSMutableString常用用法" forState:UIControlStateNormal];
        [_enterArrayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterArrayButton addTarget:self action:@selector(enterArrayClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterArrayButton;
}

- (UIButton *)addHttpButtonView {
    if(_httpButton == nil){
    _httpButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 150, mScreenWidth - 10 * 2, 40)];
        _httpButton.backgroundColor = [UIColor redColor];
        _httpButton.layer.cornerRadius = 5;
        _httpButton.layer.borderWidth = 1.0;
        _httpButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        [_httpButton setTitle:@"学习网络请求常用用法" forState:UIControlStateNormal];
        [_httpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_httpButton addTarget:self action:@selector(httpClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _httpButton;
}

- (void)passValueClickListener {
    FirstViewController *firstViewController = [[FirstViewController alloc]init];
    [self presentViewController:firstViewController animated:YES completion:nil];
}

- (void)enterArrayClickListener {
    NSMutableStringViewController *nsmutableStringViewController = [[NSMutableStringViewController alloc]init];
    [self presentViewController:nsmutableStringViewController animated:YES completion:nil];
}

- (void)httpClickListener {
    HttpViewController *httpViewController = [[HttpViewController alloc]init];
    [self presentViewController:httpViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.addPassValueButtonView];
    [self.view addSubview:self.addEnterArrayButtonView];
    [self.view addSubview:self.addHttpButtonView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
