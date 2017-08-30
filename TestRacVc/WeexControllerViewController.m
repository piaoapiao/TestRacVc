//
//  WeexControllerViewController.m
//  TestRacVc
//
//  Created by guodong on 2017/8/30.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import "WeexControllerViewController.h"


@interface WeexControllerViewController ()

@end

@implementation WeexControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Hello Weex";
    
    self.instance = [[WXSDKInstance alloc] init];
    
    // 设置weexInstance所在的控制器
    
    self.instance.viewController = self;
    
    // 设置weexInstance的frame
    
    self.instance.frame = self.view.frame;
    
    // 设置weexInstance用于渲染JS的url路径
    
    //[self.instance renderWithURL:self.url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
    
   // self.url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"app" ofType:@"js"]];  //不支持本地加载
    
    //self.url = [NSURL URLWithString:@"http://oneccc.bid/app.js"];
    
    NSLog(@"url :%@",[[NSBundle mainBundle] pathForResource:@"app" ofType:@"js"]);
    
    
    NSString *path=[NSString stringWithFormat:@"file://%@/%@",[NSBundle mainBundle].bundlePath,@"app.js"];
    
    NSLog(@"-----path:%@",path);
    
    self.url = [NSURL URLWithString:path];
    
    
  //  [self.instance renderWithURL:self.url options:nil data:nil];
    
    
    [self.instance renderWithURL:self.url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
    
    // 为避免循环引用 声明一个弱指针 self
    
    __weak typeof(self) weakSelf = self;
    
    // 设置weexInstance创建完的回调
    
    self.instance.onCreate = ^(UIView *view) {
        
        [weakSelf.weexView removeFromSuperview];
        
        weakSelf.weexView = view;
        
        weakSelf.weexView.backgroundColor = [UIColor whiteColor];
        
        [weakSelf.view addSubview:weakSelf.weexView];
        
        //weakSelf.weexView = view;
        
        //view.backgroundColor = [UIColor greenColor];
        
        [weakSelf.view addSubview:view];
        
    };
    
    // 设置weexInstance出错时的回调
    
    self.instance.onFailed = ^( NSError *error) {
        
        NSLog(@"处理失败%@", error);
        NSLog(@"处理失败%@", error);
        
    };
    
    // 设置weexInstance渲染完成时的回调
    
    self.instance.renderFinish = ^(UIView *view) {
        
        NSLog(@"渲染完成");
        
    };
}

- (void)dealloc {
    
    [_instance destroyInstance];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
