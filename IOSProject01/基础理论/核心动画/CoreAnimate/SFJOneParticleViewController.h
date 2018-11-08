//
//  SFJOneParticleViewController.h
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/20.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJNavUIBaseViewController.h"

@interface SFJOneParticleViewController : SFJNavUIBaseViewController

@end

@interface ParticleView : UIView
-(void)reDraw;
-(void)startAnimate;

@end

