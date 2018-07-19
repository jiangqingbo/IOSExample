//
//  ExampleNavigationController.m
//  IOSExample
//
//  Created by jiangqingbo on 2018/6/6.
//  Copyright © 2018年 jiangqingbo. All rights reserved.
//

#import "ExampleNavigationController.h"

@interface ExampleNavigationController ()

@end

@implementation ExampleNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[UIColor colorWithRed:25/255.0 green:118/255.0 blue:210/255.0 alpha:1]
    [self.navigationBar setBarTintColor:[UIColorUtils colorWithHexString:COLOR_PRIMARY]];
    //一个布尔值,指示是否导航栏是半透明的(是的)(不)
    self.navigationBar.translucent = NO;
    //一个布尔值表示是否延长布局包括不透明的bar
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize {
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme {
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    [textAttrs setDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //    UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    //   textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //为了扩大点击领域
        UIImage *backImg = [UIImage imageNamed:@"back_arrow_left"];
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, backImg.size.width, backImg.size.height)];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [backBtn setImage:backImg forState:UIControlStateNormal];
        UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
        backBtnView.bounds = CGRectOffset(backBtnView.bounds, 0, 0);
        [backBtnView addSubview:backBtn];
        UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
        viewController.navigationItem.leftBarButtonItem = backBarBtn;
        //        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_back" highImageName:@"" target:self action:@selector(back)];
    }
    [super pushViewController: viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
