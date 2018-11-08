//
//  RootTabBarController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/6/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "RootTabBarController.h"
#import "BaseNavitationController.h"
#import "View1Controller.h"
#import "SFJBasicKnowledgeViewController.h"
//小红点
#import <WZLBadgeImport.h>

@interface RootTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
    [self addTabarItems];
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addChildViewControllers
{
    
    BaseNavitationController *nav1 = [[BaseNavitationController alloc]initWithRootViewController:[[SFJBasicKnowledgeViewController alloc]init]];
    
    BaseNavitationController *nav2 = [[BaseNavitationController alloc]initWithRootViewController:[[View1Controller alloc]init]];
    
    BaseNavitationController *nav3 = [[BaseNavitationController alloc]initWithRootViewController:[[UIViewController alloc]init]];
    BaseNavitationController *nav4 = [[BaseNavitationController alloc]initWithRootViewController:[[UIViewController alloc]init]];
    BaseNavitationController *nav5 = [[BaseNavitationController alloc]initWithRootViewController:[[UIViewController alloc]init]];
    
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
}

-(void)addTabarItems
{
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"基础",
                                                 @"TabBarItemImage" : @"tabBar_essence_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"预演",
                                                  @"TabBarItemImage" : @"tabBar_friendTrends_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"实例",
                                                 @"TabBarItemImage" : @"tabBar_new_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_new_click_icon",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"分享",
                                                  @"TabBarItemImage" : @"tabBar_me_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_me_click_icon"
                                                  };
    NSDictionary *fifthTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"更多",
                                                 @"TabBarItemImage" : @"tabbar_discover_highlighted",
                                                 @"TabBarItemSelectedImage" : @"tabbar_discover_highlighted"
                                                 };
    
    NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                            firstTabBarItemsAttributes,
                                                            secondTabBarItemsAttributes,
                                                            thirdTabBarItemsAttributes,
                                                            fourthTabBarItemsAttributes,
                                                            fifthTabBarItemsAttributes,
                                                            
                                                            ];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectImage"]];
      //  obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
        
        //设置红点
        UITabBarItem *tabBarItem = self.tabBar.items[idx];
        switch (idx) {
            case 0:
                 [tabBarItem showBadgeWithStyle:WBadgeStyleNumber value:41 animationType:WBadgeAnimTypeShake];
                break;
             case 1:
                 [tabBarItem showBadgeWithStyle:WBadgeStyleNumber value:22 animationType:WBadgeAnimTypeBreathe];
                break;
                case 2:
                 [tabBarItem showBadgeWithStyle:WBadgeStyleNew value:0 animationType:WBadgeAnimTypeScale];
                break;
                case 3:
                 [tabBarItem showBadgeWithStyle:WBadgeStyleNew value:0 animationType:WBadgeAnimTypeBounce];
                break;
                case 4:
                 [tabBarItem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeBreathe];
                break;
            default:
                break;
        }
        
    }];
    
    self.tabBar.tintColor = [UIColor redColor];  //设置选中的颜色
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}
@end
