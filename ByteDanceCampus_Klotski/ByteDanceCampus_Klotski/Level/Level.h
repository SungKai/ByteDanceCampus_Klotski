//
//  Level.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**每个关卡的情况
 * 包括名字步数什么的
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
@property (nonatomic, readonly) NSArray <Person *> *persons;

/// 每个人当前的布局情况
@property (nonatomic, copy) NSArray <Person *> *currentPersons;

/// 根据字典确定
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
