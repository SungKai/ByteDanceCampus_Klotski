//
//  Level.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import <Foundation/Foundation.h>

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Level : NSObject

/// 名字
@property (nonatomic, copy) NSString *name;

/// 所消耗的步数，负数则是没玩过
@property (nonatomic) NSInteger step;

/// 每一关应有唯一值
@property (nonatomic, readonly) NSString *idCode;

/// 每个人的布局情况
@property (nonatomic, readonly) NSArray <Person *> *persons;

/// 根据字典确定
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
