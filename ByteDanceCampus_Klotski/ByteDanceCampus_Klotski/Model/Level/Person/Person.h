//
//  Person.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

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

/// 根据字典创建
/// @param dictionary 字典
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
