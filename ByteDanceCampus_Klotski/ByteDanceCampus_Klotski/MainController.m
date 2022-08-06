//
//  ViewController.m
//  ByteDanceCampus_Klotski
//
//  Created by 宋开开 on 2022/7/22.
//

#import "MainController.h"

#import "StageSelectModel.h"

@interface MainController ()

/// 关卡tableView
@property (nonatomic, strong) UICollectionView *stageCollectionView;

/// 关卡模型
@property (nonatomic, strong) StageSelectModel *stageModel;

@end

@implementation MainController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
    
    self.stageModel = [[StageSelectModel alloc] init];
    
    [self.view addSubview:self.btn];
}

#pragma mark - Method

// MARK: SEL

- (void)tap:(UIButton *)btn {
    [self.router pushForRouterPath:@"LevelController" parameters:@{@"level" : self.stageModel.stages[0]}];
}

#pragma mark - Getter

- (UIButton *)btn {
    UIButton *_btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    _btn.backgroundColor = UIColor.redColor;
    [_btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    return _btn;
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
