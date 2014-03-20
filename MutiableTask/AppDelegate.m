//
//  AppDelegate.m
//  MutiableTask
//
//  Created by wangtao on 14-3-19.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "AppDelegate.h"
#import "ThreadViewController.h"
#import "OperationViewController.h"
#import "GCDViewController.h"
#import "PerformSelectorViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    ThreadViewController *threadController = [[ThreadViewController alloc] init];
    OperationViewController *operController = [[OperationViewController alloc] init];
    GCDViewController *gcdController = [[GCDViewController alloc] init];
    PerformSelectorViewController *performController = [[PerformSelectorViewController alloc] init];
    
    threadController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Thread" image:[UIImage imageNamed:@"Thread"] tag:0];
    operController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Operation" image:[UIImage imageNamed:@"Opera"] tag:0];
    gcdController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"GCD" image:[UIImage imageNamed:@"Thread"] tag:0];
    performController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Perform" image:[UIImage imageNamed:@"Opera"] tag:0];
    tabBarController.viewControllers = @[threadController,performController, operController, gcdController];
    self.window.rootViewController = tabBarController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
