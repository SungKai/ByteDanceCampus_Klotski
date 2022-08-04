//
//  LevelCollectionLayout.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "LevelCollectionLayout.h"

#pragma mark - LevelCollectionLayout ()

@interface LevelCollectionLayout ()

/// 布局
@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *> *attributes;

@end

@implementation LevelCollectionLayout

#pragma mark - Getter

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attributes {
    if (_attributes == nil) {
        _attributes = NSMutableArray.array;
        NSInteger section = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
        for (NSInteger s = 0; s < section; s++) {
            NSInteger items = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:s];
            for (NSInteger i = 0; i < items; i++) {
                UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:s]];
                
                if (self.delegate) {
                    PersonFrame frame = [self.delegate collectionView:self.collectionView layout:self frameForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:s]];
                    CGFloat x = frame.x * (self.interitemSpacing + self.sizeForItem.width);
                    CGFloat y = frame.y * (self.lineSpacing + self.sizeForItem.height);
                    CGFloat width = frame.width * self.sizeForItem.width + (frame.width - 1) * self.interitemSpacing;
                    CGFloat height = frame.height * self.sizeForItem.height + (frame.height - 1) * self.lineSpacing;
                    attribute.frame = CGRectMake(x, y, width, height);
                }
                
                [_attributes addObject:attribute];
            }
        }
    }
    return _attributes;
}

#pragma mark - UICollectionViewLayout (UISubclassingHooks)

- (void)prepareLayout {
    [super prepareLayout];
    [self attributes];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes;
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.size;
}

@end
