//
//  SFJStaticTableViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJTableViewController.h"

#import "SFJTableItem.h"
#import "SFJTableSection.h"
#import "SFJTableArrowItem.h"

//自定义tableview 继承自这个基类, 设置组模型就行了,
@interface SFJStaticTableViewController : SFJTableViewController
//分组模型
@property (nonatomic , strong) NSMutableArray<SFJTableSection *> *sections;
// 自定义某一行cell的时候调用super, 返回为空
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(SFJStaticTableViewController *(^)(SFJTableItem *item))addItem;
@end

UIKIT_EXTERN const UIEdgeInsets tableViewDefaultSeparatorInset;
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultLayoutMargins;
