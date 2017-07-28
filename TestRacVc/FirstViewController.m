//
//  FirstViewController.m
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.

#import "FirstViewController.h"
#import <ReactiveCocoa.h>
#import <Foundation/Foundation.h>



typedef CGPoint NSPoint;


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    scrolView.contentSize = CGSizeMake(200, 800);
    scrolView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrolView];
    [RACObserve(scrolView, contentOffset) subscribeNext:^(id x) {
        
//        UIScrollView *scrolView = x;
        
        //NSPointFromString(@"{10.0, 20.0}");
        
        //NSPoint p = NSMakePoint(10, 15);
        
        //CGPoint pt =  x;
        
        NSValue *value  = x;
        
        CGPoint pt = [value CGPointValue];
        
        NSLog(@"x:%f y:%f",pt.x,pt.y);
        

        
//        point.x=10;
//        point.y=20;
//        NSLog(@"%f,%f",point.x,point.y);
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"postData" object:nil] subscribeNext:^(NSNotification *notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
    }];
    
    
    [[self.testBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(id x) {
            NSLog(@"test");
            NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"postData" object:dataArray];
        }
     ];

    
    [[self.inputTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
        UITextField *field = x;
        NSLog(@"x:%@",field.text);
        

        
        
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"tap");
    }];
    [self.view addGestureRecognizer:tap];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
//        NSLog(@"%@",tuple.first);
//        NSLog(@"%@",tuple.second);
//        NSLog(@"%@",tuple.third);
//    }];
    
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [alertView show];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
