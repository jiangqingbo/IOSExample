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
@property (nonatomic, strong) UIButton *getButton;
@property (nonatomic, strong) UIButton *postButton;
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
        //点击时高亮
        _backButton.showsTouchWhenHighlighted = YES;
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)addGetButtonView {
    if(_getButton == nil){
        _getButton = [[UIButton alloc]initWithFrame:CGRectMake(20, _backButton.frame.origin.y + _backButton.frame.size.height + 10, (mScreenWidth - 20 * 2) / 2 - 10, 40)];
        _getButton.backgroundColor = [UIColor redColor];
        _getButton.layer.cornerRadius = 4;
        _getButton.layer.borderWidth = 1.0;
        _getButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        //点击时高亮
        _getButton.showsTouchWhenHighlighted = YES;
        [_getButton setTitle:@"Get方式请求接口" forState:UIControlStateNormal];
        [_getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0f]];
        [_getButton addTarget:self action:@selector(loadGetRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getButton;
}

- (UIButton *)addPostButtonView {
    if(_postButton == nil){
        _postButton = [[UIButton alloc]initWithFrame:CGRectMake(mScreenWidth / 2 + 10, _backButton.frame.origin.y + _backButton.frame.size.height + 10, (mScreenWidth - 20 * 2) / 2 - 10, 40)];
        _postButton.backgroundColor = [UIColor redColor];
        _postButton.layer.cornerRadius = 4;
        _postButton.layer.borderWidth = 1.0;
        _postButton.layer.borderColor = [UIColorUtils colorWithHexString:@"#C4575B"].CGColor;
        _postButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        //点击时高亮
        _postButton.showsTouchWhenHighlighted = YES;
        [_postButton setTitle:@"POST方式请求接口" forState:UIControlStateNormal];
        [_postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_postButton addTarget:self action:@selector(loadPostRequest) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postButton;
}

- (UILabel *)addLabelResultView {
    if(_resultLabel == nil){
        _resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _getButton.frame.origin.y + _getButton.frame.size.height + 10, mScreenWidth - 10 * 2, mScreenHeight - (_getButton.frame.origin.y + _getButton.frame.size.height + 10))];
        _resultLabel.backgroundColor = [UIColor whiteColor];
        _resultLabel.textColor = [UIColor blackColor];
        _resultLabel.font = [UIFont systemFontOfSize: 16];
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

- (void)loadPostRequest {
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache"};
    
    NSURL *url = [NSURL URLWithString:@"http://www.justonetech.com:8090/androidKq/getProjects.do"];
    
//    NSString *param = @"data=%7B%22token%22%3A%20%22lWQoE0jzlvRrvj2KEcsqL9PxsoGYw6mznrQCB6ai%2Fm%2BjFDzkaUaeehu8hxZ6SYqLMjR12m8NQWEX%24%24%24%40%40%40LWtK2e5lzRNtE8vW4qBP3QwiXkTD1R4%3D%22%7D";
    
    NSDictionary *paramObj = @{@"token":@"lWQoE0jzlvRrvj2KEcsqL9PxsoGYw6mznrQCB6ai/m+jFDzkaUaeehu8hxZ6SYqLMjR12m8NQWEX$$$@@@LWtK2e5lzRNtE8vW4qBP3QwiXkTD1R4="};
    NSLog(@"paramObj = %@", paramObj);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramObj options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"jsonData = %@", jsonData);
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString = %@", jsonString);
    
//    NSString *encodedValue = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSLog(@"encodedValue = %@", encodedValue);
    
    //将参数做编码处理
    jsonString = [self encodeParamString:jsonString];
    
    NSString *param = [NSString stringWithFormat:@"data=%@", jsonString];
    NSLog(@"param = %@", param);
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"postData = %@", postData);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
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
                                                        
                                                        BOOL success = [[obj objectForKey:@"success"] intValue];
                                                        
                                                        if(success){
                                                            if([obj isKindOfClass:[NSDictionary class]]){
                                                                NSMutableDictionary *datas = [(NSMutableDictionary *)obj objectForKey:@"data"];
                                                                NSMutableString *mutableString = [[NSMutableString alloc]initWithCapacity:[datas count]];
                                                                for (id project in datas) {
                                                                    NSString *projectName = [(NSDictionary *)project objectForKey:@"projectName"];
                                                                    [mutableString appendString:projectName];
                                                                    [mutableString appendString:@"\n"];
                                                                }
                                                                // 通知主线程刷新，UI更新操作必须在主线程中执行,常嵌套在其他线程中，如下
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    //回调或者说是通知主线程刷新，
                                                                    [self updateLabelText:mutableString];
                                                                });
                                                            }
                                                        } else {
                                                            NSString *message = [obj objectForKey:@"message"];
                                                            NSLog(@"message = %@", message);
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                //回调或者说是通知主线程刷新，
                                                                [self updateLabelText:message];
                                                            });
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

- (NSString *)encodeParamString: (NSString *) paramString {
    NSInteger strLength = 0;
    NSMutableString *mutableUrlStr = [paramString mutableCopy];
    NSLog(@" mutableUrlStr : %@", mutableUrlStr );
    
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@"{" withString:@"%7B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@"}" withString:@"%7D" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@":" withString:@"%3A" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    strLength = [mutableUrlStr length];
    [mutableUrlStr replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strLength)];
    NSLog(@" mutableUrlStr : %@", mutableUrlStr );
    
    return mutableUrlStr;
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
    [self.view addSubview:self.addGetButtonView];
    [self.view addSubview:self.addPostButtonView];
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
