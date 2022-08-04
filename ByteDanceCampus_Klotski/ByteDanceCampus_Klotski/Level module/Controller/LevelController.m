//
//  LevelController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "LevelController.h"

#import "Level.h"

#import "LevelCollectionLayout.h"

#import "PersonItem.h"

#pragma mark - LevelController ()

@interface LevelController () <
    LevelCollectionLayoutDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

/// 华容道CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 华容道的一局的信息
@property (nonatomic, strong) Level *model;

@end

#pragma mark - LevelController

@implementation LevelController

#pragma mark - Life cycle

- (instancetype)initWithLevel:(Level *)level {
    self = [super init];
    if (self) {
        self.model = level;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
}

#pragma mark - Method

// MARK: SEL

- (void)panItem:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan translationInView:self.collectionView];
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat width = kScreenWidth - 20;
        
        LevelCollectionLayout *layout = [[LevelCollectionLayout alloc] init];
        layout.delegate = self;
        layout.lineSpacing = 2;
        layout.interitemSpacing = 2;
        CGFloat minWidth = (width - layout.interitemSpacing) / 4;
        layout.sizeForItem = CGSizeMake(minWidth, minWidth);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, width / 4 * 5) collectionViewLayout:layout];
        _collectionView.center = self.view.SuperCenter;
        
        [_collectionView registerClass:PersonItem.class forCellWithReuseIdentifier:PersonItemReuseIdentifier];
        [_collectionView.panGestureRecognizer addTarget:self action:@selector(panItem:)];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.persons.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PersonItemReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = UIColor.orangeColor;
    
    return cell;
}

#pragma mark - <LevelCollectionLayoutDelegate>

- (PersonFrame)collectionView:(UICollectionView *)collectionView layout:(LevelCollectionLayout *)layout frameForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.model.persons[indexPath.item].frame;
}


#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"LevelController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                LevelController *vc;
                id model = request.parameters[@"level"];
                if ([model isKindOfClass:Level.class]) {
                    vc = [[self alloc] initWithLevel:model];
                }
                NSParameterAssert(vc);
                response.responseController = vc;
                
                [nav pushViewController:vc animated:YES];
            } else {
                
                response.errorCode = RouterResponseWithoutNavagation;
            }
            
        } break;
            
        case RouterRequestParameters: {
            // TODO: 传回参数
        } break;
            
        case RouterRequestController: {
            
            LevelController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}



@end
