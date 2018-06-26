//
//  LXDAccountTool.h
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/10/26.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXDAccount.h"
@interface LXDAccountTool : NSObject
/**
 *存储账号
 */
+(void)saveAccount:(LXDAccount *)account;

/**
 *读取账号
 */
+(LXDAccount *)getAccount;

/**
 *删除账号
 */
+(void)removeAccount;
@end
