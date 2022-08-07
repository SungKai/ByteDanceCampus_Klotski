//
//  ViewController.m
//  ByteDanceCampus_Klotski
//
//  Created by 宋开开 on 2022/7/22.
//

#import "MainController.h"

#import "StageSelectAdapter.h"

#import "StageSelectModel.h"

#import "StageTopView.h"

#pragma mark - MainController ()

@interface MainController ()

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

#pragma mark - MainController

@implementation MainController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    self.stageModel = [[StageSelectModel alloc] init];
    self.adapter = [StageSelectAdapter
                    adapterWithController:self
                    tableView:self.stageTableView
                    model:self.stageModel];
    
    [self.view addSubview:self.backImgView];
    [self.view addSubview:self.stageTableView];
    self.stageTableView.tableHeaderView = self.topView;
}

#pragma mark - Method

// MARK: SEL

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
        _topView = [[StageTopView alloc] initWithFrame:CGRectMake(0, 0, self.stageTableView.width, 100)];
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
        
        _stageTableView.showsVerticalScrollIndicator = NO;
        _stageTableView.showsHorizontalScrollIndicator = NO;
        
        _stageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _stageTableView;
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"main"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                MainController *vc = [[self alloc] init];
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
            
            MainController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}


@end
