//
//  LoginController.h
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/3.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXDNet.h"
#import "LXDAccount.h"
#import "LXDAccountTool.h"
#import "SFJXMLParser.h"

@interface LoginController : UIViewController<LXDNetDelegate,SFJXMLPARSER>
@property(strong ,nonatomic)LXDNet *loginNet;
@property(strong ,nonatomic)SFJXMLParser *sfjParser;
@end
