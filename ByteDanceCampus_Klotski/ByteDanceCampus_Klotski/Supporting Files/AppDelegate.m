//
//  AppDelegate.m
//  ByteDanceCampus_Klotski
//
//  Created by 宋开开 on 2022/7/22.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RisingRouterRequest *request = [RisingRouterRequest requestWithRouterPath:@"main" parameters:nil];
    request.requestType = RouterRequestController;

    __block UIViewController *vc;
    [self.router
     handleRequest:request
     complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
        vc = response.responseController;
    }];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
