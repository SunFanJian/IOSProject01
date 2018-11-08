//
//  SFJNavUIBaseViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavitationController.h"
#import "SFJNavigationBar.h"

@class SFJNavUIBaseViewController;
@protocol SFJNavUIBaseViewControllerDataSource <NSObject>

@optional
/** 是否添加自定义导航栏 */
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(SFJNavUIBaseViewController *)navUIBaseViewController;
@end

@interface SFJNavUIBaseViewController : UIViewController<SFJNavigationBarDelegate,SFJNavigationBarDataSource,SFJNavUIBaseViewControllerDataSource>

/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;
/**  导航栏 */
@property (weak, nonatomic) SFJNavigationBar *sfj_navgationBar;

@end
