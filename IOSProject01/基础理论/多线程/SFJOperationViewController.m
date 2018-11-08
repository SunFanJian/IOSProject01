//
//  SFJOperationViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/26.
//  Copyright © 2018年 Luxondata. All rights reserved.
//
/*
 NSOperation
 NSOperation是苹果提供给我们的一套多线程解决方案。实际上NSOperation是基于GCD更高一层的封装，但是比GCD更简单易用、代码可读性也更高。
  NSOperation需要配合NSOperationQueue来实现多线程。因为默认情况下，NSOperation单独使用时系统同步执行操作，并没有开辟新线程的能力，只有配合NSOperationQueue才能实现异步执行
 自带线程管理的抽象类。
 1）优点：自带线程周期管理，操作上可更注重自己逻辑。
 2）缺点：面向对象的抽象类，只能实现它或者使用它定义好的两个子类：NSInvocationOperation 和 NSBlockOperation。
 */

#import "SFJOperationViewController.h"

@interface SFJOperationViewController ()

@end

@implementation SFJOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWeak(self);
    
    SFJTableItem *item0 = [SFJTableItem itemWithTitle:@"一：NSInvocationOperation子类+主队列 (主线程中执行)" subTitle:@""];
    [item0 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addOperationFormInvocation];
    }];
    
    SFJTableItem *item1 = [SFJTableItem itemWithTitle:@"二：NSInvocationOperation子类+非主队列  (新开线程中执行)" subTitle:nil];
    [item1 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addAsnysOperationFormInvocation];
    }];
    
    SFJTableItem *item2 = [SFJTableItem itemWithTitle:@"三：使用子类- NSBlockOperation 主线程和子线程执行" subTitle:nil];
    [item2 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addOperationFormBlock];
    }];
    
    SFJTableItem *item3 = [SFJTableItem itemWithTitle:@"四：使用子类- NSBlockOperation 子线程执行 加入非主队列" subTitle:nil];
    [item3 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addAsnysOperationFormBlock];
    }];
    
    SFJTableItem *item4 = [SFJTableItem itemWithTitle:@"五：maxConcurrentOperationCount设置 并发或串行" subTitle:@""];
    [item4 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addMaxConcurrentOperation];
    }];
    
    SFJTableItem *item5 = [SFJTableItem itemWithTitle:@"七：操作依赖(addDependency)" subTitle:nil];
    [item5 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addDependency];
    }];
    
    SFJTableItem *item6 = [SFJTableItem itemWithTitle:@"八：queue addOperationWithBlock" subTitle:nil];
    [item6 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself addOperationWithBlock];
    }];
    
    SFJTableItem *item7 = [SFJTableItem itemWithTitle:@"九：线程间通讯" subTitle:nil];
    [item7 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself commit];
    }];
    
    SFJTableSection *section0 = [SFJTableSection sectionWithItems:@[item0, item1, item2, item3, item4, item5, item6, item7] andHeaderTitle:@"" footerTitle:nil];
    [section0.items makeObjectsPerformSelector:@selector(setTitleFont:) withObject:[UIFont systemFontOfSize:12]];
    
    [self.sections addObject:section0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//一：NSInvocationOperation子类+主队列  (主线程中执行)
-(void)addOperationFormInvocation
{
     // 1.创建NSInvocationOperation对象 -- 任务对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(runAction) object:nil];
    //2.
    [op start];         //直接会在当主线程执行 ， 不开启新线程
    
   // NSOperationQueue *queue = [NSOperationQueue mainQueue];   //主队列
   // [queue addOperation:op];    //用了主队列 [op start]; 就可以不写了
}

-(void)runAction
{
    NSLog(@"当前NSInvocationOperation执行的线程为：%@", [NSThread currentThread]);
}

//二：NSInvocationOperation子类+非主队列  (新开线程中执行)
-(void)addAsnysOperationFormInvocation
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(runAsnysAction) object:nil];
    
    [queue addOperation:op];
}

-(void)runAsnysAction
{
    NSLog(@"当前addAsnysOperationFormInvocation执行的线程为：%@", [NSThread currentThread]);
}

//三：使用子类- NSBlockOperation 主线程和子线程执行
-(void)addOperationFormBlock
{
    NSLog(@"主线程：%@",[NSThread mainThread]);
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"NSBlockOperation当前的线程：%@", [NSThread currentThread]);   //这个在主线程
    }];
    
    // 添加额外的任务(部分在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程4------%@", [NSThread currentThread]);
    }];
    
    [op start];
}

