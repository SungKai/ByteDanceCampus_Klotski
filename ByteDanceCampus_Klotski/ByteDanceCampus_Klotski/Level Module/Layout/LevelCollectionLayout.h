//
//  LevelCollectionLayout.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

/**华容道真正布局文件
 * 一定要遵守delegate
 * 单个兵的大小也得实现
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LevelCollectionLayout;

#pragma mark - LevelCollectionLayoutDelegate

@protocol LevelCollectionLayoutDelegate <NSObject>

@required

/// 确定布局
/// @param collectionView 视图
/// @param layout 布局
/// @param indexPath 位置
- (PersonFrame)collectionView:(UICollectionView *)collectionView layout:(LevelCollectionLayout *)layout frameForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - LevelCollectionLayout

@interface LevelCollectionLayout : UICollectionViewLayout

/// 代理
@property (nonatomic, weak) id <LevelCollectionLayoutDelegate> delegate;

/// 行间距
@property (nonatomic) CGFloat lineSpacing;

/// 列间距
@property (nonatomic) CGFloat interitemSpacing;

/// 单个兵所占大小
@property (nonatomic) CGSize sizeForItem;

- (void)reloadItemForIndexPath:(NSIndexPath *)indexPath animate:(BOOL)animate;

@end

NS_ASSUME_NONNULL_END
