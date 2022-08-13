//
//  TeamIntroduceAdapter.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import <Foundation/Foundation.h>

#import "TeamIntroduceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamIntroduceAdapter : NSObject <
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
>

+ (instancetype)adpterWithCollectionView:(UICollectionView *)view
                                   model:(NSMutableArray <TeamIntroduceModel *> *)model;

@end

NS_ASSUME_NONNULL_END
