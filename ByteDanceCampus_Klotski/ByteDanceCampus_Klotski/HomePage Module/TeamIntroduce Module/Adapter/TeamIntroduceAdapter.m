//
//  TeamIntroduceAdapter.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import "TeamIntroduceAdapter.h"

#import "TeamIntroduceItem.h"

#pragma mark - TeamIntroduceAdapter ()

@interface TeamIntroduceAdapter ()

/// 展示的collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 展示的model
@property (nonatomic, strong) NSMutableArray<TeamIntroduceModel *> *model;

@end

#pragma mark - TeamIntroduceAdapter

@implementation TeamIntroduceAdapter

+ (instancetype)adpterWithCollectionView:(UICollectionView *)view
                               model:(NSMutableArray <TeamIntroduceModel *> *)model {
    TeamIntroduceAdapter *adapter = [[TeamIntroduceAdapter alloc] init];
    adapter.collectionView = view;
    adapter.model = model;
    
    [view registerClass:TeamIntroduceItem.class forCellWithReuseIdentifier:TeamIntroduceItemReuseIdentifier];
    view.delegate = adapter;
    view.dataSource = adapter;
    
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:adapter action:@selector(longPress:)];
    [view addGestureRecognizer:longP];
    
    return adapter;
}

#pragma mark - Method

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
        }  break;
            
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:longPress.view]];
        }  break;
            
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
        } break;
            
        default: {
            [self.collectionView cancelInteractiveMovement];
        } break;
    }
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeamIntroduceItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TeamIntroduceItemReuseIdentifier forIndexPath:indexPath];
    
    TeamIntroduceModel *model = self.model[indexPath.item];
    
    [cell title:model.name content:model.content];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    TeamIntroduceModel *model = self.model[sourceIndexPath.item];
    [self.model removeObject:model];
    [self.model insertObject:model atIndex:destinationIndexPath.item];
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [UIApplication.sharedApplication
     openURL:
         [NSURL URLWithString:
          [NSString stringWithFormat:@"%@",
           self.model[indexPath.item].github]]
     options:@{}
     completionHandler:nil];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return CGSizeMake((collectionView.width - 2 * layout.minimumInteritemSpacing) / 3, (collectionView.height - layout.minimumLineSpacing) / 2);
}

@end
