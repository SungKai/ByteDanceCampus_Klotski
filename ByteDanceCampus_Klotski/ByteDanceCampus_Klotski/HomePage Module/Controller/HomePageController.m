//
//  HomePageController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

#import "HomePageController.h"

#import "TeamIntroduceView.h"

#import "TodayRecommendView.h"

#import "Level.h"

#pragma mark - HomePageController ()

@interface HomePageController ()

/// 大背景
@property (nonatomic, strong) UIImageView *backImgView;

/// 大logo
@property (nonatomic, strong) UIImageView *logoImgView;

/// 介绍
@property (nonatomic, strong) TeamIntroduceView *introduceView;

/// 关卡（用于今日关卡选择）
@property (nonatomic, strong) Level *model;

/// 今日推荐
@property (nonatomic, strong) TodayRecommendView *recommendView;

@end

#pragma mark - HomePageController

@implementation HomePageController

#pragma mark - Life cycle

- (instancetype)initWithModel:(Level *)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    [self.view addSubview:self.backImgView];
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.introduceView];
    [self.view addSubview:self.recommendView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBarController tabBarVisible:YES animated:YES];
}

#pragma mark - Method

- (void)_push {
    [self.router
     pushForRouterPath:@"LevelController"
     parameters:@{
        @"level" : self.model
    }];
}

#pragma mark - Getter

- (UIImageView *)logoImgView {
    if (_logoImgView == nil) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, UIDevice.safeDistanceTop, self.view.width, self.view.width / 1.5)];
        _logoImgView.image = [UIImage imageNamed:@"title.logo"];
    }
    return _logoImgView;
}

- (TeamIntroduceView *)introduceView {
    if (_introduceView == nil) {
        CGFloat width = self.view.width - 30;
        _introduceView = [[TeamIntroduceView alloc] initWithFrame:CGRectMake(15, self.logoImgView.bottom, width, width / 2.5)];
    }
    return _introduceView;
}

- (UIImageView *)backImgView {
    if (_backImgView == nil) {
        _backImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backImgView.image = [UIImage imageNamed:@"background"];
    }
    return _backImgView;
}

- (TodayRecommendView *)recommendView {
    if (_recommendView == nil) {
        CGFloat width = self.view.width * 0.7;
        _recommendView = [[TodayRecommendView alloc] initWithFrame:CGRectMake(0, self.introduceView.bottom + 20, width, width * 0.5)];
        _recommendView.centerX = self.view.width / 2;
        _recommendView.title = self.model.name;
        [_recommendView addTarget:self action:@selector(_push)];
    }
    return _recommendView;
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"HomePageController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                HomePageController *vc;
                if (request.parameters[@"level"]) {
                    Level *model = request.parameters[@"level"];
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
            
            HomePageController *vc;
            if (request.parameters[@"level"]) {
                Level *model = request.parameters[@"level"];
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
