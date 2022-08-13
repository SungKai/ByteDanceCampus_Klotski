//
//  KlotskiTabController.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

/**路由名@"KlotskiTabController"
 * 不需要参数
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - KlotskiTabController

@interface KlotskiTabController : UITabBarController <
    RisingRouterHandler
>

/// tabBar视图
@property(nonatomic, readonly) UITabBar *mainTabBar;

/// tabBar最高高度
@property (nonatomic, readonly) CGFloat tabBarMaxTop;

@end

#pragma mark - UITabBarController (Rising)

@interface UITabBarController (Rising)

/// 是否展示tabBar，并且是否拥有动画
/// @param isVisible 是否展示
/// @param animated 是否动画
- (void)tabBarVisible:(BOOL)isVisible animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
