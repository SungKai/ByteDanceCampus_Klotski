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

#import "LevelFuncView.h"

#pragma mark - LevelController ()

@interface LevelController ()

/// 返回按钮
@property (nonatomic, strong) UIButton *popBtn;

/// 背景
@property (nonatomic, strong) UIImageView *backImgView;

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 华容道CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 华容道的一局的信息
@property (nonatomic, strong) Level *model;

/// 关于关卡的功能
@property (nonatomic, strong) LevelFuncView *funcView;

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
    
    self.adapter = [LevelAdapter adapterWithCollectionView:self.collectionView layout:(LevelCollectionLayout *)self.collectionView.collectionViewLayout model:self.model];
    
    [self.view addSubview:self.backImgView];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.popBtn];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.funcView];
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

- (void)__pop:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter

- (UIButton *)popBtn {
    if (_popBtn == nil) {
        _popBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, UIDevice.statusBarHeight, 40, 40)];
        
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
        view.frame = _popBtn.bounds;
        [_popBtn insertSubview:view atIndex:0];
        
        [_popBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _popBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 10, 6, 3);
        _popBtn.clipsToBounds = YES;
        _popBtn.layer.cornerRadius = _popBtn.width / 2;
        [_popBtn bringSubviewToFront:_popBtn.imageView];
        
        [_popBtn addTarget:self action:@selector(__pop:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popBtn;
}

- (UIImageView *)backImgView {
    if (_backImgView == nil) {
        _backImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImgView.image = [UIImage imageNamed:@"back.level"];
    }
    return _backImgView;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, UIDevice.safeDistanceTop + 20, self.view.width, 100)];
        _titleLab.backgroundColor = UIColor.clearColor;
        _titleLab.font = [UIFont fontWithName:PangMenZhengDaoBold size:83];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = self.model.name;
        _titleLab.textColor = [UIColor colorWithHexString:@"#DDC992"];
    }
    return _titleLab;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat width = self.view.width - 40;
        
        LevelCollectionLayout *layout = [[LevelCollectionLayout alloc] init];
        layout.lineSpacing = layout.interitemSpacing = 5;
        CGFloat minWidth = width / 4 - layout.interitemSpacing;
        layout.sizeForItem = CGSizeMake(minWidth, minWidth);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width - layout.interitemSpacing, (minWidth + layout.lineSpacing) * 5 - layout.lineSpacing) collectionViewLayout:layout];
        _collectionView.center = self.view.SuperCenter;
        _collectionView.backgroundColor = UIColor.clearColor;
        
        [_collectionView registerClass:PersonItem.class forCellWithReuseIdentifier:PersonItemReuseIdentifier];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (LevelFuncView *)funcView {
    if (_funcView == nil) {
        CGFloat width = self.view.width - 30;
        _funcView = [[LevelFuncView alloc] initWithFrame:CGRectMake(15, 0, width, 50)];
        _funcView.centerY = (self.collectionView.bottom + self.view.height) / 2;
        _funcView.delegate = self.adapter;
    }
    return _funcView;
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
