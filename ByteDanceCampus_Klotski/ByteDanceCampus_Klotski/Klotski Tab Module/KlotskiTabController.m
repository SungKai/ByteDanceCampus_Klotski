//
//  KlotskiTabController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

#import "KlotskiTabController.h"

#import "StageSelectModel.h"

#pragma mark - KlotskiTabController ()

@interface KlotskiTabController () 

/// 自定义一个TabBar
@property (nonatomic, strong) UITabBar *klotskiTabBar;

/// 游戏嘛，全局model不过分
@property (nonatomic, strong) StageSelectModel *model;

@end

#pragma mark - KlotskiTabController

@implementation KlotskiTabController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    self.model = [[StageSelectModel alloc] init];
    
    [self.view addSubview:self.klotskiTabBar];
    self.viewControllers = @[self.navForHomePage, self.navForStageSelect];
}

#pragma mark - Method

- (Level *)todayLevel {
    NSString *todayStr = [NSDate.date stringWithFormat:@"YYYYMMDD"];
    NSString *userDay = [NSUserDefaults.standardUserDefaults stringForKey:Klotski_today_String];
    if (![userDay isEqualToString:todayStr]) {
        [NSUserDefaults.standardUserDefaults setValue:todayStr forKey:Klotski_today_String];
        NSInteger todayIndex = arc4random() % self.model.stages.count;
        [NSUserDefaults.standardUserDefaults setInteger:todayIndex forKey:Klotski_indexAtLevel_Long];
    }
    NSInteger todayIndex = [NSUserDefaults.standardUserDefaults integerForKey:Klotski_indexAtLevel_Long];
    return self.model.stages[todayIndex];
}

#pragma mark - Getter

- (UITabBar *)klotskiTabBar {
    if (_klotskiTabBar == nil) {
        _klotskiTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 200, 49)];
        _klotskiTabBar.top = self.tabBarMaxTop;
        _klotskiTabBar.centerX = self.view.width / 2;
        
        _klotskiTabBar.layer.cornerRadius = _klotskiTabBar.height / 2;
        _klotskiTabBar.clipsToBounds = YES;
        _klotskiTabBar.delegate = self;
        
        UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
        view.frame = _klotskiTabBar.bounds;
        [_klotskiTabBar insertSubview:view atIndex:0];
    }
    return _klotskiTabBar;
}

- (UIViewController *)navForStageSelect {
    UIViewController *vc =
    [self.router
     controllerForRouterPath:@"StageSelectController"
     parameters:@{
        @"StageSelectModel" : self.model
    }];
    
    vc.tabBarItem =
    [[UITabBarItem alloc]
     initWithTitle:@"play"
     image:[[[UIImage
            imageNamed:@"play.unselect"]
            imageByResizeToSize:CGSizeMake(40, 40)]
            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
     selectedImage:[[[UIImage
                    imageNamed:@"paly.select"]
                    imageByResizeToSize:CGSizeMake(40, 40)]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.navigationController.navigationBarHidden = YES;
    vc.navigationController.hidesBottomBarWhenPushed = YES;
    return nav;
}

- (UIViewController *)navForHomePage {
    Level *model = self.todayLevel;
    
    UIViewController *vc =
    [self.router
     controllerForRouterPath:@"HomePageController"
     parameters:@{
        @"level" : model
     }];
    
    vc.tabBarItem =
    [[UITabBarItem alloc]
     initWithTitle:@"Klotski"
     image:[[[UIImage
            imageNamed:@"main.unselect"]
            imageByResizeToSize:CGSizeMake(25, 25)]
            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
     selectedImage:[[[UIImage
                    imageNamed:@"main.select"]
                    imageByResizeToSize:CGSizeMake(25, 25)]
                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.navigationController.navigationBarHidden = YES;
    vc.navigationController.hidesBottomBarWhenPushed = YES;
    return nav;
}

- (UITabBar *)mainTabBar {
    return _klotskiTabBar;
}

- (CGFloat)tabBarMaxTop {
    return self.view.height - UIDevice.statusBarHeight - self.mainTabBar.height;
}

#pragma mark - Setter

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    self.klotskiTabBar.items = self.tabBar.items;
    self.klotskiTabBar.selectedItem = self.tabBar.selectedItem;
}

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

#pragma mark - UITabBarController (Rising)

@implementation UITabBarController (Rising)

- (UITabBar *)mainTabBar {
    return ((KlotskiTabController *)self).mainTabBar;
}

- (void)tabBarVisible:(BOOL)isVisible animated:(BOOL)animated {
    UITabBar *tabBar = ((KlotskiTabController *)self).mainTabBar;
    if (tabBar.hidden ^ isVisible) {
        return;
    }
    
    CGFloat top = ((KlotskiTabController *)self).tabBarMaxTop;
    
    [UIView
     animateWithDuration:(animated ? 0.3 : 0)
     animations:^{
        tabBar.top = (isVisible ? top : self.view.bottom);
    }
     completion:^(BOOL finished) {
        if (finished) {
            tabBar.hidden = !isVisible;
        }
    }];
}

@end
