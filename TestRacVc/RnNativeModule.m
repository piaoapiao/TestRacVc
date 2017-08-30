//
//  RnNativeModule.m
//  TestRacVc
//
//  Created by guodong on 2017/8/30.
//  Copyright © 2017年 maizi. All rights reserved.
//

#import "RnNativeModule.h"


@implementation RnNativeModule

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(show:(NSString *)name )
{
 //   RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
    
   // [[NSThread mainThread] performSelector:@selector(realShow:) withObject:self withObject:name];
    
    [self performSelectorOnMainThread:@selector(realShow:) withObject:name waitUntilDone:YES];

}

-(void)realShow:(NSString *)name
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:name message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
    NSLog(@"teste");
}

@end
