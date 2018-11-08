//
//  DynamicBaseView.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/21.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicBaseView : UIView


/**  方块视图  */
@property (nonatomic, weak) UIImageView *boxView;

/**  仿真者  */
@property (nonatomic, strong) UIDynamicAnimator *animator;


@end
