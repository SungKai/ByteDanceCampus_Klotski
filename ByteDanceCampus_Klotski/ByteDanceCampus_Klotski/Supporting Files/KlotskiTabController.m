//
//  KlotskiTabController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

#import "KlotskiTabController.h"

#import <objc/runtime.h>

@interface KlotskiTabController () 

/// 自定义一个TabBar
@property (nonatomic, strong) UITabBar *klotskiTabBar;

@end

@implementation KlotskiTabController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    
    [self.view addSubview:self.klotskiTabBar];
    self.viewControllers = @[self.navForStageSelect];
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UITabBar *)klotskiTabBar {
    if (_klotskiTabBar == nil) {
        _klotskiTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 200, 49)];
        _klotskiTabBar.bottom = tabBarTop(self);
        _klotskiTabBar.centerX = self.view.width / 2;
        
        _klotskiTabBar.layer.cornerRadius = _klotskiTabBar.height / 2;
        _klotskiTabBar.clipsToBounds = YES;
        _klotskiTabBar.backgroundColor = UIColor.redColor;
        _klotskiTabBar.delegate = self;
    }
    return _klotskiTabBar;
}

- (UINavigationController *)navForStageSelect {
    UIViewController *vc = [self.router controllerForRouterPath:@"StageSelectController"];
    
    vc.tabBarItem =
    [[UITabBarItem alloc]
     initWithTitle:@"play"
     image:[[UIImage imageNamed:@"play.unselect"]
            imageByResizeToSize:CGSizeMake(40, 40)]
     selectedImage:[[UIImage imageNamed:@"paly.select"]
                    imageByResizeToSize:CGSizeMake(40, 40)]];
    
    return [[UINavigationController alloc] initWithRootViewController:vc];
}

- (UITabBar *)mainTabBar {
    return _klotskiTabBar;
}

#pragma mark - Setter

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    self.klotskiTabBar.items = self.tabBar.items;
}

#pragma mark - <UITabBarDelegate>

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"KlotskiTabController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                KlotskiTabController *vc = [[self alloc] init];
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
            
            KlotskiTabController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}

@end

@implementation UITabBarController (Rising)

- (void)tabBarVisible:(BOOL)isVisible animated:(BOOL)animated {
    UITabBar *tabBar = ((KlotskiTabController *)self).mainTabBar;
    if (!(tabBar.hidden ^ isVisible)) {
        return;
    }
    
    CGFloat top = tabBarTop((KlotskiTabController *)self);
    
    [UIView
     animateWithDuration:(animated ? 0.5 : 0)
     animations:^{
        tabBar.top = (isVisible ? top : 0);
    }
     completion:^(BOOL finished) {
        tabBar.hidden = !isVisible;
    }];
}

@end
