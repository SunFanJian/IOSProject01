//
//  SFJXMLParser.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/9.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJXMLParser.h"

__strong static SFJXMLParser *SFJXMLInstance=nil;

@implementation SFJXMLParser

@synthesize currentElement;

+(SFJXMLParser*)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SFJXMLInstance = [[SFJXMLParser alloc]init];
    });
    return  SFJXMLInstance;
}

-(void)startParser:(id)requestBackInfo withElement:(NSString *)element
{
    //初始化解析器
    NSXMLParser * parser = requestBackInfo;
    //设置代理
    parser.delegate=self;
    
    self.targetElement = element;
    //開始解析
    [parser parse];
}

#pragma 解析登录请求结果
//准备节点
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"开始准备节点");
    self.currentElement = elementName;
    
}
//获取节点内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"获取节点内容");
    if([self.targetElement isEqualToString:self.currentElement]){
        //self.logResult = [string intValue];
        [self.SFJXMLdelegate returnBackResult:string];
    }
    
}
//解析结束
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"解析结束");

}
@end
