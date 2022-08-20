//
//  Person.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**对于每一个人的一个模型
 * 相对来说比较固定，但不同摆放有不同讲究
 * PersonType与PersonFrame用于算法
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 数据表的表名
FOUNDATION_EXPORT NSString *PersonTableName;

#pragma mark - ENUM (PersonType)

/**成员属性
 * 这个属性只用于算法
 */

typedef NS_ENUM(NSUInteger, PersonType) {
    PersonFoo,        // 空   0 * 0   0
    PersonTinySquare, // 卒   1 * 1   1
    PersonVertical,   // 竖   1 * 2   2
    PersonHorizontal, // 横   2 * 1   3
    PersonBigSquare   // 曹   2 * 2   4
};

#pragma mark - PersonStruct

/**为了值传递，使用struct进行传递
 * 这个struct只能用来读，所有的赋值操作只用于算法
 */

typedef struct _PersonStruct {
    int index;          // 所在下标，是唯一的
    PersonFrame frame;  // 所占位置
    PersonType type;    // 成员属性
} PersonStruct;

#pragma mark - Person

@interface Person : NSObject <
    NSCopying
>

/// 名字
@property (nonatomic, copy) NSString *name;

/// 左边
@property (nonatomic) int x;

/// 顶部
@property (nonatomic) int y;

/// 宽度
@property (nonatomic, readonly) int width;

/// 高度
@property (nonatomic, readonly) int height;

/// 快速得到frame（计算属性）
/// setter时，会对x，y，width，height做出改变
@property (nonatomic) PersonFrame frame;

/// 得到相关类型（计算属性）
@property (nonatomic, readonly) PersonType type;

/// 得到code（计算属性）
@property (nonatomic, readonly) NSString *code;

/// 下标
@property (nonatomic) int index;

/// 得到PersonStruct
@property (nonatomic, readonly) PersonStruct perStruct;

/// 根据字典创建
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
