//
//  HttpViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2017/12/28.
//  Copyright © 2017年 jiangqingbo. All rights reserved.
//

#import "HttpViewController.h"
#import "UIColorUtils.h"

#define mScreenWidth [[UIScreen mainScreen] bounds].size.width
#define mScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface HttpViewController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation HttpViewController

- (UIButton *)addBackButtonView {
    if(_backButton == nil){
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 60, 30)];
        _backButton.backgroundColor = [UIColor redColor];
        _backButton.layer.cornerRadius = 4;
        _backButton.layer.borderWidth = 1.0;
        _backButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)addCallButtonView {
    if(_callButton == nil){
        _callButton = [[UIButton alloc]initWithFrame:CGRectMake(50, _backButton.frame.origin.y + _backButton.frame.size.height + 10, mScreenWidth - 50 * 2, 40)];
        _callButton.backgroundColor = [UIColor redColor];
        _callButton.layer.cornerRadius = 4;
        _callButton.layer.borderWidth = 1.0;
        _callButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        [_callButton setTitle:@"Get方式请求接口" forState:UIControlStateNormal];
        [_callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(loadGetRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callButton;
}

- (UILabel *)addLabelResultView {
    if(_resultLabel == nil){
        _resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _callButton.frame.origin.y + _callButton.frame.size.height + 10, mScreenWidth - 10 * 2, mScreenHeight - (_callButton.frame.origin.y + _callButton.frame.size.height + 10))];
        _resultLabel.backgroundColor = [UIColor whiteColor];
        _resultLabel.textColor = [UIColor blackColor];
        _resultLabel.font = [UIFont systemFontOfSize:20];
        _resultLabel.numberOfLines = 0;
        _resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _resultLabel;
}

- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadGetRequest {
    NSDictionary *headers = @{ @"authorization": @"Basic Ym9ibzoxMTExMTE=",
                               @"cache-control": @"no-cache"};
    NSString *param = @"%7B%22requestNo%22:%22123456789099%22,%22param%22:%7B%22groupId%22:20566%7D%7D";
    NSString *urlString = [NSString stringWithFormat:@"http://www.justonetech.com:9901/api/jsonws/eyanghu-portlet.v1/get-app-banners/req-param/%@", param];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        NSLog(@"result = %@", obj);
                                                        
                                                        if([obj isKindOfClass: [NSDictionary class]]){
                                                            id dataObj = [(NSDictionary *)obj objectForKey:@"data"];
                                                            NSMutableDictionary *photos = [(NSMutableDictionary *)dataObj objectForKey:@"photos"];
                                                            NSLog(@"----------->%@", [NSString stringWithFormat:@"%lu", [photos count]]);
                                                            NSMutableString *mutableString = [[NSMutableString alloc]initWithCapacity:[photos count]];
                                                            for (id photoObj in photos) {
                                                                NSString *imgSrc = [(NSDictionary *)photoObj objectForKey:@"imgSrc"];
                                                                [mutableString appendString:imgSrc];
                                                                [mutableString appendString:@"\n"];
                                                            }
                                                            // 通知主线程刷新，UI更新操作必须在主线程中执行,常嵌套在其他线程中，如下
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                //回调或者说是通知主线程刷新，
                                                                [self updateLabelText:mutableString];
                                                                [self addImageView:photos];
                                                            });
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

- (void)updateLabelText: (NSString *)text {
    [_resultLabel setText:text];
}

- (void)addImageView: (NSMutableDictionary *)photos {
    NSInteger num = 0;
    for (id photoObj in photos) {
        NSString *imgSrc = [(NSDictionary *)photoObj objectForKey:@"imgSrc"];
        //创建UIImageView对象
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _resultLabel.frame.origin.y + num * 100 + 10, mScreenWidth, 100)];
        //指定图片
        [imageView setImage:[UIImage imageNamed:@"1"]];
        //指定背景
        imageView.backgroundColor = [UIColorUtils colorWithHexString:@"#50999999"];
        
        //设置UIImageView的填充属性
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        //添加到view
        [self.view addSubview:imageView];
        num += 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.addBackButtonView];
    [self.view addSubview:self.addCallButtonView];
    [self.view addSubview:self.addLabelResultView];
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
