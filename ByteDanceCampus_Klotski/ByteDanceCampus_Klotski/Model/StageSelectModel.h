//
//  StageSelectModel.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import <Foundation/Foundation.h>

#import "Level.h"

NS_ASSUME_NONNULL_BEGIN

@interface StageSelectModel : NSObject

/// 整个华容道的数据
@property (nonatomic, readonly) NSArray <Level *> *stage;

@end

NS_ASSUME_NONNULL_END
