//
//  LevelAdapter.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import "LevelAdapter.h"

#import "Level.h"

#import "PersonItem.h"

#pragma mark - LevelAdapter ()

@interface LevelAdapter ()

/// 华容道CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 华容道的一局的信息
@property (nonatomic, strong) Level *model;

@end

#pragma mark - LevelAdapter

@implementation LevelAdapter

+ (instancetype)adapterWithCollectionView:(UICollectionView *)view layout:(nonnull LevelCollectionLayout *)layout model:(nonnull Level *)model {
    LevelAdapter *adapter = [[LevelAdapter alloc] init];
    adapter.collectionView = view;
    view.dataSource = adapter;
    view.delegate = adapter;
    adapter.model = model;
    layout.delegate = adapter;
    return adapter;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.currentPersons.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PersonItemReuseIdentifier forIndexPath:indexPath];
    
// FIXME: cell.name = self.model.currentPersons[indexPath.item].name;
    cell.name = [NSString stringWithFormat:@"%ld", indexPath.item];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
   moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath {
    Person *a = self.model.currentPersons[sourceIndexPath.item];
    Person *b = self.model.currentPersons[destinationIndexPath.item];
    Person *t = a;
    a = b;
    b = t;
}

#pragma mark - <LevelCollectionLayoutDelegate>

- (PersonFrame)collectionView:(UICollectionView *)collectionView layout:(LevelCollectionLayout *)layout frameForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.model.currentPersons[indexPath.item].frame;
}


@end
