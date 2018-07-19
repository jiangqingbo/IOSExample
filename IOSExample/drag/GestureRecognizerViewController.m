//
//  GestureRecognizerViewController.m
//  IOSExample
//
//  Created by jiangqingbo on 2018/6/6.
//  Copyright © 2018年 jiangqingbo. All rights reserved.
//

#import "GestureRecognizerViewController.h"

@interface GestureRecognizerViewController ()

@property (nonatomic, assign) CGPoint sourcePoint;

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer;
- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer;
- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer;
- (void)handleCustomGestureRecognizer:(KMGestureRecognizer *)recognizer;

- (void)bindPan:(UIImageView *)imgVCustom;
- (void)bindPinch:(UIImageView *)imgVCustom;
- (void)bindRotation:(UIImageView *)imgVCustom;
- (void)bindTap:(UIImageView *)imgVCustom;
- (void)bindLongPress:(UIImageView *)imgVCustom;
- (void)bindSwipe;
- (void)bingCustomGestureRecognizer;
- (void)layoutUI;

@end

@implementation GestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 处理手势操作
/**
 *  处理拖动手势
 *
 *  @param recognizer 拖动手势识别器对象实例
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    //视图前置操作
//    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    
    CGPoint p=[recognizer locationInView:recognizer.view.superview];
    NSLog(@"1.%g  %g",p.x,p.y);
    
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    BOOL isImgbg = [recognizer.view isKindOfClass:[_imgBg class]];
    NSLog(@"isImgbg = %d", isImgbg);
    
    if (recognizer.state == UIGestureRecognizerStateEnded && !isImgbg) {
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        
        //基于速度和速度因素计算一个终点
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor), center.y + (velocity.y * slideFactor));
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius), self.view.bounds.size.width - cornerRadius);
        finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius), self.view.bounds.size.height - cornerRadius);
        
        //使用 UIView 动画使 view 滑行到终点
        [UIView animateWithDuration:slideFactor*2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             recognizer.view.center = finalPoint;
                         }
                         completion:nil];
    }
}

/**
 *  处理捏合手势
 *
 *  @param recognizer 捏合手势识别器对象实例
 */
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    CGFloat scale = recognizer.scale;
    //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale);
    recognizer.scale = 1.0;
}

/**
 *  处理旋转手势
 *
 *  @param recognizer 旋转手势识别器对象实例
 */
- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0.0;
}

/**
 *  处理点按手势
 *
 *  @param recognizer 点按手势识别器对象实例
 */
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    UIView *view = recognizer.view;
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    view.transform = CGAffineTransformMakeRotation(0.0);
    view.alpha = 1.0;
}

/**
 *  处理长按手势
 *
 *  @param recognizer 点按手势识别器对象实例
 */
- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    //长按的时候，设置不透明度为0.7
    recognizer.view.alpha = 0.7;
}

/**
 *  处理轻扫手势
 *
 *  @param recognizer 轻扫手势识别器对象实例
 */
- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    //代码块方式封装操作方法
    PWeakSelf(self);
    void (^positionOperation)() = ^() {
        CGPoint newPoint = recognizer.view.center;
        newPoint.y -= 20.0;
        weakself.imgV.center = newPoint;
        
        newPoint.y += 40.0;
        weakself.imgV2.center = newPoint;
    };
    
    //根据轻扫方向，进行不同控制
    switch (recognizer.direction) {
            case UISwipeGestureRecognizerDirectionRight: {
                positionOperation();
                break;
            }
            case UISwipeGestureRecognizerDirectionLeft: {
                positionOperation();
                break;
            }
            case UISwipeGestureRecognizerDirectionUp: {
                break;
            }
            case UISwipeGestureRecognizerDirectionDown: {
                break;
            }
    }
}

/**
 *  处理自定义手势
 *
 *  @param recognizer 自定义手势识别器对象实例
 */
- (void)handleCustomGestureRecognizer:(KMGestureRecognizer *)recognizer {
    //代码块方式封装操作方法
    PWeakSelf(self);
    void (^positionOperation)() = ^() {
        CGPoint newPoint = recognizer.view.center;
        newPoint.x -= 20.0;
        weakself.imgV.center = newPoint;
        
        newPoint.x += 40.0;
        weakself.imgV2.center = newPoint;
    };
    
    positionOperation();
}


#pragma mark - 绑定手势操作
/**
 *  绑定拖动手势
 *
 *  @param imgVCustom 绑定到图片视图对象实例
 */
- (void)bindPan:(UIImageView *)imgVCustom {
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [imgVCustom addGestureRecognizer:recognizer];
}

/**
 *  绑定捏合手势
 *
 *  @param imgVCustom 绑定到图片视图对象实例
 */
- (void)bindPinch:(UIImageView *)imgVCustom {
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handlePinch:)];
    [imgVCustom addGestureRecognizer:recognizer];
    //[recognizer requireGestureRecognizerToFail:imgVCustom.gestureRecognizers.firstObject];
}

/**
 *  绑定旋转手势
 *
 *  @param imgVCustom 绑定到图片视图对象实例
 */
