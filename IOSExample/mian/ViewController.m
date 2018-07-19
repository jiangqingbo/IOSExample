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
#import "GestureRecognizerViewController.h"

#define mScreenWidth [[UIScreen mainScreen] bounds].size.width
#define mScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

//进入学习6种传值的方法
@property (nonatomic, strong) UIButton *passValueButton;
//进入学习可变数组的常用用法
@property (nonatomic, strong) UIButton *enterArrayButton;
//进入学习网络框架请求GET，POST方式
@property (nonatomic, strong) UIButton *httpButton;
//进入学习图片拖动功能
@property (nonatomic, strong) UIButton *dragButton;

@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (UIButton *)addPassValueButtonView {
    if (_passValueButton == nil) {
        _passValueButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, mScreenWidth - 10 * 2, 40)];
        _passValueButton.backgroundColor = [UIColor redColor];
        _passValueButton.layer.cornerRadius = 5;
        _passValueButton.layer.borderWidth = 1.0;
        _passValueButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        //点击时高亮
        _passValueButton.showsTouchWhenHighlighted=YES;
        [_passValueButton setTitle:@"测试6种传值的方法" forState:UIControlStateNormal];
        [_passValueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_passValueButton addTarget:self action:@selector(passValueClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passValueButton;
}

- (UIButton *)addEnterArrayButtonView {
    if(_enterArrayButton == nil){
        NSInteger indexY = _passValueButton.frame.origin.y + _passValueButton.frame.size.height + 10;
        _enterArrayButton = [[UIButton alloc] initWithFrame:CGRectMake(10, indexY, mScreenWidth - 10 * 2, 40)];
        _enterArrayButton.backgroundColor = [UIColor redColor];
        _enterArrayButton.layer.cornerRadius = 5;
        _enterArrayButton.layer.borderWidth = 1.0;
        _enterArrayButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        //点击时高亮
        _enterArrayButton.showsTouchWhenHighlighted=YES;
        [_enterArrayButton setTitle:@"学习NSMutableString常用用法" forState:UIControlStateNormal];
        [_enterArrayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterArrayButton addTarget:self action:@selector(enterArrayClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterArrayButton;
}

- (UIButton *)addHttpButtonView {
    if(_httpButton == nil){
        NSInteger indexY = _enterArrayButton.frame.origin.y + _enterArrayButton.frame.size.height;
        _httpButton = [[UIButton alloc]initWithFrame:CGRectMake(10, indexY + 10, mScreenWidth - 10 * 2, 40)];
        _httpButton.backgroundColor = [UIColor redColor];
        _httpButton.layer.cornerRadius = 5;
        _httpButton.layer.borderWidth = 1.0;
        _httpButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        //点击时高亮
        _httpButton.showsTouchWhenHighlighted=YES;
        [_httpButton setTitle:@"学习网络请求常用用法" forState:UIControlStateNormal];
        [_httpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_httpButton addTarget:self action:@selector(httpClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _httpButton;
}

- (UIButton *)dragButton {
    if(!_dragButton){
        NSInteger indexY = _httpButton.frame.origin.y + _httpButton.frame.size.height;
        _dragButton = [[UIButton alloc]initWithFrame:CGRectMake(10, indexY + 10, mScreenWidth - 10 * 2, 40)];
        _dragButton.backgroundColor = [UIColor redColor];
        _dragButton.layer.cornerRadius = 5;
        _dragButton.layer.borderWidth = 1.0;
        _dragButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        //点击时高亮
        _dragButton.showsTouchWhenHighlighted=YES;
        [_dragButton setTitle:@"学习图片拖动功能" forState:UIControlStateNormal];
        [_dragButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dragButton addTarget:self action:@selector(dragListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dragButton;
}

- (void)passValueClickListener {
    FirstViewController *firstViewController = [[FirstViewController alloc]init];
    firstViewController.navigationItem.title = @"页面跳转及传值";
    [self.navigationController pushViewController:firstViewController animated:YES];
}

- (void)enterArrayClickListener {
    NSMutableStringViewController *nsmutableStringViewController = [[NSMutableStringViewController alloc]init];
    nsmutableStringViewController.navigationItem.title = @"字符串学习";
    [self.navigationController pushViewController:nsmutableStringViewController animated:YES];
}

- (void)httpClickListener {
    HttpViewController *httpViewController = [[HttpViewController alloc]init];
    httpViewController.navigationItem.title = @"学习网络请求";
    [self.navigationController pushViewController:httpViewController animated:YES];
}

- (void)dragListener {
    GestureRecognizerViewController *gestureRecognizerViewController = [[GestureRecognizerViewController alloc]init];
    gestureRecognizerViewController.navigationItem.title = @"图片拖动";
    [self.navigationController pushViewController:gestureRecognizerViewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.addPassValueButtonView];
    [self.view addSubview:self.addEnterArrayButtonView];
    [self.view addSubview:self.addHttpButtonView];
    [self.view addSubview:self.dragButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
