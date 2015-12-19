//
//  ViewController.m
//  FerrysPopupView
//
//  Created by zhangxiaolong on 15/12/20.
//  Copyright (c) 2015年 lianjia. All rights reserved.
//

#import "ViewController.h"
#import "FerrysPopupView.h"

@interface ViewController ()
@property (nonatomic,strong) UIView *bottomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 80)];
    self.bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.bottomView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
    contentView.backgroundColor = [self randomColor];
    NSTimeInterval showDuration = arc4random() % 100 * 0.015;
    NSTimeInterval dismissDuration = arc4random() % 50 * 0.01;
    [FerrysPopupView showInSupperView:self.view contentView:contentView belowView:self.bottomView showDuration:showDuration dismissDuration:dismissDuration];
    
//    [FerrysPopupView showInSupperView:self.view.window contentView:contentView belowView:self.bottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)randomColor{
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];//alpha为1.0,颜色完全不透明
}

@end
