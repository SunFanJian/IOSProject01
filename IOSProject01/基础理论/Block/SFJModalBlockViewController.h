//
//  SFJModalBlockViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJStaticTableViewController.h"

@interface SFJModalBlockViewController : SFJStaticTableViewController

@property(nonatomic , copy)void (^successBlock)(NSString *str);

-(void)subViewDoSomething;
@end
