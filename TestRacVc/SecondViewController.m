//
//  SecondViewController.m
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import "SecondViewController.h"
#import <React/RCTRootView.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

-(void)click
{
    NSLog(@"HH");
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    click.backgroundColor = [UIColor redColor];
    [click addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
