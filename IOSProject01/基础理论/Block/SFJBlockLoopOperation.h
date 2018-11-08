//
//  SFJBlockLoopOperation.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFJBlockLoopOperation : NSObject

+(void)operateWithSuccessBlock: (void (^)(NSString *str))successBlock;

@property(nonatomic , copy) NSString *address;

@property(nonatomic , copy) void (^logAddress)(NSString *address);

-(void)useBlockForOC:(int (^)(NSString *str1,int i))oneBlock;
@end
