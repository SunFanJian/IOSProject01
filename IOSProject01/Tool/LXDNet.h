//
//  LXDNet.h
//  LXDHRMS
//
//  Created by Experimental Computer on 2017/11/20.
//  Copyright © 2017年 Luxondata. All rights reserved.
//
//借口类

#import <Foundation/Foundation.h>
//#import <AFNetworking.h>

//代理
@protocol LXDNetDelegate <NSObject>
@optional
-(void)getSuccessInfo:(id)loginBackInfo;
@optional
-(void)getFailInfo:(id)loginBackInfo;

@end

@interface LXDNet : NSObject

@property(nonatomic , weak) id<LXDNetDelegate> Netdelegate;

/** 获取类的单例
 *
 * @return LXDNet类的单例 -实例（对象）
 */
+(LXDNet *)getInstance;

/**  登陆
 *
 * @param account   用户名
 * @param password  密码
 */
-(void)loadbyAccount:(NSString *)account andPassword:(NSString *)password;

/**  上传数据　
 *
 * @param JsonStr   Json字符串
 */
-(void)importData:(NSString *)JsonStr;

/**  查询数据
 *
 * @param paramas    查询参数
 */
-(void)queryData:(NSDictionary *)paramas;
@end