//四：使用子类- NSBlockOperation 子线程执行 加入非主队列
-(void)addAsnysOperationFormBlock
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在子线程
        NSLog(@"addAsnysOperationFormBlock当前的线程：%@", [NSThread currentThread]);
    }];
    
    // 添加额外的任务(部分在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"NSBlockOperation当前的线程4------%@", [NSThread currentThread]);
    }];
    
    [queue addOperation:op];
}

//五：maxConcurrentOperationCount设置 并发或串行,
-(void)addMaxConcurrentOperation
{
    /*
     该函数设置的是queue里面最多能并发运行的operation个数，而不是线程个数，因为一个operation并非只能运行一个线程，
     */
    // 多尝试几次!!!
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        //        for (int i = 0; i<100;i++)
        //        {
        NSLog(@"%@:a",[NSThread currentThread]);
        //        }
    }];
    
    [op1 addExecutionBlock:^{
        
        //        for (int m = 0; m<100;m++)
        //        {
        NSLog(@"%@:aa",[NSThread currentThread]);
        //        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        //        for (int j = 0; j<100;j++)
        //        {
        NSLog(@"%@:b",[NSThread currentThread]);
        //        }
    }];
    [op2 addExecutionBlock:^{
        
        //        for (int k = 0; k<100;k++)
        //        {
        NSLog(@"%@:bb",[NSThread currentThread]);
        //        }
    }];
    
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        
        //        for (int n = 0; n<100;n++)
        //        {
        NSLog(@"%@:c",[NSThread currentThread]);
        //        }
    }];
    [op3 addExecutionBlock:^{
        
        //        for (int r = 0; r<100;r++)
        //        {
        NSLog(@"%@:cc",[NSThread currentThread]);
        //        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue setMaxConcurrentOperationCount:1];
    [queue addOperation:op1];
     [queue addOperation:op2];
     [queue addOperation:op3];
    
    //说明：maxConcurrentOperationCount 是queue里面最多能并发运行的operation个数，而不是线程个数
    //    maxConcurrentOperationCount默认情况下为-1，表示不进行限制，默认为并发执行。
    //    当maxConcurrentOperationCount为1时，进行串行执行。
    //    当maxConcurrentOperationCount大于1时，进行并发执行，当然这个值不应超过系统限制，即使自己设置一个很大的值，系统也会自动调整
}

//六：定义继承自NSOperation的子类
-(void) addChildNSOperation
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSOperation *op = [NSOperation new];
    
    [queue addOperation:op];
    
    NSLog(@"当前执行的线程为：%@", [NSThread currentThread]);
}

//七：操作依赖
-(void)addDependency
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op0 = [NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"addDependency0当前线程%@", [NSThread  currentThread]);
    }];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addDependency1当前线程%@", [NSThread  currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"addDependency2当前线程%@", [NSThread  currentThread]);
    }];
    
    [op1 addDependency:op2];  // 让op1 依赖于 op2，则先执行op2，在执行op1
   // [op2 addDependency:op1];  //op2 依赖于 op1 , 先 op1 , 再 op2
    
    [queue addOperation:op0];
    [queue addOperation:op1];
    [queue addOperation:op2];
    
}


- (void)addOperationWithBlock
{
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //     设置最大并发操作数
    //   == 1 就变成了串行队列
    queue.maxConcurrentOperationCount = 3;
    
    // 添加操作
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<1000; i++) {
            NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<1000; i++) {
            NSLog(@"download2 --- %@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i<1000; i++) {
            NSLog(@"download3 --- %@", [NSThread currentThread]);
        }
    }];
}

- (void)commit
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    __block UIImage *image1 = nil;
    // 下载图片1
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        image1 = [UIImage imageWithData:data];
    }];
    
    __block UIImage *image2 = nil;
    // 下载图片2
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
        
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        image2 = [UIImage imageWithData:data];
    }];
    
    // 合成图片
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        // 开启新的图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        
        // 绘制图片
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        image1 = nil;
        
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        image2 = nil;
        
        // 取得上下文中的图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束上下文
        UIGraphicsEndImageContext();
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 4.将新图片显示出来
            UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
            imageV.frame = CGRectMake(100, 100, 200, 200);
            [self.view addSubview:imageV];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [imageV removeFromSuperview];
            });
        }];
    }];
    [combine addDependency:download1];
    [combine addDependency:download2];
    
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combine];
    
}

/*
    NSOperation 的其他操作
 
取消队列NSOperationQueue的所有操作，NSOperationQueue对象方法
- (void)cancelAllOperations
 
取消NSOperation的某个操作，NSOperation对象方法
- (void)cancel

// 暂停队列
[queue setSuspended:YES];
 
判断队列是否暂停
- (BOOL)isSuspended
 
*/
@end
