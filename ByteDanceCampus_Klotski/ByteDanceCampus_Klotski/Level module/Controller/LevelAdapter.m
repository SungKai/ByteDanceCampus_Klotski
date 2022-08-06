//
//  LevelAdapter.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import "LevelAdapter.h"

#import "Level.h"

#import "Level+Step.h"

#import "PersonItem.h"

#pragma mark - LevelAdapter ()

@interface LevelAdapter ()

/// 华容道CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 华容道布局（CollectionView已经强持有）
@property (nonatomic, weak) LevelCollectionLayout *layout;

/// 华容道的一局的信息
@property (nonatomic, strong) Level *model;

/// p
@property (nonatomic) CGPoint currentP;

@property (nonatomic, weak) UICollectionViewCell *moveItem;

@end

#pragma mark - LevelAdapter

@implementation LevelAdapter

#pragma mark - Life cyle

+ (instancetype)adapterWithCollectionView:(UICollectionView *)view layout:(nonnull LevelCollectionLayout *)layout model:(nonnull Level *)model {
    LevelAdapter *adapter = [[LevelAdapter alloc] init];
    adapter.collectionView = view;
    view.dataSource = adapter;
    view.delegate = adapter;
    
    UISwipeGestureRecognizer *panU = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(panItem:)];
    panU.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *panR = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(panItem:)];
    panR.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *panD = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(panItem:)];
    panD.direction = UISwipeGestureRecognizerDirectionDown;
    
    UISwipeGestureRecognizer *panL = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(panItem:)];
    panL.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [view addGestureRecognizer:panU];
    [view addGestureRecognizer:panR];
    [view addGestureRecognizer:panD];
    [view addGestureRecognizer:panL];
    
    adapter.model = model;
    
    adapter.layout = layout;
    layout.delegate = adapter;
    return adapter;
}

#pragma mark - Method

- (void)panItem:(UISwipeGestureRecognizer *)swipe {
    CGPoint point = [swipe locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (!indexPath) {
        return;
    }
    NSInteger index = indexPath.item;
    
    for (int i = 0; i < 4; i++) {
        if ((swipe.direction & (1 << i)) && [self.model currentPersonAtIndex:index canMoveToDirection:i]) {
            [self.model currentPersonAtIndex:index moveTo:i];
        }
    }
    
    [self.layout reloadItemForIndexPath:indexPath animate:YES];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.currentPersons.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PersonItemReuseIdentifier forIndexPath:indexPath];
    
// FIXME: cell.name = self.model.currentPersons[indexPath.item].name;
    cell.name = [NSString stringWithFormat:@"%ld", indexPath.item];
    
    return cell;
}

#pragma mark - <LevelCollectionLayoutDelegate>

- (PersonFrame)collectionView:(UICollectionView *)collectionView layout:(LevelCollectionLayout *)layout frameForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.model.currentPersons[indexPath.item].frame;
}

@end
