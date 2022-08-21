//
//  StageSelectController.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import "StageSelectController.h"

#import "StageSelectAdapter.h"

#import "StageSelectModel.h"

#import "StageTopView.h"

#import "IntroduceView.h"

#pragma mark - StageSelectController ()

@interface StageSelectController ()

/// 替代原生
@property (nonatomic, strong) UIImageView *backImgView;

/// 头视图
@property (nonatomic, strong) StageTopView *topView;

/// 关卡tableView
@property (nonatomic, strong) UITableView *stageTableView;

/// 关卡模型
@property (nonatomic, strong) StageSelectModel *stageModel;

/// 处理逻辑的类
@property (nonatomic, strong) StageSelectAdapter *adapter;

@end

#pragma mark - StageSelectController

@implementation StageSelectController

#pragma mark - Life cycle

- (instancetype)initWithModel:(StageSelectModel *)model {
    self = [super init];
    if (self) {
        self.stageModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    if (self.stageModel == nil) {
        self.stageModel = [[StageSelectModel alloc] init];
    }
    
    self.adapter = [StageSelectAdapter
                    adapterWithController:self
                    tableView:self.stageTableView
                    tableHeaderView:self.topView
                    model:self.stageModel];
    
    [self.view addSubview:self.backImgView];
    [self.view addSubview:self.stageTableView];
    
    IntroduceView *view = [[IntroduceView alloc] initWithFrame:CGRectMake(0, 0, self.stageTableView.width, 300)];
    self.adapter.scrollView = view;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBarController tabBarVisible:YES animated:YES];
}

#pragma mark - Getter

- (UIImageView *)backImgView {
    if (_backImgView == nil) {
        _backImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImgView.image = [UIImage imageNamed:@"background"];
    }
    return _backImgView;
}

- (StageTopView *)topView {
    if (_topView == nil) {
        _topView = [[StageTopView alloc] initWithFrame:CGRectMake(0, 0, self.stageTableView.width, 160)];
        _topView.title = @"华容道";
    }
    return _topView;
}

- (UITableView *)stageTableView {
    if (_stageTableView == nil) {
        _stageTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _stageTableView.backgroundColor = UIColor.clearColor;
        _stageTableView.width = self.view.width - 80;
        _stageTableView.centerX = self.view.width / 2;
        
        _stageTableView.estimatedRowHeight = 0;
        _stageTableView.estimatedSectionHeaderHeight = 0;
        _stageTableView.estimatedSectionFooterHeight = 0;
        _stageTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _stageTableView.showsVerticalScrollIndicator = NO;
        _stageTableView.showsHorizontalScrollIndicator = NO;
        
        _stageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _stageTableView;
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"StageSelectController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                StageSelectController *vc;
                if (request.parameters[@"StageSelectModel"]) {
                    StageSelectModel *model = request.parameters[@"StageSelectModel"];
                    vc = [[self alloc] initWithModel:model];
                } else {
                    vc = [[self alloc] init];
                }
                
                response.responseController = vc;
                
                [nav pushViewController:vc animated:YES];
            } else {
                
                response.errorCode = RouterResponseWithoutNavagation;
            }
            
        } break;
            
        case RouterRequestParameters: {
        } break;
            
        case RouterRequestController: {
            
            StageSelectController *vc;
            if (request.parameters[@"StageSelectModel"]) {
                StageSelectModel *model = request.parameters[@"StageSelectModel"];
                vc = [[self alloc] initWithModel:model];
            } else {
                vc = [[self alloc] init];
            }
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}

@end
