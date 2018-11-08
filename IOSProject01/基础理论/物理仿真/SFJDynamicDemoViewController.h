//
//  SFJDynamicDemoViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/21.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJNavUIBaseViewController.h"

typedef enum {
    DynamicTypeSnap = 0 ,
    DynamicTypePush ,
    DynamicTypeAttachment,
    DynamicTypeSpring,
    DynamicTypeCollision
} DynamicType;

@interface SFJDynamicDemoViewController : SFJNavUIBaseViewController
@property(nonatomic , assign)DynamicType type;
@end
