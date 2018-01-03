//
//  SecondViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/10/26.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "SecondViewController.h"
#import "DefaultInstance.h"

@interface SecondViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation SecondViewController

- (UITextField *)textField{
    if(!_textField){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
        _textField.textColor = [UIColor blackColor];
        _textField.borderStyle = UITextBorderStyleLine;
        //属性传值--接受并显示
        _textField.text = self.str;
        //单例传值--接受并显示
        _textField.text = [DefaultInstance sharedInstance].str;
        //NSUserDefaults传值--从文件中读取并显示
        _textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults"];
    }
    return _textField;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 200, 40)];
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitle:@"跳回至页面1" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClick{
    //2、单例传值--回传值
    //    [DefaultInstance sharedInstance].str = self.textField.text;
    //3、NSUserDefaults传值--回传值
    //    [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"NSUserDefaultsBack"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //4、设置代理传值--反向传值
    //    [self.delegate passValue:self.textField.text];
    
    //5、block传值--反向传值
    //    self.block(self.textField.text);
    
    //6、通知传值--发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil userInfo:@{@"notifyKey":self.textField.text}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.btn];
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
