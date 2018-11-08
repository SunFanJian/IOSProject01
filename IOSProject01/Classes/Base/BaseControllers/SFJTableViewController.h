//
//  SFJTableViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJNavUIBaseViewController.h"

@interface SFJTableViewController : SFJNavUIBaseViewController<UITableViewDelegate,UITableViewDataSource>
// 这个代理方法如果子类实现了, 必须调用super
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;

@property(nonatomic , weak)UITableView *tableview;

-(instancetype)initWithStyle:(UITableViewStyle)style;

@end
