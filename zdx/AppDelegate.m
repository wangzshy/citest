//
//  AppDelegate.m
//  zdx
//
//  Created by 王征 on 16/8/27.
//  Copyright © 2016年 王征. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SettingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//设置窗口
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * ip = [user objectForKey:@"ip"];
    NSString * port = [user objectForKey:@"port"];
    NSString * url = [user objectForKey:@"url"];
//    NSString * usrid = [user objectForKey:@"usrid"];
//    NSString * password = [user objectForKey:@"password"];
    
    if (url != NULL && ![@"" isEqualToString:url] && ip != NULL && ![@"" isEqualToString:ip] && port != NULL && ![@"" isEqualToString:port] ) {
        NSString * webUrl = [[[[ip stringByAppendingString:@":"] stringByAppendingString:port] stringByAppendingString:@"/"] stringByAppendingString:url];
        MainViewController * mvc = [[MainViewController alloc] init];
        mvc.webUrl = webUrl;
        self.window.rootViewController = mvc;//进入的首个页面
    } else {
        SettingViewController * svc = [[SettingViewController alloc] init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:svc];
        self.window.rootViewController = svc;//进入的首个页面
    }
    [self.window makeKeyAndVisible];//显示

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
