//
//  XHQDefine.h
//  ShanghaiCard
//
//  Created by 渴望 on 2018/10/30.
//  Copyright © 2018 渴望. All rights reserved.
//
#ifndef SizeO_h
#define SizeO_h

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

/** 屏幕尺寸 */
static inline CGSize kScreenSize() {
    return [[UIScreen mainScreen] bounds].size;
}

/** 屏幕宽 */
static inline CGFloat kScreenWidth() {
    return kScreenSize().width;
}

/** 屏幕高 */
static inline CGFloat kScreenHeight() {
    return kScreenSize().height;
}


/** 基于iPhone6适配屏幕尺寸 */
static inline CGFloat kAdapt(CGFloat x) {
    return ((x) / 375.f * kScreenWidth());
}

/** 是否是5 SE */
static inline BOOL kIsIPhone5SE() {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return NO;
    }
    return kScreenHeight() == 568.f;
}

/** 是否是iPhoneX系列 */
static inline BOOL kIsIPhoneX() {
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneX;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    
    return iPhoneX;
}


/** 导航栏高度 */
static inline CGFloat kNavigationBarHeight() {
    return 44.f;
}

/** 状态栏高度 */
static inline CGFloat kStatusBarHeight() {
    if (@available(iOS 13.0, *)) {
        return [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
    }else{
        return [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
}

/** 导航栏+状态栏高度 */
static inline CGFloat kNavigationStatusHeight() {
    return (kStatusBarHeight() + kNavigationBarHeight());
}

/** 底部指示栏高度 */
static inline CGFloat kHomeIndicatorHeight() {
    return kIsIPhoneX() ? 34.f : 0.f;
}

/** 底部标签栏高度 */
static inline CGFloat kTabBarHeight() {
    return (kHomeIndicatorHeight() + 49.f);
}

#endif /* SizeO_h */
