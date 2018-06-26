////
////  LXDAccount.m
////  LDWeiBo01
////
////  Created by Experimental Computer on 2017/10/26.
////  Copyright © 2017年 Luxondata. All rights reserved.
//账号模型

#import "LXDAccount.h"

@implementation LXDAccount

//+(instancetype)accountWithDict:(NSDictionary *)dict
//{
//    LXDAccount *account=[[LXDAccount alloc]init];
//    account.access_token=dict[@"access_token"];
//    account.expires_in=dict[@"expires_in"];
//   // account.expires_time=dict[@""];
//    account.uid=dict[@"uid"];
//    
//    //确定账号过期时间 登陆时间+有效期
//    NSDate *now=[NSDate date];
//    account.expires_time=[now dateByAddingTimeInterval:account.expires_in.doubleValue];
//    return  account;
//}
//
#pragma 读写数据时 必须实现该方法
//当从文件中解析出一个对象的时候调用
//在这个方法中写 怎么解析文件中的数据
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        self.accountName=[aDecoder decodeObjectForKey:@"accountName"];
        self.password=[aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

//将对象写入文件时调用
//在这个方法中写 要存储哪些对象的那些属性，以及怎样存储属性
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
    [aCoder encodeObject:self.password forKey:@"password"];
}
@end

