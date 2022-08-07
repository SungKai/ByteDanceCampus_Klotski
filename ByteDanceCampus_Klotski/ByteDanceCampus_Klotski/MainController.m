//
//  ViewController.m
//  ByteDanceCampus_Klotski
//
//  Created by 宋开开 on 2022/7/22.
//

#import "MainController.h"

#import "StageSelectAdapter.h"

#import "StageSelectModel.h"

@interface MainController ()

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
    self.view.backgroundColor = UIColor.greenColor;
    
    self.stageModel = [[StageSelectModel alloc] init];
    self.adapter = [StageSelectAdapter
                    adapterWithController:self
                    tableView:self.stageTableView
                    model:self.stageModel];
    
    [self.view addSubview:self.stageTableView];
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UITableView *)stageTableView {
    if (_stageTableView == nil) {
        _stageTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _stageTableView.showsVerticalScrollIndicator = NO;
        _stageTableView.showsHorizontalScrollIndicator = NO;
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
