//
//  AppDelegate.m
//  CustomModalTransition_OC_Demo
//
//  Created by chao on 2017/10/31.
//

#import "AppDelegate.h"
#import "PresentingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [[PresentingViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
