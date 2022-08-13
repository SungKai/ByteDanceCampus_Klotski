//
//  HomePageController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

#import "HomePageController.h"

#import "TeamIntroduceView.h"

#pragma mark - HomePageController ()

@interface HomePageController ()

/// 大logo
@property (nonatomic, strong) UIImageView *logoImgView;

/// 介绍
@property (nonatomic, strong) TeamIntroduceView *introduceView;

@end

#pragma mark - HomePageController

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.introduceView];
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
                HomePageController *vc = [[self alloc] init];
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
            
            HomePageController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}

@end