//
//  SFJChildBlockViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/3.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJStaticTableViewController.h"


@interface SFJChildBlockViewController : SFJStaticTableViewController
// 1.使用typedef定义Block类型 ， 简化多个 相同参数，返回值的block 的声明
typedef int (^Compare)(int i , int j);


// 声明一个block变量        返回值类型    block名称       参数列表
@property(nonatomic , copy)void (^successBlock)(NSString *str);

@property(nonatomic , copy)NSString * (^failedBlock)(NSString *str1, NSString *str2);


//   block作为函数的参数           block返回值类型 (^)脱字符 block参数列表   
-(void)simpleBlockInFunction:(NSString * (^)(NSString *str , int i))blockName;

-(void)blockUseInOC:(NSString *)normalStr withBlock1:(void(^)(NSString *str1, int i))blockName1 andBlock2:(int(^)(NSArray *arr1 , BOOL status))blockName2;


//2.使用typedef 简化block,声明一个属性，或者带block的方法
@property(nonatomic , copy) Compare type1Block;

-(void)useTypedefBlock:(Compare)type2Block;
@end
