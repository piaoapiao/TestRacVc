//
//  WeexControllerViewController.h
//  TestRacVc
//
//  Created by guodong on 2017/8/30.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WeexSDK/WXSDKInstance.h>

@interface WeexControllerViewController : UIViewController
@property (nonatomic,strong) WXSDKInstance *instance;
@property (nonatomic,strong) NSURL *url;
@property(nonatomic, strong)UIView *weexView;
@end