- (void)bindRotation:(UIImageView *)imgVCustom {
    UIRotationGestureRecognizer *recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleRotation:)];
    [imgVCustom addGestureRecognizer:recognizer];
}

/**
 *  绑定点按手势
 *
 *  @param imgVCustom 绑定到图片视图对象实例
 */
- (void)bindTap:(UIImageView *)imgVCustom {
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap:)];
    //使用一根手指双击时，才触发点按手势识别器
    recognizer.numberOfTapsRequired = 2;
    recognizer.numberOfTouchesRequired = 1;
    [imgVCustom addGestureRecognizer:recognizer];
}

/**
 *  绑定长按手势
 *
 *  @param imgVCustom 绑定到图片视图对象实例
 */
- (void)bindLongPress:(UIImageView *)imgVCustom {
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    recognizer.minimumPressDuration = 0.5; //设置最小长按时间；默认为0.5秒
    [imgVCustom addGestureRecognizer:recognizer];
}

/**
 *  绑定轻扫手势；支持四个方向的轻扫，但是不同的方向要分别定义轻扫手势
 */
- (void)bindSwipe {
    //向右轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
    [self.view addGestureRecognizer:recognizer];
    [recognizer requireGestureRecognizerToFail:_customGestureRecognizer]; //设置以自定义挠痒手势优先识别
    
    //向左轻扫手势
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:recognizer];
    [recognizer requireGestureRecognizerToFail:_customGestureRecognizer]; //设置以自定义挠痒手势优先识别
}

/**
 *  绑定自定义挠痒手势；判断是否有三次不同方向的动作，如果有则手势结束，将执行回调方法
 */
- (void)bingCustomGestureRecognizer {
    //当 recognizer.state 为 UIGestureRecognizerStateEnded 时，才执行回调方法 handleCustomGestureRecognizer:
    
    //_customGestureRecognizer = [KMGestureRecognizer new];
    _customGestureRecognizer = [[KMGestureRecognizer alloc] initWithTarget:self action:@selector(handleCustomGestureRecognizer:)];
    [self.view addGestureRecognizer:_customGestureRecognizer];
}

- (void)handlePanGuestre:(UIGestureRecognizer *)recognizer {
    CGPoint p=[recognizer locationInView:recognizer.view.superview];
    NSLog(@"1.%g  %g",p.x,p.y);
    if (_sourcePoint.x==0 && _sourcePoint.y==0) {
        _sourcePoint=p;
    }else{
        CGRect r=_imgBg.frame;
        NSLog(@"21.%g  %g",r.origin.x, r.origin.y);
        _imgBg.frame=CGRectMake(r.origin.x+(p.x-_sourcePoint.x), r.origin.y+(p.y-_sourcePoint.y), r.size.width, r.size.height);
        NSLog(@"2.%g  %g",_sourcePoint.x,_sourcePoint.y);
        _sourcePoint=p;
        NSLog(@"3.%g  %g",_sourcePoint.x,_sourcePoint.y);
    }
}

- (void)layoutUI {
    //图片视图 _imgV
    UIImage *img = [UIImage imageNamed:@"ic_bg"];
    CGFloat cornerRadius = img.size.width;
    _imgBg = [[UIImageView alloc] initWithImage:img];
    _imgBg.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    _imgBg.userInteractionEnabled = YES;
    [self.view addSubview:_imgBg];
    
    //图片视图 _imgV
    img = [UIImage imageNamed:@"icon_start"];
    cornerRadius = img.size.width;
    _imgV = [[UIImageView alloc] initWithImage:img];
    _imgV.frame = CGRectMake(20.0, 20.0, img.size.width, img.size.height);
    _imgV.userInteractionEnabled = YES;
//    _imgV.layer.masksToBounds = YES;
//    _imgV.layer.cornerRadius = cornerRadius;
//    _imgV.layer.borderWidth = 2.0;
//    _imgV.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_imgV];
    
    //图片视图 _imgV2
    img = [UIImage imageNamed:@"icon_end"];
    cornerRadius = img.size.width;
    _imgV2 = [[UIImageView alloc] initWithImage:img];
    _imgV2.frame = CGRectMake(20.0, 40.0 + _imgV.frame.size.height, img.size.width, img.size.height);
    _imgV2.userInteractionEnabled = YES;
//    _imgV2.layer.masksToBounds = YES;
//    _imgV2.layer.cornerRadius = cornerRadius;
//    _imgV2.layer.borderWidth = 2.0;
//    _imgV2.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:_imgV2];
    
    //拖动
//    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGuestre:)];
//    [_imgBg addGestureRecognizer:pan];
    
    [self bindPan:_imgBg];
    
    [self bindPan:_imgV];
    [self bindPinch:_imgV];
    [self bindRotation:_imgV];
    [self bindTap:_imgV];
    [self bindLongPress:_imgV];
    
    [self bindPan:_imgV2];
    [self bindPinch:_imgV2];
    [self bindRotation:_imgV2];
    [self bindTap:_imgV2];
    [self bindLongPress:_imgV2];
    
    //为了处理手势识别优先级的问题，这里需先绑定自定义挠痒手势
    [self bingCustomGestureRecognizer];
    [self bindSwipe];
}

@end
