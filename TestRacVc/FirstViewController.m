//
//  FirstViewController.m
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import "FirstViewController.h"
#import <ReactiveCocoa.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.testBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(id x) {
            NSLog(@"test");
        }
     ];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
