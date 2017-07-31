//
//  FirstViewController.h
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMode.h"

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *testBtn;


@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (strong, nonatomic) MyMode *mynode;

@property (strong,nonatomic) NSString *name;
@end

