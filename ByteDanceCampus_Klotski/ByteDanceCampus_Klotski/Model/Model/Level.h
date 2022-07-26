//
//  Level.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**每个关卡的情况
 * 接WCDB为了快速存储
 */

#import <Foundation/Foundation.h>

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

/// 数据表的表名
FOUNDATION_EXPORT NSString *LevelTableName;

#pragma mark - Level

@interface Level : NSObject

/// DB存储地址（计算属性）
@property(nonatomic, readonly, class) NSString *DBpath;

/// 关卡名字
@property (nonatomic, copy) NSString *name;

/// 当前步数（默认从0开始）
@property (nonatomic) NSInteger currentStep;

/// 最佳步数（默认-1为没玩过）
@property (nonatomic) NSInteger bestStep;

/// 是否收藏
@property (nonatomic) BOOL isFavorite;

/// 每个人当前的布局情况
@property (nonatomic, readonly) NSMutableArray <Person *> *personAry;

@end




#pragma mark - Level (CRUD)

/**使用须知
 *
 * 自动保存：
 * - 时机为 replacePersons:
 * - 方式为 insert
 *
 * 手动保存：
 * - 时机为 updateDB
 * - 方式为 update
 * 若没有personAry，会取消本次保存
 * 同时，手动保存会保存当前棋盘情况
 */

@interface Level (CRUD)

/// 根据字典确定
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/// 传入名字和对象
/// @param name 关卡名
/// @param personAry 对象
- (instancetype)initWithName:(NSString *)name persons:(NSArray <Person *> *)personAry;

/// 从WCDB中取除的对象
@property (nonatomic, readonly, class, nullable) NSArray <Level *> *WCDBAry;

/// 设置/重组关卡的对象
/// @param personAry 对象
- (void)replacePersons:(NSArray <Person *> *)personAry;

/// 重置布局/重新开始
- (void)resetLayout;

/// 手动保存
- (void)updateDB;

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

/// 是否结束（计算属性）
@property (nonatomic, readonly) BOOL isGameOver;

/// 从当前的问题开始解决，返回步的情况
/// 不会掉用上面的方法，也不会侵占数据
/// 掉用过后，所有布局重新布局
@property (nonatomic, readonly) NSArray
<NSDictionary
    <NSNumber *, NSNumber *> *> *stepForCurrent;


///**
// *  广度优先树节点结构
// *  仅用于算法
// */
//
//typedef struct TreeNode {
//    std::array<int, 20> code;  // 棋盘布局
//    std::array<PersonStruct, 10> array;   //此时棋子的状态
////    int floor;    // 树的深度
////    int num;     // 树的宽度
//    int index;   // 棋子下标
//    int moveTo;  // 移动方向
//    TreeNode *before;    // 父节点
//} TreeNode;

@end


NS_ASSUME_NONNULL_END
