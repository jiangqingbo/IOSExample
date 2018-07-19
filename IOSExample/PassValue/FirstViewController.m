//
//  FirstViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "DefaultInstance.h"

@interface FirstViewController ()<PassValueDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation FirstViewController

- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
        _label.backgroundColor = [UIColor blackColor];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:20];
    }
    return _label;
}

- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 200, 40)];
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitle:@"跳转至页面2" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 60, 30)];
        _backButton.backgroundColor = [UIColor redColor];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backClickListener) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

//button点击事件，跳转至页面2
- (void) btnClick{
    SecondViewController *secondViewController = [[SecondViewController alloc]init];
    secondViewController.str = @"1.属性传值";
    
    //2、单例传值--正向传值
    [DefaultInstance sharedInstance].str = @"单例传值";
    //3、NSUserDefaults传值--正向传值
    [[NSUserDefaults standardUserDefaults] setObject:@"NSUserDefaults传值" forKey:@"NSUserDefaults"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //4、代理传值--设置代理关系
    //    nextVC.delegate = self;
    
    //5、block传值--实现block--接收页面2的值
    //    nextVC.block = ^(NSString *str){
    //        self.label.text = str;
    //    };//block必须以“分号”结束
    
    //6、通知传值--添加监听观察者模式--等待页面2发出的通知消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyHandle:) name:@"notify" object:nil];
    
//    [self presentViewController:secondViewController animated:YES completion:nil];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

- (void)backClickListener{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//接收到通知之后的处理--参数1：通知
-(void)notifyHandle: (NSNotification*)notify{
    self.label.text = notify.userInfo[@"notifyKey"];
}

//代理传值--实现协议方法--接收页面2的值并显示
-(void)passValue:(NSString *)str{
    self.label.text = str;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //单例传值--接受页面2反向传值
//    self.label.text = [DefaultInstance sharedInstance].str;
    //NSUserDefaults传值--接受页面2反向传值
//    self.label.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaultsBack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.backButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
