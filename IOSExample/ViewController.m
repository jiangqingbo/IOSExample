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

@interface ViewController ()

//进入学习6种传值的方法
@property (nonatomic, strong) UIButton *passValueButton;
//进入学习可变数组的常用用法
@property (nonatomic, strong) UIButton *enterArrayButton;

@end

@implementation ViewController

- (UIButton *) passValueButton {
    if (_passValueButton == nil) {
        _passValueButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 350, 40)];
        _passValueButton.backgroundColor = [UIColor redColor];
        [_passValueButton setTitle:@"测试6种传值的方法" forState:UIControlStateNormal];
        [_passValueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_passValueButton addTarget:self action:@selector(passValueClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passValueButton;
}

-(UIButton *) enterArrayButton{
    if(_enterArrayButton == nil){
        _enterArrayButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 350, 40)];
        _enterArrayButton.backgroundColor = [UIColor redColor];
        [_enterArrayButton setTitle:@"学习NSMutableString常用用法" forState:UIControlStateNormal];
        [_enterArrayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterArrayButton addTarget:self action:@selector(enterArrayClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterArrayButton;
}

- (void)passValueClickListener{
    FirstViewController *firstViewController = [[FirstViewController alloc]init];
    [self presentViewController:firstViewController animated:YES completion:nil];
}

- (void)enterArrayClickListener{
    NSMutableStringViewController *nsmutableStringViewController = [[NSMutableStringViewController alloc]init];
    [self presentViewController:nsmutableStringViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.passValueButton];
    [self.view addSubview:self.enterArrayButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
