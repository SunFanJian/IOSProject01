//
//  SFJNSThreadViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//
/*
 NSThread
 
 每个NSThread对象对应一个线程，真正最原始的线程。
 1）优点：NSThread 轻量级最低，面向对象，使用相对简单。
 2）缺点：手动管理所有的线程活动，如生命周期、线程同步、睡眠等。
 */

#import "SFJNSThreadViewController.h"

@interface SFJNSThreadViewController ()

@property (nonatomic, strong) NSThread *myThread;

@property (nonatomic, strong) NSMutableArray *myThreadList;

@end

@implementation SFJNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWeak(self);
    
    self.addItem([SFJTableItem itemWithTitle:@"简单创建一个多线程" subTitle:@"NSThread alloc init" itemOperation:^(NSIndexPath *indexPath) {
        [weakself addThreadAction];
    }])
    .addItem([SFJTableItem itemWithTitle:@"测试增加一定数量对CPU的影响" subTitle:@"在子线程中创建多个线程 不影响主线程" itemOperation:^(NSIndexPath *indexPath) {
        [weakself addMutableThread];
    }])
    .addItem([SFJTableItem itemWithTitle:@"退出" subTitle:@"[NSThread exit]" itemOperation:^(NSIndexPath *indexPath) {
        [weakself ExitThread];
    }])
    .addItem([SFJTableItem itemWithTitle:@"用一个数组存储多条线程" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself addArrayThtead];
    }]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//一：简单创建一个多线程
-(void)addThreadAction
{
    // 动态创建创建   -- object 是传递给 执行任务 的参数
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(runAction:) object:nil];
    thread.name = @"custom -- 1";
    //thread.threadPriority = 1;// 设置线程的优先级(0.0 - 1.0，1.0最高级)
    [thread start];   //需要手动开启
    
    //静态创建线程  -- 创建完会自动启动
   // [NSThread detachNewThreadSelector:@selector(runAction:) toTarget:self withObject:nil];
    
    //隐式创建线程 -- 创建完会自动启动
   // [self performSelectorInBackground:@selector(runAction:) withObject:nil];
    
    /**********************  线程之间通信  ********************/
    /*
    //在主线程上执行操作
    [self performSelectorOnMainThread:@selector(runAction:) withObject:nil waitUntilDone:YES];
    
    //在当前线程上执行操作
    [self performSelector:@selector(runAction:) withObject:nil];
    
    //在指定线程上执行操作
    [self performSelector:@selector(runAction:) onThread:thread withObject:nil waitUntilDone:YES];
     */
}

- (void)runAction:(id)obj
{
    NSLog(@"当前执行的线程为：%@", [NSThread currentThread]);  //获取当前线程
    // 如果number=1，则表示在主线程，否则是子线程
    //打印结果：{number = 1, name = main}
    
    /******************** NSThread的一些类方法  *********************/
    /*
     [NSThread mainThread];    //获取主线程
    
     [NSThread sleepForTimeInterval:2];  //暂停当前线程 ， 2秒之后 继续执行
    
     [NSThread sleepUntilDate:[NSDate date]];   //休眠到指定时间
     
     [NSThread exit];       //退出线程
     
     [NSThread isMainThread];   //判断当前线程是否为主线程
     
     [NSThread isMultiThreaded];    //判断当前线程是否是多线程
     
     */
    
    /**********************   NSThread的一些属性   ***************/
    /*
    
     thread.isExecuting;    //线程是否在执行
     
     thread.isCancelled;    //线程是否被取消
    
     thread.isFinished;     //线程是否完成
     
     thread.isMainThread;   //是否是主线程
     
     thread.threadPriority; //线程的优先级，取值范围0.0到1.0，默认优先级0.5，1.0表示最高优先级，优先级高，CPU调度的频率高
     
     */
}

//二：测试增加一定数量对CPU的影响
-(void)addMutableThread
{
    //把创建子线程的操作放在一个子线程中进行 不影响主线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(runMutableThreadAction) object:nil];
    
    thread.name = @"thread-mutable";
    [thread start];
}

-(void)runMutableThreadAction
{
    for (int num = 0; num < 100; num++) {
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(runMutableAction:) object:[NSString stringWithFormat:@"%d",num]];
        thread.name = @"thread-thread";
        [thread start];
    }
}

-(void)runMutableAction:(NSString *)num
{
     NSLog(@"当前线程为%@：%@",num , [NSThread currentThread]);
}

//三：强制退出线程
-(void)ExitThread
{
    _myThread = nil;
    if (!self.myThread) {
        self.myThread = [[NSThread alloc]initWithTarget:self selector:@selector(runExitAction) object:nil];
        self.myThread.name = @"thread-exit";
    }
    [self.myThread start];
}

-(void)runExitAction
{
    NSLog(@"当前线程为%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];  //阻塞（暂停）3秒后执行再下面内容
    [[NSThread currentThread] cancel];
    
    if ([[NSThread currentThread] isCancelled]) {
        NSLog(@"当前thread-exit被exit动作了");
        [NSThread exit];    //退出线程
    }
    NSLog(@"当前thread-exit线程为：%@",[NSThread currentThread]);
}

//四：用一个数组存储多条线程
-(void)addArrayThtead
{
    if (!self.myThreadList) {
        self.myThreadList = [[NSMutableArray alloc]init];
    }
    
    [self.myThreadList removeAllObjects];
    
    for (int i = 0; i < 10; i++) {
        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadAction:) object:[NSNumber numberWithInt:i]];
        thread.name = [NSString stringWithFormat:@"myThread%i",i];
        [self.myThreadList addObject:thread];
    }
    
    for (int i = 0; i < self.myThreadList.count; i++) {
        NSThread *thread = self.myThreadList[i];
        [thread start];
    }
}

-(void)loadAction:(NSNumber *)index
{
    NSThread *thread=[NSThread currentThread];
    NSLog(@"loadAction是在线程%@中执行",thread.name);
    
    //在主线程中 操作
    [self performSelectorOnMainThread:@selector(updateImage) withObject:nil waitUntilDone:YES];
    
    //回主线程去执行  有些UI相应 必须在主线程中更新
    //    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    //    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    //    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
}

-(void)updateImage
{
    NSLog(@"执行完成了");
    NSLog(@"执行方法updateImage是在===%@线程中",[NSThread isMainThread] ? @"主" : @"子");
}

- (void)dealloc {
    
    //退出页面时就把线程标识为cancel
    if (![self.myThread isCancelled]) {
        NSLog(@"当前thread-exit线程被cancel");
        [self.myThread cancel];
        NSLog(@"当前thread-exit线程被cancel的状态 %@",[self.myThread isCancelled]?@"被标识为Cancel":@"没有被标识");
    }
    
    //结合VC生命周期退出页面时就把线程标识为cancel 使用Thread一定要在退出前进行退出，否则会有闪存泄露的问题
    for (int i=0; i<self.myThreadList.count; i++){
        NSThread *thread=self.myThreadList[i];
        if (![thread isCancelled]) {
            NSLog(@"当前thread-exit线程被cancel");
            //cancel 只是一个标识 最下退出强制终止线程的操作是exit 如果单写cancel 线程还是会继续执行
            [thread cancel];
        }}
}

#pragma mark - LMJNavUIBaseViewControllerDataSource

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
