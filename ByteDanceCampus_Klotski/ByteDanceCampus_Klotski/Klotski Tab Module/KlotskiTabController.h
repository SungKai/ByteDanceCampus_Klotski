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

@interface KlotskiTabController : UITabBarController <
    RisingRouterHandler
>

/// tabBar视图
@property(nonatomic, readonly) UITabBar *mainTabBar;

@end

NS_INLINE CGFloat tabBarTop(KlotskiTabController *controller) {
    return controller.view.frame.size.height - UIDevice.statusBarHeight - controller.mainTabBar.frame.size.height;
}

@interface UITabBarController (Rising)

- (void)tabBarVisible:(BOOL)isVisible animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
