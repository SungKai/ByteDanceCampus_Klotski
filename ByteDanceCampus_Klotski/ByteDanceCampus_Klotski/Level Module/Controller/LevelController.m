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

#import "LevelAdapter.h"

#pragma mark - LevelController ()

@interface LevelController ()

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 华容道CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 华容道的一局的信息
@property (nonatomic, strong) Level *model;

/// Adapter
@property (nonatomic, strong) LevelAdapter *adapter;

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
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.adapter = [LevelAdapter adapterWithCollectionView:self.collectionView layout:(LevelCollectionLayout *)self.collectionView.collectionViewLayout model:self.model];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController tabBarVisible:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.model updateDB];
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, UIDevice.safeDistanceTop + 10, self.view.width, 100)];
        _titleLab.backgroundColor = UIColor.clearColor;
        _titleLab.font = [UIFont fontWithName:PingFangSCBold size:52];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = self.model.name;
    }
    return _titleLab;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat width = self.view.width - 20;
        
        LevelCollectionLayout *layout = [[LevelCollectionLayout alloc] init];
        layout.lineSpacing = layout.interitemSpacing = 5;
        CGFloat minWidth = width / 4 - layout.interitemSpacing;
        layout.sizeForItem = CGSizeMake(minWidth, minWidth);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, (minWidth + layout.lineSpacing) * 5) collectionViewLayout:layout];
        _collectionView.center = self.view.SuperCenter;
        _collectionView.backgroundColor = UIColor.clearColor;
        
        [_collectionView registerClass:PersonItem.class forCellWithReuseIdentifier:PersonItemReuseIdentifier];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
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
