//
//  SFJXMLParser.h
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/9.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SFJXMLPARSER

@optional
-(void)returnBackResult:(NSString *)resultStr;

@end

@interface SFJXMLParser : NSObject<NSXMLParserDelegate>

//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;
//要找到的XML文件内容
@property (nonatomic, copy) NSString *targetElement;

@property (nonatomic , weak) id<SFJXMLPARSER> SFJXMLdelegate;   //代理

/** 获取类的单例
 *
 * @return SFJXMLParser类的单例 -实例（对象）
 */
+(SFJXMLParser *)getInstance;

-(void)startParser:(id)requestBackInfo withElement:(NSString *)element;
@end
