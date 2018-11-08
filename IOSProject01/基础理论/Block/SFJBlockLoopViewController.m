//
//  SFJBlockLoopViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/3.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJBlockLoopViewController.h"
#import "SFJChildBlockViewController.h"
#import "SFJModalBlockViewController.h"
#import "SFJBlockLoopOperation.h"

@interface SFJBlockLoopViewController ()
@property(nonatomic , strong)UIView *myBlockView;

@property(nonatomic , strong)UILabel *label1;

//测试用的全局字符串变量
@property(nonatomic , strong)NSString * globalStr;
@end

@implementation SFJBlockLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.globalStr = @"这是一个全局变量";
    
    _myBlockView = [UIView new];
    _myBlockView.height = 80;
    _myBlockView.backgroundColor = [UIColor RandomColor];
    self.tableview.tableHeaderView = _myBlockView;
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 40)];
    _label1.text = @"未跳转过";
    _label1.textColor = [UIColor whiteColor];
    [_myBlockView addSubview:_label1];
    
    LMJWeak(self);
    
    [_myBlockView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        [weakself.view makeToast:@"点击了TableviewHeader"];
    }];
    
    self.addItem([SFJTableArrowItem itemWithTitle:@"跳转子页面" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself myButtonAction];
    }])
    .addItem([SFJTableArrowItem itemWithTitle:@"弹出模态窗口" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself myModalButtonAction];
    }])
    .addItem([SFJTableArrowItem itemWithTitle:@"响应BlockLoopOperation中的block" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        
        [self myBlockButtonAction];
    }]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)myButtonAction
{
    SFJChildBlockViewController *vc=[[SFJChildBlockViewController alloc]init];
  
    // 子页面的 block push
    vc.successBlock=^(NSString *str)   //赋值 -- 接受子页面的传值
    {
        [self loadPage:str];
    };

    //子页面带block参数的方法
   // NSString *string = @"block外的局部变量";
   __block NSString *string = @"block外的局部变量";   //为了使局部变量在block中能够访问修改，用__block修饰
    NSLog(@"1.%@",string);
    
    [vc simpleBlockInFunction:^NSString *(NSString *str, int i) {
        
        NSLog(@"2.block中可以访问局部变量 ：%@ ; 以及全局变量：%@",string , self.globalStr);
        
        string = [NSString stringWithFormat:@"用__block修饰的变量可以在block中修改：%@--%d",str,i];
        NSLog(@"3.%@",string);
        
        return string;   //因为block参数返回值时string类型，所以这里需要返回一个string
    }];
   
    [vc useTypedefBlock:^int(int i, int j) {
        int num = i + j;
        NSLog(@"%d", num);
        return num;
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)myModalButtonAction
{
    SFJModalBlockViewController *vc = [[SFJModalBlockViewController alloc]init];
    /*
    3. 在并发执行的时候，block的执行是可以抢占的，而且对weakSelf指针的调用时序不同可以导致不同的结果，比如在一个特定的时序下weakSelf可能会变成nil，这个时候在执行doAnotherThing就会造成程序的崩溃。为了避免出现这样的问题，采用__strong的方式来进行避免，
     */
    LMJWeak(vc);
    vc.successBlock = ^(NSString *str) {
        if (weakvc) {
            [weakvc dismissViewControllerAnimated:YES completion:nil];
            [weakvc subViewDoSomething];
            NSLog(@"%@",str);
            
//            __strong typeof(weakvc) strongVC = weakvc;
//            [strongVC subViewDoSomething];
//            [strongVC subViewDoAnotherthing];
        }
    };
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)myBlockButtonAction
{
    SFJBlockLoopOperation *operation = [[SFJBlockLoopOperation alloc]init];
    operation.address = @"父页面传的值";
    LMJWeak(operation);
    operation.logAddress = ^(NSString *address) {
        [self showErrorMessage:address];
        NSLog(@"%@",weakoperation.address);//2.这里block是一个property，当用到这个对象时，必须使用weak弱化operation对象，否则会出现内存释放的问题。      避免循环引用
    };
    
    [SFJBlockLoopOperation operateWithSuccessBlock:^(NSString *str) {
        [self showErrorMessage:str];
         NSLog(@"%@",operation.address);  //1.当block不是作为一个property时，可以直接使用对象实例
    }];
}


-(void)loadPage:(NSString *)str
{
    NSLog(@"来自子页面的传值--%@",str);
    _label1.text = [NSString stringWithFormat:@"子页面传的值：%@",str];
}

-(void)showErrorMessage:(NSString *)message
{
    NSLog(@"当前信息,%@",message);
}



/** 导航条左边的按钮 */
-(UIImage *)sfjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(SFJNavigationBar *)navigationBar
{
    return [UIImage imageNamed:@"NavgationBar_blue_back"];  //设置一般状态的图片
    
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(SFJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
