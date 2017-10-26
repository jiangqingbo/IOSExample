//
//  ViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *passValueButton;

@end

@implementation ViewController

- (UIButton *) passValueButton {
    if (_passValueButton == nil) {
        _passValueButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 200, 40)];
        _passValueButton.backgroundColor = [UIColor redColor];
        [_passValueButton setTitle:@"测试6种传值的方法" forState:UIControlStateNormal];
        [_passValueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_passValueButton addTarget:self action:@selector(passValueClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passValueButton;
}

- (void)passValueClickListener{
    FirstViewController *firstViewController = [[FirstViewController alloc]init];
    
    
    [self presentViewController:firstViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.passValueButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
