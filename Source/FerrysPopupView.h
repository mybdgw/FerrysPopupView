//
//  FerrysPopupView.h
//  faceoff
//
//  Created by zhangxiaolong on 15/12/20.
//  Copyright (c) 2015年 faceoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FerrysPopupView : UIView
+ (void)showInSupperView:(UIView *)supperView contentView:(UIView *)contentView belowView:(UIView *)belowView;
+ (void)showInSupperView:(UIView *)supperView contentView:(UIView *)contentView belowView:(UIView *)belowView showDuration:(NSTimeInterval)duration dismissDuration:(NSTimeInterval)dismissDuration;
@end
