//
//  FirstViewController.m
//  TestRacVc
//
//  Created by guodong on 2017/7/10.
//  Copyright © 2017年 maizi. All rights reserved.

#import "FirstViewController.h"
#import <ReactiveCocoa.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>



typedef CGPoint NSPoint;


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 200, 400)];
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
    
    
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者1%@", x);
    }];
    
    [subject sendNext:@"subject1"];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者2%@", x);
    }];
    
    [subject sendNext:@"subject2"];
    

    [self racSubjectTest];
    
    [self RACReplaySubject];
    
    [self RACSequenceTest];
    
    
    [self coolSignal];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)racSubjectTest
{
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"1 %@",x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"2 %@",x);
    }];
    
    [subject sendNext:@1];
    [subject subscribeNext:^(id x) {
        NSLog(@"3 %@",x);
    }];
}


//http://www.jianshu.com/p/377fd1b4c23f
-(void)RACReplaySubject
{
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"1 %@,type:%@",x,NSStringFromClass(object_getClass(x)));
    }];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"1 %@,type:%@",x,NSStringFromClass(object_getClass(x)));
    }];
    [replaySubject sendNext:@155];
    
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"3 %@,type:%@",x,NSStringFromClass(object_getClass(x)));
    }];
}


-(void)RACSequenceTest
{
    NSArray *arr = @[@1,@2,@3,@4,@5,@6];
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        
        NSLog(@"x:%@",x);
    }];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"jtd",@"name",@"man",@"sex",@"jx",@"jg", nil];
    [dict.rac_sequence.signal subscribeNext:^(id x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        NSLog(@"key:%@,value:%@",key,value);
    }];
    
    NSDictionary *dict1 = @{@"key1":@"value1",@"key2":@"value2"};
    NSDictionary *dict2 = @{@"key1":@"value1",@"key2":@"value2"};
    NSArray *dictArr = @[dict1,dict2];
    [dictArr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"x:%@,type:%@",x,NSStringFromClass(object_getClass(x)));
    }];
}


//http://blog.csdn.net/whuamanlou/article/details/50700072
-(void)coolSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"send");
        [subscriber sendNext:@"sender"];
        [subscriber sendCompleted];
        return nil;
    }];
    NSLog(@"start");
    [[RACScheduler mainThreadScheduler] afterDelay:0.5 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 1 recveive: %@", x);
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 recveive: %@", x);
        }];
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
