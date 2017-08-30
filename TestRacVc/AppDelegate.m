//
//  AppDelegate.m
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import "AppDelegate.h"
#import <CodePush/CodePush.h>

#import <WeexSDK/WXSDKEngine.h>
#import <WeexSDK/WXLog.h>
#import <WeexSDK/WXDebugTool.h>
#import <WeexSDK/WXAppConfiguration.h>
#import <WeexSDK/WXSDKInstance.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)initWeex
{
    //business configuration
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    //init sdk environment
    [WXSDKEngine initSDKEnvironment];
    //register custom module and component，optional
//    [WXSDKEngine registerComponent:@"MyView" withClass:[MyViewComponent class]];
//    [WXSDKEngine registerModule:@"event" withClass:[WXEventModule class]];
//    //register the implementation of protocol, optional
//    [WXSDKEngine registerHandler:[WXNavigationDefaultImpl new] withProtocol:@protocol(WXNavigationProtocol)];
    //set the log level
    [WXLog setLogLevel: WXLogLevelAll];

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWeex];
    // Override point for customization after application launch.
    
    // NSURL *jsCodeLocation = [CodePush bundleURL];
    self.jsCodeLocation = [CodePush bundleURL];
    //NSLog(@"here:%@",self.jsCodeLocation.absoluteString);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
