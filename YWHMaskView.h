//
//  YWHMaskView.h
//  uiwindowTest
//
//  Created by 昊天 on 2017/7/20.
//  Copyright © 2017年 昊天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#define AnimationInterval 0.5
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width        //屏幕宽
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height      //屏幕高
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#define NavHeight (IS_IPHONE_X == YES ? 88 : 64) //机型

typedef enum {
    ENUM_DISMISS_TYPE_DEFAULT = 0,
    ENUM_DISMISS_TYPE_SCREEN_DOWN,
    ENUM_DISMISS_TYPE_SCREEN_UP,
    
}ENUM_DISMISS_TYPE;

typedef enum {
    ENUM_SHOW_TYPE_DEFAULT = 0,
    ENUM_SHOW_TYPE_SCREEN_DOWN,
    ENUM_SHOW_TYPE_SCREEN_UP,
    
}ENUM_SHOW_TYPE;

@interface YWHMaskView : UIView

+ (void)ShowTargetView:(UIView *)showView
           TargetFrame:(CGRect)frame
        BackColorAlpha:(CGFloat)alpha
              ShowType:(ENUM_SHOW_TYPE)showType
           DismissType:(ENUM_DISMISS_TYPE)dismissType;

+ (void)Hide;

@end


@interface YWHMaskView (Extension)

+ (void)ShowTargetView:(UIView *)showView
           TargetFrame:(CGRect)frame
        BackColorAlpha:(CGFloat)alpha
              ShowType:(ENUM_SHOW_TYPE)showType
           DismissType:(ENUM_DISMISS_TYPE)dismissType
            Completion:(void (^) (void))completion;

@end

