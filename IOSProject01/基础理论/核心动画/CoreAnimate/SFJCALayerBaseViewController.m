//
//  SFJCALayerBaseViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/9/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJCALayerBaseViewController.h"

@interface SFJCALayerBaseViewController ()

@end

@implementation SFJCALayerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置layer属性
    // 阴影
    self.redView.layer.shadowOpacity = 0.6;         // 不透明度
    self.redView.layer.shadowOffset = CGSizeMake(3, 3);
    self.redView.layer.shadowColor = [UIColor RandomColor].CGColor;
    self.redView.layer.shadowRadius = 10;
    
    //圆角半径
    self.redView.layer.cornerRadius = 50;
    //边框
    self.redView.layer.borderWidth = 2;
    self.redView.layer.borderColor = [UIColor RandomColor].CGColor;;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*      CATransform3DMakeRotation
    angle参数是旋转的角度 ，x，y，z决定了旋转围绕的中轴，取值为-1 — 1之间，如（1，0，0）,则是绕x轴旋转，（0.5，0.5，0），则是绕x轴与y轴中间45度为轴旋转
     */
    // 动画
    [UIView animateWithDuration:1 animations:^{
        //旋转    CATransform3D主要作用于Layer，为3D变换使用     矩阵变换
        CATransform3D transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
        // 叠加
        self.redView.layer.transform = CATransform3DScale(transform, 0.5, 0.5, 1);
        
        // 快速进行图层缩放,KVC
        // x,y同时缩放0.5
        // [self.redView.layer setValue:@0.5 forKeyPath:@"transform.scale"];
        // [self.redView.layer setValue:@(M_PI) forKeyPath:@"transform.rotation"];
        
    } completion:^(BOOL finished) {
        self.redView.layer.transform = CATransform3DIdentity;   //恢复至 最初
    }];
}

/* CATransform3D 图形3d变换
 平移   -  CATransform3DMakeTranslation   参数 - tx、ty、tz   平移距离
 缩放   -  CATransform3DMakeScale         参数 - sx、sy、sz   缩放比例
 旋转   -  CATransform3DMakeRotation      参数 - angle、x、y、z    angle参数是旋转的角度 ，x，y，z决定了旋转围绕的中轴
 恢复原状 - CATransform3DIdentity
        在上面变换的基础上再次变化
 CATransform3DTranslate   -   平移    参数同上
 CATransform3DScale   -   缩放
 CATransform3DRotate   -   旋转
 CATransform3DInvert - 反向变化  参数 - CATransform3D
 */
@end
