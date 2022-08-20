//
//  LevelAdapter.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

/**解决所有事情的类 VC强持有这个类
 * 这个类包含所有的level级别事件处理能力
 * 这个类不包含其他视图布局
 * UICollectionView和LevelCollectionLayout可以不用设置代理
 */

#import <Foundation/Foundation.h>

#import "LevelCollectionLayout.h"

#import "LevelFuncView.h"

NS_ASSUME_NONNULL_BEGIN

@class Level;

#pragma mark - LevelAdapter

@interface LevelAdapter : NSObject <
    LevelCollectionLayoutDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    LevelFuncViewDelegate
>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 确定需要解决事情的类
/// @param view 视图
/// @param layout 布局
/// @param model 模型
+ (instancetype)adapterWithCollectionView:(UICollectionView *)view
                                   layout:(LevelCollectionLayout *)layout
                                    model:(Level *)model;

@end

NS_ASSUME_NONNULL_END
