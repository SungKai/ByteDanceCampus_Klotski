//
//  StageSelectController.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

/**路由名:@"StageSelectController"
 * 可传参数，如下
 * @{@"StageSelectModel" : <StageSelectModel *>}
 * INOUT，如有其他处理，请copy
 */

#import <UIKit/UIKit.h>

@class StageSelectModel;

#pragma mark - StageSelectController

@interface StageSelectController : UIViewController <
    RisingRouterHandler
>

+ (instancetype)new NS_UNAVAILABLE;

/// 可根据模型进行传递
/// @param model 模型(INOUT)
- (instancetype)initWithModel:(StageSelectModel *)model;

@end

