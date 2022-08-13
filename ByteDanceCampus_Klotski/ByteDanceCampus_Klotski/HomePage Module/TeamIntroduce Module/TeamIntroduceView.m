//
//  TeamIntroduceView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import "TeamIntroduceView.h"

#import "TeamIntroduceModel.h"

#import "TeamIntroduceAdapter.h"

#pragma mark - TeamIntroduceView ()

@interface TeamIntroduceView ()

/// 展示的collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 展示的model
@property (nonatomic, strong) NSMutableArray<TeamIntroduceModel *> *model;

/// 处理事务
@property (nonatomic, strong) TeamIntroduceAdapter *adapter;

@end

#pragma mark - TeamIntroduceView

@implementation TeamIntroduceView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        self.model = TeamIntroduceModel.ourTeamAry;
        
        self.adapter =
        [TeamIntroduceAdapter
         adpterWithCollectionView:self.collectionView
         model:self.model];
        
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 7;
        layout.minimumInteritemSpacing = 7;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.clearColor;
    }
    return _collectionView;
}

#pragma mark - Setter

@end
