//
//  TeamIntroduceModel.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamIntroduceModel : NSObject

/// 生成一个Array
@property(nonatomic, readonly, class) NSMutableArray <TeamIntroduceModel *> *ourTeamAry;

/// 描述，多为标题
@property (nonatomic, copy) NSString *name;

/// 细节，多为补充
@property (nonatomic, copy) NSString *content;

/// Github地址
@property (nonatomic, copy) NSString *github;

@end

NS_ASSUME_NONNULL_END
