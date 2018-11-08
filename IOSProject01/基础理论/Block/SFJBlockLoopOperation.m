//
//  SFJBlockLoopOperation.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJBlockLoopOperation.h"

@implementation SFJBlockLoopOperation

+(void)operateWithSuccessBlock:(void (^)(NSString *str))successBlock
{
    if (successBlock) {
        NSString *str = @"子页面的值";
        successBlock(str);
    }
}

-(void)setLogAddress:(void (^)(NSString *))logAddress
{
    _logAddress = logAddress;
    
    !_logAddress ? : _logAddress(_address);
}

- (void)dealloc {
    NSLog(@"dealloc- %@", self.class);
}

-(void)useBlockForOC:(int (^)(NSString *, int))oneBlock
{
    
}
@end
