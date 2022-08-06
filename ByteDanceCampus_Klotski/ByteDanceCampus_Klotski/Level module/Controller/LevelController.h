//
//  LevelController.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**路由名@"LevelController"
 * parameter是必须的，如下
 * @{@"level" : [Level *]}
 * 需要传入一个Level模型
 */

#import <UIKit/UIKit.h>

@class Level;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LevelController

@interface LevelController : UIViewController <
    RisingRouterHandler
>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 初始化，至少得是一个level模型
/// @param level level模型
- (instancetype)initWithLevel:(Level *)level;

@end

NS_ASSUME_NONNULL_END
