//
//  Person.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**对于每一个人的一个模型
 * 相对来说比较固定，但不同摆放有不同讲究
 * TODO: 在高阶应用时，要考虑全横全竖
 * PersonType与PersonFrame用于算法
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ENUM (PersonType)

typedef NS_ENUM(NSUInteger, PersonType) {
    PersonFoo,        // 空   0 * 0
    PersonTinySquare, // 卒   1 * 1
    PersonVertical,   // 竖   1 * 2
    PersonHorizontal, // 横   2 * 1
    PersonBigSquare   // 曹   2 * 2
};

#pragma mark - ENUM (PersonDirrection)

typedef NS_ENUM(NSUInteger, PersonDirection) {
    PersonDirectionRight, // 右
    PersonDirectionLeft,  // 左
    PersonDirectionUP,    // 上
    PersonDirectionDown   // 下
};

#pragma mark - Person

@interface Person : NSObject <
    NSCopying
>

/// 名字
@property (nonatomic, copy) NSString *name;

/// 宽度
@property (nonatomic) int width;

/// 高度
@property (nonatomic) int height;

/// 左边
@property (nonatomic) int x;

/// 顶部
@property (nonatomic) int y;

/// 快速得到frame（计算属性）
/// setter时，会对x，y，width，height做出改变
@property (nonatomic) PersonFrame frame;

/// 得到相关类型（计算属性）
@property (nonatomic) PersonType type;

/// 根据字典创建
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
