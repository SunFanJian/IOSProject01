//
//  LXDAccountTool.m
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/10/26.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import "LXDAccountTool.h"
//存储路径
#define LXDAccountFilePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.data"]

@implementation LXDAccountTool

+(void)saveAccount:(LXDAccount *)account
{
    //存储文件 归档
    //要实现该方法，必须使模型account 实现NSCoding协议中的存储方法
    [NSKeyedArchiver archiveRootObject:account toFile:LXDAccountFilePath];
     NSLog(@"保存成功%@----%@",account.accountName,account.password);
    //多账号，考虑使用数组
//    NSMutableArray *accountArray=[NSMutableArray array];
//    [accountArray arrayByAddingObject:account];
//    [NSKeyedArchiver archiveRootObject:accountArray toFile:LXDAccountFilePath];
}

+(LXDAccount *)getAccount
{
    //解档
   LXDAccount *account= [NSKeyedUnarchiver unarchiveObjectWithFile:LXDAccountFilePath];
    NSLog(@"取出账号%@----%@",account.accountName,account.password);
//    //判断账号是否过期
//    NSDate *now=[NSDate date];
//   if( [now compare:account.expires_time]!=NSOrderedAscending)
//   {
//       account=nil;
//   }
    //判断账号是否正确
    
    return account;
    
    /**
     NSOrderedAscending = -1L,  升序，越往右边越大
     NSOrderedSame, 相等，一样
     NSOrderedDescending 降序，越往右边越小
     */
}

+(void)removeAccount
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    [fileManage removeItemAtPath:LXDAccountFilePath error:nil];
    NSLog(@"--删除成功");
}
@end

