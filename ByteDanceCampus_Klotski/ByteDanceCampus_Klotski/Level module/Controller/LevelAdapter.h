//
//  LevelAdapter.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import <Foundation/Foundation.h>

#import "LevelCollectionLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class Level;

@interface LevelAdapter : NSObject <
    LevelCollectionLayoutDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)adapterWithCollectionView:(UICollectionView *)view
                                   layout:(LevelCollectionLayout *)layout
                                    model:(Level *)model;

@end

NS_ASSUME_NONNULL_END
