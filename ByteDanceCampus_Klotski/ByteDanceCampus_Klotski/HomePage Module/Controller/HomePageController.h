//
//  HomePageController.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

/**主页
 * 路由名：@"HomePageController"
 * parameter是必须的，如下
 * @{@"level" : <Level *>}
 * 需要传入一个Level模型
 */

#import <UIKit/UIKit.h>

@class Level;

NS_ASSUME_NONNULL_BEGIN

@interface HomePageController : UIViewController <
    RisingRouterHandler
>

+ (instancetype)new NS_UNAVAILABLE;

/// 每日推荐使用关卡(INOUT)
/// @param model 关卡模型
- (instancetype)initWithModel:(Level *)model;

@end

NS_ASSUME_NONNULL_END
