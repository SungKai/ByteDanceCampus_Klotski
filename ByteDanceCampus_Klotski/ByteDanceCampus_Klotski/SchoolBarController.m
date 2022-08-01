//
//  SchoolBarController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/1.
//

#import "SchoolBarController.h"

@interface SchoolBarController ()

@end

@implementation SchoolBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBar.backgroundColor = UIColor.redColor;
        self.viewControllers = @[self.aVC, self.aVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIViewController *)aVC {
    return [self.router controllerForRouterPath:@"main"];
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"TabBarController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                SchoolBarController *vc = [[self alloc] init];
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
            
            SchoolBarController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}



@end
