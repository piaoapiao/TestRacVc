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
    
    [self concat];
    
    
    [self  then];
    
    [self  merge];
    
    [self  zipWith];
    
    [self map];
    
    [self  skipSignal];
    
    [self  testExecuting];
    
    [self testHighCommand];
    
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
    
    
    [self.testBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    
//    [[self.testBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
//        subscribeNext:^(id x) {
//            NSLog(@"test");
//            NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"postData" object:dataArray];
//        }
//     ];

    
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
    
    
    [self signalCombineTest];
    
    
    [self testrrr];
    
    
    [self  testRac];
    
    [self  testConnect];
    
    
    [self  testCommand];
    
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


- (void)signalCombineTest{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *combined = [RACSignal combineLatest:@[letters,numbers] reduce:^id(NSString *letter,NSString *number){
        return [letter stringByAppendingString:number];
    }];
    // Outputs: B1 B2 C2 C3 D3 D4
    [combined subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"3"];
    [letters sendNext:@"D"];
    [numbers sendNext:@"4"];
    
    /**
     | letter |-  A  -  B  -  -   -   C  -    -   D
     | number |-  -  -   1  -  2   -   3   -   -    4
     | new   |-  -  -  -  B1 -  B2 C2 C3 -  D3 D4
     -------------- time ----------------------->
     可以发现letter信号的A值被更新的B值覆盖了,所以接下来接收到number信号的1时候,合并,输出信号B1.
     当接收到C的时候,与number的最新的值2合并,输出信号C2.
     */
}


-(void)testrrr
{
   RACSignal *sign =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"hello world");
        [subscriber sendNext:@"sender"];
        [subscriber sendCompleted];
        return nil;
    }];
    
   // [sign subscribeNext:nil];
    [sign subscribeNext:^(id x) {
        NSLog(@"hello2");
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testRac
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // didSubscribeblock中的代码都统称为副作用。
        // 发送请求---比如afn
        NSLog(@"发送请求啦");
        // 发送信号
        [subscriber sendNext:@"ws"];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}



-(void)testConnect
{
    // 比较好的做法。 使用RACMulticastConnection，无论有多少个订阅者，无论订阅多少次，我只发送一个。
    // 1.发送请求，用一个信号内包装，不管有多少个订阅者，只想发一次请求
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        NSLog(@"发送请求啦");
        // 发送信号
        [subscriber sendNext:@"ws"];
        return nil;
    }];
    //2. 创建连接类
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [connection.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    //3. 连接。只有连接了才会把信号源变为热信号
    [connection connect];
}

-(void)testCommand
{
    // 普通做法
    // RACCommand: 处理事件
    // 不能返回空的信号
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //block调用，执行命令的时候就会调用
        NSLog(@"%@",input); // input 为执行命令传进来的参数
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            return nil;
        }];
    }];
    
    // 如何拿到执行命令中产生的数据呢？
    // 订阅命令内部的信号
    // ** 方式一：直接订阅执行命令返回的信号
    
    // 2.执行命令
    RACSignal *signal =[command execute:@2]; // 这里其实用到的是replaySubject 可以先发送命令再订阅
    // 在这里就可以订阅信号了
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}


-(void)testHighCommand
{
    // 高级做法
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令的时候就会调用
        NSLog(@"%@", input);
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"发送信号"];
            return nil;
        }];
    }];
    
    // 方式三
    // switchToLatest获取最新发送的信号，只能用于信号中信号。
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 2.执行命令
    [command execute:@3];
}


-(void)testExecuting
{
    // 监听事件有没有完成
    //注意：当前命令内部发送数据完成，一定要主动发送完成
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令的时候就会调用
        NSLog(@"%@", input);
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            
            // *** 发送完成 **
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    // 监听事件有没有完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) { // 正在执行
            NSLog(@"当前正在执行%@", x);
        }else {
            // 执行完成/没有执行
            NSLog(@"执行完成/没有执行");
        }
    }];
    
    // 2.执行命令
    [command execute:@1];
}

-(void)skipSignal
{
    // 跳跃 ： 如下，skip传入2 跳过前面两个值
    // 实际用处： 在实际开发中比如 后台返回的数据前面几个没用，我们想跳跃过去，便可以用skip
    RACSubject *subject = [RACSubject subject];
    [[subject skip:1] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
}


- (void)map {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 绑定信号
    RACSignal *bindSignal = [subject map:^id(id value) {
        
        // 返回的类型就是你需要映射的值
        return [NSString stringWithFormat:@"ws:%@", value]; //这里将源信号发送的“123” 前面拼接了ws：
    }];
    // 订阅绑定信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [subject sendNext:@"123"];
    
    [subject sendNext:@"1235"];
}

-(void)zipWith {
    //zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元祖，才会触发压缩流的next事件。
    // 创建信号A
    RACSubject *signalA = [RACSubject subject];
    // 创建信号B
    RACSubject *signalB = [RACSubject subject];
    // 压缩成一个信号
    // **-zipWith-**: 当一个界面多个请求的时候，要等所有请求完成才更新UI
    // 等所有信号都发送内容的时候才会调用
    RACSignal *zipSignal = [signalA zipWith:signalB];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@", x); //所有的值都被包装成了元组
    }];
    
    // 发送信号 交互顺序，元组内元素的顺序不会变，跟发送的顺序无关，而是跟压缩的顺序有关[signalA zipWith:signalB]---先是A后是B
    [signalA sendNext:@1];
    [signalB sendNext:@2];
    
}


// 任何一个信号请求完成都会被订阅到
// merge:多个信号合并成一个信号，任何一个信号有新值就会调用
- (void)merge {
    // 创建信号A
    RACSubject *signalA = [RACSubject subject];
    // 创建信号B
    RACSubject *signalB = [RACSubject subject];
    //组合信号
    RACSignal *mergeSignal = [signalA merge:signalB];
    // 订阅信号
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号---交换位置则数据结果顺序也会交换
    [signalB sendNext:@"下部分"];
    [signalA sendNext:@"上部分"];
}

// then --- 使用需求：有两部分数据：想让上部分先进行网络请求但是过滤掉数据，然后进行下部分的，拿到下部分数据
- (void)then {
    // 创建信号A
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        NSLog(@"----发送上部分请求---afn");
        
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted]; // 必须要调用sendCompleted方法！
        return nil;
    }];
    
    // 创建信号B，
    RACSignal *signalsB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        NSLog(@"--发送下部分请求--afn");
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    // 创建组合信号
    // then;忽略掉第一个信号的所有值
    RACSignal *thenSignal = [signalA then:^RACSignal *{
        // 返回的信号就是要组合的信号
        return signalsB;
    }];
    
    // 订阅信号
    [thenSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}

- (void)concat {
    // 组合
    
    // 创建信号A
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        //        NSLog(@"----发送上部分请求---afn");
        
        [subscriber sendNext:@"上部分数据"];
        [subscriber sendCompleted]; // 必须要调用sendCompleted方法！
        return nil;
    }];
    
    // 创建信号B，
    RACSignal *signalsB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求
        //        NSLog(@"--发送下部分请求--afn");
        [subscriber sendNext:@"下部分数据"];
        return nil;
    }];
    
    
    // concat:按顺序去链接
    //**-注意-**：concat，第一个信号必须要调用sendCompleted
    // 创建组合信号
    RACSignal *concatSignal = [signalA concat:signalsB];
    // 订阅组合信号
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}
@end
