//
//  Level.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**每个关卡的情况
 * 接WCDB为了快速存储
 * TODO: 第一次从plist，以后从WCDB
 * TODO: 每个level都有唯一算法解
 * TODO: 自定义一个布局？
 */

#import <Foundation/Foundation.h>

#import "Person.h"

#import "PersonStep.h"

NS_ASSUME_NONNULL_BEGIN

/// 数据表的表名
FOUNDATION_EXPORT NSString *LevelTableName;

#pragma mark - Level

@interface Level : NSObject

/// DB存储地址（计算属性）
@property(nonatomic, readonly, class) NSString *DBpath;

/// 名字
@property (nonatomic, copy) NSString *name;

/// 最佳步数，-1为没玩过
@property (nonatomic) NSInteger bestStep;

/// 当前步数，从0开始
@property (nonatomic) NSInteger currentStep;

/// 每一关应有唯一值（计算属性）
@property (nonatomic, readonly) NSString *idCode;

/// 每个人原始的布局情况
///（使用setter时，bestStep，currentStep，currentPersons全部打回）
/// 使用A.persons = A.persons时，说明是重新来
@property (nonatomic, copy) NSArray <Person *> *persons;

/// 每个人当前的布局情况
@property (nonatomic, readonly) NSArray <Person *> *currentPersons;

/// 根据字典确定
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

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
