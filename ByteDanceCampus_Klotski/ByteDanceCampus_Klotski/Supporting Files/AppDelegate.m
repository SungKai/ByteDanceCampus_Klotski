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
    
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:[self.router controllerForRouterPath:@"KlotskiTabController"]];
    
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
