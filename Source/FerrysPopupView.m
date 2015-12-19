//
//  FerrysPopupView.m
//  faceoff
//
//  Created by zhangxiaolong on 15/12/20.
//  Copyright (c) 2015年 faceoff. All rights reserved.
//

#import "FerrysPopupView.h"

@interface FerrysPopupView ()
@property (nonatomic,strong) UIControl *overlayView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,assign) NSTimeInterval showDuration;
@property (nonatomic,assign) NSTimeInterval dismissDuration;
@property (nonatomic,assign) BOOL animating;
@end

@implementation FerrysPopupView

- (UIControl *)overlayView
{
    if (!_overlayView) {
        _overlayView = [[UIControl alloc]init];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0;
        [_overlayView addTarget:self action:@selector(overlayViewClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _overlayView;
}

+ (FerrysPopupView *)shareInstance
{
    static FerrysPopupView *instanceView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceView = [[FerrysPopupView alloc]init];
    });
    return instanceView;
}

+ (void)showInSupperView:(UIView *)supperView contentView:(UIView *)contentView belowView:(UIView *)belowView
{
    [self showInSupperView:supperView contentView:contentView belowView:belowView showDuration:0.5 dismissDuration:0.25];
}

+ (void)showInSupperView:(UIView *)supperView contentView:(UIView *)contentView belowView:(UIView *)belowView showDuration:(NSTimeInterval)duration dismissDuration:(NSTimeInterval)dismissDuration
{
    FerrysPopupView *singleView = [FerrysPopupView shareInstance];
    [singleView showInSupperView:supperView contentView:contentView belowView:belowView showDuration:duration dismissDuration:dismissDuration];
}

- (void)showInSupperView:(UIView *)supperView contentView:(UIView *)contentView belowView:(UIView *)belowView showDuration:(NSTimeInterval)showDuration dismissDuration:(NSTimeInterval)dismissDuration
{
    if (self.animating) {
        return;
    }
    
    if (self.contentView) {
        __weak typeof(self) weakSelf = self;
        [self dismissWithCompleteHandler:^{
            [weakSelf showInSupperView:supperView contentView:contentView belowView:belowView showDuration:showDuration dismissDuration:dismissDuration];
        }];
        return;
    }
    
    self.showDuration = showDuration;
    self.dismissDuration = dismissDuration;
    
    self.contentView = contentView;
    self.frame = supperView.bounds;
    if (belowView != nil && [supperView.subviews indexOfObject:belowView] != NSNotFound) {
        [supperView insertSubview:self belowSubview:belowView];
    }else{
        [supperView addSubview:self];
    }
    
    self.overlayView.frame = self.bounds;
    [self addSubview:self.overlayView];
    [self addSubview:contentView];
    
    
    CGRect beginFrame = contentView.frame;
    CGRect endFrame = beginFrame;
    endFrame.origin.y = self.frame.size.height;
    contentView.frame = endFrame;
    
    self.animating = YES;
    [UIView animateWithDuration:showDuration animations:^{
        self.overlayView.alpha = 0.3;
        contentView.frame = beginFrame;
    } completion:^(BOOL finished) {
        self.animating = NO;
    }];
}

- (void)dismissWithCompleteHandler:(void(^)())completeHandler
{
    CGRect beginFrame = self.contentView.frame;
    CGRect endFrame = beginFrame;
    endFrame.origin.y = self.frame.size.height;
    self.animating = YES;
    [UIView animateWithDuration:self.dismissDuration animations:^{
        self.overlayView.alpha = 0;
        self.contentView.frame = endFrame;
    } completion:^(BOOL finished) {
        self.animating = NO;
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
        self.contentView = nil;
        if (completeHandler) {
            completeHandler();
        }
    }];
}

- (void)overlayViewClick:(UIControl *)overlayView
{
    [self dismissWithCompleteHandler:NULL];
}

@end

