//
//  SecondViewController.m
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import "SecondViewController.h"
#import <React/RCTRootView.h>
#import <RCTBundleURLProvider.h>
#import <CodePush.h>
#import "AppDelegate.h"

#import <WeexSDK/WXSDKEngine.h>
#import <WeexSDK/WXLog.h>
#import <WeexSDK/WXDebugTool.h>
#import <WeexSDK/WXAppConfiguration.h>

#import "WeexControllerViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

-(void)click
{
    NSLog(@"HH");
    NSLog(@"High Score Button Pressed");
    
   //NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    
    
    //NSURL *jsCodeLocation = [NSURL URLWithString:@"http://192.168.47.178:8081/index.ios.bundle?platform=ios"];
    
    
    //NSURL *jsCodeLocation  = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"main" fallbackResource:nil];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"app:%@",app);
    
    NSURL *jsCodeLocation = app.jsCodeLocation;
    
    //NSURL *jsCodeLocation  = [CodePush bundleURL];
    
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                moduleName: @"MyRnDemo"
                         initialProperties:nil
                             launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)click2
{
    WeexControllerViewController *weexCtrl = [WeexControllerViewController new];
    
    [self presentViewController:weexCtrl animated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    click.backgroundColor = [UIColor redColor];
    [click addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click];
    
    
    UIButton *click2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
    click2.backgroundColor = [UIColor redColor];
    [click2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click2];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
