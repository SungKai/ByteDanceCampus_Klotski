//
//  HomePageController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

#import "HomePageController.h"

#import "TeamIntroduceView.h"

#import "Level.h"

#pragma mark - HomePageController ()

@interface HomePageController ()

/// 大logo
@property (nonatomic, strong) UIImageView *logoImgView;

/// 介绍
@property (nonatomic, strong) TeamIntroduceView *introduceView;

/// 关卡（用于今日关卡选择）
@property (nonatomic, strong) Level *model;

/// 今日推荐按钮
@property (nonatomic, strong) UIButton *recommendBtn;

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
    
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.introduceView];
    [self.view addSubview:self.recommendBtn];
    [self setSEL];
}

- (void)setSEL {
    [self.recommendBtn addTarget:self action:@selector(clickToRecommend) forControlEvents:UIControlEventTouchUpInside];
}

/// 点击今日推荐按钮跳转到关卡
- (void)clickToRecommend {
    [self.router
     pushForRouterPath:@"LevelController"
     parameters:@{
        @"level" : self.model
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBarController tabBarVisible:YES animated:YES];
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
        _introduceView = [[TeamIntroduceView alloc] initWithFrame:CGRectMake(15, self.logoImgView.bottom, self.view.width - 30, 180)];
    }
    return _introduceView;
}

- (UIButton *)recommendBtn {
    if (_recommendBtn == nil) {
        _recommendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width * 0.2, self.view.height * 0.7, self.view.width * 0.6, 100)];
        [_recommendBtn setBackgroundColor:UIColor.systemBlueColor];
//        _recommendBtn setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
        
    }
    return _recommendBtn;
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
            // TODO: 传回参数
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
