//
//  Level+Step.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import "Level.h"

#import "Person.h"

#import "PersonStep.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Level (Step)

@interface Level (Step)

/// 棋子是否可以移动
/// @param index 棋子所在下标
/// @param direction 所想移动的方向
- (BOOL)currentPersonAtIndex:(NSInteger)index
          canMoveToDirection:(PersonDirection)direction;

/// 向哪个方向走，在此之前先执行上面那个去判断，这个不做判断
/// @param index 棋子所在下标
/// @param direction 所想移动的方向
- (void)currentPersonAtIndex:(NSInteger)index
                      moveTo:(PersonDirection)direction;

/// 已经执行完了刚刚那一步
/// @param index 棋子所在下标
/// @param direction 所想移动的方向
- (void)currentPersonAtIndex:(NSInteger)index
didMoveWithProposedDirection:(PersonDirection)direction;

/// 重置
- (void)reset;

/// 是否结束（计算属性）
@property (nonatomic, readonly) BOOL isGameOver;

/// 从当前的问题开始解决，返回步的情况
/// 不会掉用上面的方法，也不会侵占数据
/// 掉用过后，所有布局重新布局
- (NSArray <PersonStep *> *)stepForCurrent;

@end

NS_ASSUME_NONNULL_END
