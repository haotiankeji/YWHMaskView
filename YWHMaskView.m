//
//  YWHMaskView.m
//  uiwindowTest
//
//  Created by 昊天 on 2017/7/20.
//  Copyright © 2017年 昊天. All rights reserved.
//

#import "YWHMaskView.h"
@interface YWHMaskView ()

@property (nonatomic, strong) UIWindow *showWindow;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIView *showView;

@property (nonatomic, assign) CGRect showFrame;

@property (nonatomic, assign) ENUM_SHOW_TYPE showType;

@property (nonatomic, assign) ENUM_DISMISS_TYPE dismissType;

@end

@implementation YWHMaskView

static YWHMaskView *instance;


+ (instancetype)sharedYWHMaskView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YWHMaskView alloc] init];
    });

    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });

    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}

+ (void)ShowTargetView:(UIView *)showView
           TargetFrame:(CGRect)frame
        BackColorAlpha:(CGFloat)alpha
              ShowType:(ENUM_SHOW_TYPE)showType
           DismissType:(ENUM_DISMISS_TYPE)dismissType
{
    [[self alloc] ShowTargetView:showView TargetFrame:frame BackColorAlpha:alpha ShowType:showType DismissType:dismissType];
}

- (void)ShowTargetView:(UIView *)showView
           TargetFrame:(CGRect)frame
        BackColorAlpha:(CGFloat)alpha
              ShowType:(ENUM_SHOW_TYPE)showType
           DismissType:(ENUM_DISMISS_TYPE)dismissType
{
    self.showView = showView;
    self.showView.frame = frame;
    self.showView.hidden = YES;
    self.showFrame = frame;
    self.showType = showType;
    
    self.dismissType = dismissType;
    
    self.backGroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:alpha];
    
    [self.showWindow addSubview:self.backGroundView];
    [self.showWindow addSubview:self.showView];
    [self show];
}

+ (void)Hide
{
    [[self alloc] hide];
}
#pragma mark -- response

- (void)show
{
    switch (_showType) {
        case 0:
        {
            [UIView animateWithDuration:AnimationInterval animations:^{
                self.backGroundView.hidden = NO;
                self.showView.hidden = NO;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        
        case 1://down
        {
            self.showView.top = SCREEN_HEIGHT;
            [UIView animateWithDuration:AnimationInterval animations:^{
                self.backGroundView.hidden = NO;
                self.showView.hidden = NO;
                self.showView.top = self.showFrame.origin.y;
            } completion:^(BOOL finished) {
                
            }];
            
        }
            break;
            
        case 2://up
        {
            self.showView.bottom = NavHeight;
            
            [UIView animateWithDuration:AnimationInterval animations:^{
                self.backGroundView.hidden = NO;
                self.showView.hidden = NO;
                self.showView.top = self.showFrame.origin.y;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)hide
{
    switch (_dismissType) {
        case 0:
        {
            
            [UIView animateWithDuration:AnimationInterval animations:^{
                self.backGroundView.hidden = YES;
                self.showView.hidden = YES;
            } completion:^(BOOL finished) {
                [self.backGroundView removeFromSuperview];
                [self.showView removeFromSuperview];
            }];
        }
            break;
        case 1://down
        {
            [UIView animateWithDuration:AnimationInterval animations:^{
                self.showView.top = SCREEN_HEIGHT;
            } completion:^(BOOL finished) {
                [self.backGroundView removeFromSuperview];
                [self.showView removeFromSuperview];
            }];
        }
            break;
        case 2://up
        {
            [UIView animateWithDuration:AnimationInterval animations:^{
                self.showView.bottom = NavHeight;
            } completion:^(BOOL finished) {
                [_backGroundView removeFromSuperview];
                [_showView removeFromSuperview];
            }];
        }
            break;

        default:
            break;
    }
}

- (void)backGroundViewClick
{
    [self hide];
}


#pragma mark -- 懒加载
- (UIWindow *)showWindow
{
    if (!_showWindow) {
        _showWindow = [[UIApplication sharedApplication] keyWindow];
        if (_showWindow.windowLevel != UIWindowLevelNormal) {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * temp in windows) {
                if (temp.windowLevel == UIWindowLevelNormal) {
                    _showWindow = temp;
                    break;
                }
            }
        }
    }
    return _showWindow;
}

- (UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGroundView.userInteractionEnabled = YES;
        _backGroundView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewClick)];
        [_backGroundView addGestureRecognizer:tap];
    }
    return _backGroundView;
}

@end
