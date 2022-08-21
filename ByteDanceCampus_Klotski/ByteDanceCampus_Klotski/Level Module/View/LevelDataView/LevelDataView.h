//
//  LevelDataView.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/21.
//

/**数据展示
 * 当前步数 / (正在求解/求解完毕)
 * 最佳步数 / 自动求解步数
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LevelDataView

@interface LevelDataView : UIView

/// 正常游玩
/// @param step 当前步数
/// @param best 最佳步数
- (void)dataWithCurrentStep:(NSInteger)step bestStep:(NSInteger)best;

/// 正在计算
- (void)dataWithCalculate;

/// 正在求解
/// @param finalStep 所需求解步数
- (void)dataWithSolvingFinalStep:(NSInteger)finalStep;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
