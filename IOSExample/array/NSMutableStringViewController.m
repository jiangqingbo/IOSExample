//
//  NSMutableStringViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/11/2.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "NSMutableStringViewController.h"

@interface NSMutableStringViewController ()

@property (nonatomic, strong) UILabel *labelResult;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation NSMutableStringViewController

- (UILabel *)labelResult{
    if (_labelResult == nil) {
        _labelResult = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 350, 300)];
        _labelResult.backgroundColor = [UIColor whiteColor];
        _labelResult.textColor = [UIColor blackColor];
        _labelResult.font = [UIFont systemFontOfSize:20];
        _labelResult.numberOfLines = 0;
        _labelResult.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _labelResult;
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

- (void)backClickListener{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.labelResult];
    [self.view addSubview:self.backButton];
    
    NSMutableString *mutableString = [[NSMutableString alloc]initWithCapacity:10];
    [mutableString setString:@"NSMutableString"];
    //1.追加字符串
    [mutableString appendString:@" append String"];
    //2.替换字符串
    NSRange range = [mutableString rangeOfString:@"append"];
    [mutableString replaceCharactersInRange:range withString:@"replace"];
    //3.插入字符串
    [mutableString insertString:@" insert" atIndex:mutableString.length];
    //4.删除字符串
    NSRange delStr = [mutableString rangeOfString:@"insert"];
    [mutableString deleteCharactersInRange:delStr];
    
    [mutableString insertString:@" delete String" atIndex:mutableString.length];
    
    //OC数组可以存储不同类型的对象，OC数组只能存储对象
    NSArray *array1 = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    int count = (int)array1.count;
    NSString *string = [NSString stringWithFormat:@" %d",count];
    [mutableString appendString:string];
    
    //取出数组中下标为3的值
    NSString *str = [array1 objectAtIndex:3];
    [mutableString appendString:str];
    //数组的遍历（1.基本的for循环通过下标逐一取出查看；2.for in 快速枚举；3.枚举器（迭代器））
    for (int i = 0; i < count; i++) {
        NSString *s = [array1 objectAtIndex:i];
        [mutableString appendString:s];
    }
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:array1];
    for (NSString *s in array1) {
        NSLog(@"1.s = %@", s);
        if([s isEqualToString:@"2"]){
            [tempArr removeObject:s];
        }
    }
    
    for (NSString *s in tempArr) {
        NSLog(@"2.s = %@", s);
    }

    //
   
    [self.labelResult setText:mutableString];
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
