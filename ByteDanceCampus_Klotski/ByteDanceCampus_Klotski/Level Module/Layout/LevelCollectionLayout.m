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
        
        NSInteger section = 1;
        if ([self.collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            section = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
        }
         
        for (NSInteger s = 0; s < section; s++) {
            NSInteger items = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:s];
            for (NSInteger i = 0; i < items; i++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:s];
                UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                
                attribute.frame = [self _frameForIndexPath:indexPath];
                
                [_attributes addObject:attribute];
            }
        }
    }
    return _attributes;
}

#pragma mark - Method

- (CGRect)_frameForIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        PersonFrame frame = [self.delegate collectionView:self.collectionView layout:self frameForItemAtIndexPath:indexPath];
        CGFloat x = frame.x * (self.interitemSpacing + self.sizeForItem.width);
        CGFloat y = frame.y * (self.lineSpacing + self.sizeForItem.height);
        CGFloat width = frame.width * self.sizeForItem.width + (frame.width - 1) * self.interitemSpacing;
        CGFloat height = frame.height * self.sizeForItem.height + (frame.height - 1) * self.lineSpacing;
        return CGRectMake(x, y, width, height);
    }
    return CGRectZero;
}

- (void)moveItemAtIndex:(NSInteger)index toDirection:(PersonDirection)direction complition:(void (^ _Nullable)(void))complition{
    UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect frame = attribute.frame;
    CGFloat moveWidth = self.interitemSpacing + self.sizeForItem.width;
    CGFloat moveHeight = self.lineSpacing + self.sizeForItem.height;
    
    switch (direction) {
        case PersonDirectionRight:
            frame.origin.x += moveWidth;
            break;
        case PersonDirectionLeft:
            frame.origin.x -= moveWidth;
            break;
        case PersonDirectionUP:
            frame.origin.y -= moveHeight;
            break;
        case PersonDirectionDown:
            frame.origin.y += moveHeight;
            break;
    }
    
    [self.collectionView
     performBatchUpdates:^{
        attribute.frame = frame;
    }
     completion:^(BOOL finished) {
        if (finished && complition) {
            complition();
        }
    }];
}

#pragma mark - UICollectionViewLayout (UISubclassingHooks)

- (void)prepareLayout {
    [super prepareLayout];
    [self attributes];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = 0;
    for (NSInteger s = 0; s < indexPath.section; s++) {
        count += [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:s];
    }
    return self.attributes[count + indexPath.item];
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.size;
}

@end
