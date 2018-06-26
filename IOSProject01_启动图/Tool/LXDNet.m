//
//  LXDNet.m
//  LXDHRMS
//
//  Created by Experimental Computer on 2017/11/20.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import "LXDNet.h"

__strong static AFHTTPSessionManager *AFHTTPMgr;
__strong static LXDNet *LXDNetInstance=nil;

@interface LXDNet()
//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;
@end
@implementation LXDNet

+(LXDNet *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LXDNetInstance = [[LXDNet alloc]init];  //初始化实例
          AFHTTPMgr = [AFHTTPSessionManager manager];
//        AFHTTPMgr = [AFHTTPSessionManager manager];
//        //声明请求的数据类型时json类型
     //  AFHTTPMgr.requestSerializer = [AFHTTPRequestSerializer serializer];
     //   AFHTTPMgr.requestSerializer = [AFJSONRequestSerializer serializer];
//        //声明返回的数据类型时json类型
//        AFHTTPMgr.responseSerializer = [AFJSONResponseSerializer serializer];
       // AFHTTPMgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        //超时时间
        AFHTTPMgr.requestSerializer.timeoutInterval = 30;
      
    });
    return LXDNetInstance;
}

-(void)loadbyAccount:(NSString *)account andPassword:(NSString *)password
{
    NSString *urlStr = @"http://114.141.160.98/WebService1.asmx?op=VerifyAccount";
    
   // NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"account"] = account;
//    params[@"password"] = password;
//    params[@"pwd"] = @"222";
//    params[@"username"] = @"test";
    
    NSString *userName = account;
    NSString *pwd = password;
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<VerifyAccount xmlns=\"http://tempuri.org/\">\n"
                             "<username>%@</username>\n"
                             "<pwd>%@</pwd>\n"
                             "</VerifyAccount>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",userName,pwd];
    
 
    [self requestURL:urlStr BySoapMessage:soapMessage];
}

-(void)importData:(NSString *)JsonStr
{
    NSString *urlStr = @"http://114.141.160.98/importDataService.asmx?op=ImportDataToLocal";
    
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<ImportDataToLocal xmlns=\"http://tempuri.org/\">\n"
                             "<strJson>%@</strJson>\n"
                             "</ImportDataToLocal>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",JsonStr];
    
    [self requestURL:urlStr BySoapMessage:soapMessage];
}

-(void)queryData:(NSDictionary *)paramas
{
    NSString *urlStr = @"http://114.141.160.98/ShowDataToAPP.asmx?op=QueryDataToAPP";
    
    NSString *labelNo = paramas[@"labelID"];
    NSString *startTime = paramas[@"beginTime"];
    NSString *endTime  = paramas[@"endTime"];
    NSLog(@"labelID=%@\nbegintime=%@\nendTime=%@",labelNo,startTime,endTime);
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<QueryDataToAPP xmlns=\"http://tempuri.org/\">\n"
                             "<strLableNo>%@</strLableNo>\n"
                             "<strStartDateTime>%@</strStartDateTime>\n"
                             "<strEndDateTime>%@</strEndDateTime>\n"
                             "</QueryDataToAPP>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",labelNo,startTime,endTime];
    
    [self requestURL:urlStr BySoapMessage:soapMessage];
}

-(void)requestURL:(NSString *)URL BySoapMessage:(NSString *)soapMessage
{
    [AFHTTPMgr.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    AFHTTPMgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [AFHTTPMgr.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapMessage;
    }];
    
    // AFNetworking 3.1
    [AFHTTPMgr POST:URL parameters:soapMessage progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功，%@",[responseObject class]);
        [self.Netdelegate getSuccessInfo:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"服务器的错误原因:%@",str);
        [self.Netdelegate getFailInfo:error];
    }];
}
@end
