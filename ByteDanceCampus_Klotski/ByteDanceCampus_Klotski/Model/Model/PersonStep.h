//
//  PersonStep.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import <Foundation/Foundation.h>

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - PersonStep

@interface PersonStep : NSObject

/// 哪个人
@property (nonatomic, strong) Person *person;

/// 走哪步
@property (nonatomic) PersonDirection direction;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 快速创建对象
/// @param person 哪个人
/// @param direction 走哪步
+ (instancetype)stepForPerson:(Person *)person direction:(PersonDirection)direction;

@end

NS_ASSUME_NONNULL_END
