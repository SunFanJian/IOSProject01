//
//  LXDAccount.h
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/10/26.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDAccount : NSObject <NSCoding>

/** string     用户名。*/
@property (nonatomic, copy) NSString *accountName;

/** string     登陆密码。*/
@property (nonatomic, copy) NSString *password;

 
///** 过期时间 */
//@property (nonatomic, strong) NSDate *expires_time;


@end
