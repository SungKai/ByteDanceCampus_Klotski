//
//  UIDevice+Rising.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Rising)

/// 顶部安全区高度
@property(nonatomic, readonly, class) CGFloat safeDistanceTop;

/// 底部安全区高度
@property(nonatomic, readonly, class) CGFloat safeDistanceBottom;

/// 顶部状态栏高度（包括安全区）
@property(nonatomic, readonly, class) CGFloat statusBarHeight;

/// 导航栏高度
@property(nonatomic, readonly, class) CGFloat navigationBarHeight;

/// 状态栏+导航栏的高度
@property(nonatomic, readonly, class) CGFloat navigationFullHeight;

/// 底部导航栏高度（包括安全区）
@property(nonatomic, readonly, class) CGFloat tabBarFullHeight;

@end

NS_ASSUME_NONNULL_END
