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
@property (nonatomic, copy) NSArray <Person *> *persons;

/// 每个人当前的布局情况
@property (nonatomic, readonly) NSArray <Person *> *currentPersons;

/// 根据字典确定
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
