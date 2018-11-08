//
//  SFJGCDViewController.m
//  IOSProject01
//
//  Created by Experimental Computer on 2018/7/27.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJGCDViewController.h"

@interface SFJGCDViewController ()

@property(nonatomic , assign)int ticketSurplusCount;
@property(nonatomic , strong)dispatch_semaphore_t semaphoreLock;

@end

@implementation SFJGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    LMJWeak(self);
    
    SFJTableItem *item0 = [SFJTableItem itemWithTitle:@"并发队列 + 同步函数" subTitle:nil];
    [item0 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself syncConCurrent];
    }];
    
    SFJTableItem *item1 = [SFJTableItem itemWithTitle:@"并发队列 + 异步函数" subTitle:nil];
    [item1 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself asyncConcurrent];
    }];
    
    SFJTableItem *item2 = [SFJTableItem itemWithTitle:@"串行队列 + 同步函数" subTitle:nil];
    [item2 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself syncSerial];
    }];
    
    SFJTableItem *item3 = [SFJTableItem itemWithTitle:@"串行队列 + 异步函数" subTitle:nil];
    [item3 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself asyncSerial];
    }];
    
    SFJTableItem *item4 = [SFJTableItem itemWithTitle:@"主队列 + 同步函数--相互等待" subTitle:@"直接闪退"];
    [item4 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself syncMain];
    }];
    
    SFJTableItem *item5 = [SFJTableItem itemWithTitle:@"主队列 + 异步函数" subTitle:nil];
    [item5 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself asyncMain];
    }];
    
    SFJTableItem *item6 = [SFJTableItem itemWithTitle:@"全局队列+ 异步函数" subTitle:nil];
    [item6 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself asyncGloba];
    }];
    
    SFJTableItem *item7 = [SFJTableItem itemWithTitle:@"线程间通信" subTitle:nil];
    [item7 setItemOperation:^(NSIndexPath *indexPath) {
        [weakself communication];
    }];
    
    SFJTableSection *section0 = [SFJTableSection sectionWithItems:@[item0, item1, item2, item3, item4, item5, item6 ] andHeaderTitle:@"六种类型：" footerTitle:nil];
    SFJTableSection *section1 = [SFJTableSection sectionWithItems:nil andHeaderTitle:@"多种 GCD" footerTitle:nil];
    
    
    SFJTableItem *item10 = [SFJTableItem itemWithTitle:@"dispatch_barrier_async" subTitle:@"栅栏函数"];
    item10.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself barrier];
    };
    
    SFJTableItem *item100 = [SFJTableItem itemWithTitle:@"dispatch_once" subTitle:@"只执行一次"];
    item100.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself once];
    };
    
    SFJTableItem *item101 = [SFJTableItem itemWithTitle:@"dispatch_after" subTitle:@"延时方法"];
    item101.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself after];
    };
    
    SFJTableItem *item11 = [SFJTableItem itemWithTitle:@"dispatch_apply" subTitle:@"快速迭代"];
    item11.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself apply];
    };
    
    SFJTableItem *item12 = [SFJTableItem itemWithTitle:@"dispatch_group_notify" subTitle:@"队列组和线程通讯"];
    item12.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself groupNotify];
    };
    
    SFJTableItem *item121 = [SFJTableItem itemWithTitle:@"dispatch_group_wait" subTitle:@"阻塞当前线程"];
    item121.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself groupWait];
    };
    
    SFJTableItem *item122 = [SFJTableItem itemWithTitle:@"dispatch_group_enter/leave" subTitle:@"追加&离开"];
    item122.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself groupEnterAndLeave];
    };
    
    [section1.items addObjectsFromArray:@[item7, item10 ,item100, item101, item11, item12 , item121,item122]];
    
    SFJTableItem *item20 = [SFJTableItem itemWithTitle:@"dispatch_source_t" subTitle:@"GCD 定时器"];
    item20.itemOperation = ^(NSIndexPath *indexPath) {
       // [weakself gcdTimer];
    };
    SFJTableItem *item21 = [SFJTableItem itemWithTitle:@"dispatch_semaphore" subTitle:@"线程同步"];
    item21.itemOperation = ^(NSIndexPath *indexPath) {
        [weakself semaphoreSync];
    };
    SFJTableItem *item22 = [SFJTableItem itemWithTitle:@"dispatch_semaphore" subTitle:@"线程安全"];
    item22.itemOperation = ^(NSIndexPath *indexPath) {
        //[weakself initTicketStatusNotSave];
        [weakself initTicketStatusSave];
    };
    
    [self.sections addObject:section0];
    [self.sections addObject:section1];
    [self.sections addObject:[SFJTableSection sectionWithItems:@[item20,item21,item22] andHeaderTitle:@"other" footerTitle:nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
-(void)syncConCurrent
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncConcurrent---begin");
    
   //1. 创建 并发 队列  --- DISPATCH_QUEUE_CONCURRENT
    dispatch_queue_t queue = dispatch_queue_create("com.luxondata.IOSProject", DISPATCH_QUEUE_CONCURRENT);
    
    //2. 创建 同步执行 任务  --- dispatch_sync
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; ++i) {
             [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1--------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncConcurrent---end");
    
    //总结：所有任务都是在当前线程（主线程）中执行的，没有开启新的线程（同步执行不具备开启新线程的能力）。
    //所有任务都在打印的syncConcurrent---begin和syncConcurrent---end之间，这说明任务是添加到队列中马上执行的
}

/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (void)asyncConcurrent
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncConcurrent---begin");
    
    //1. 创建 并发 队列
    dispatch_queue_t queue = dispatch_queue_create("com.luxondata.IOSProject", DISPATCH_QUEUE_CONCURRENT);
    
    //2.  创建 异步执行 任务
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1-----%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncConcurrent---end");
    
    //总结：
    //除了当前线程（主线程），系统又开启了3个线程，并且任务是交替/同时执行的。（异步执行具备开启新线程的能力。且并发队列可开启多个线程，同时执行多个任务）。
    //所有任务是在打印的syncConcurrent---begin和syncConcurrent---end之后才执行的。说明当前线程没有等待，而是直接开启了新线程，在新线程中执行任务（异步执行不做等待，可以继续执行任务）。
}

/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)syncSerial {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncSerial---begin");
    
    //1. 创建 串行 队列  --- DISPATCH_QUEUE_SERIAL
    dispatch_queue_t queue = dispatch_queue_create("com.luxondata.IOSProject", DISPATCH_QUEUE_SERIAL);
    
    //2. 创建 同步执行 任务
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
     NSLog(@"syncSerial---end");
    
    // 总结：
    //    所有任务都是在主线程中执行的，并没有开启新的线程。而且由于串行队列，所以按顺序一个一个执行
    //    所有任务都在打印的syncConcurrent---begin和syncConcurrent---end之间，这说明任务是添加到队列中马上执行的
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)asyncSerial {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");
    
    //1. 创建 串行 队列
    dispatch_queue_t queue = dispatch_queue_create("com.luxondata.IOSProject", DISPATCH_QUEUE_SERIAL);
    
    //2. 创建 异步执行 任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial---end");
    
    //总结：
    //    开启了一条新线程，但是任务还是串行，所以任务是一个一个执行
    //    所有任务是在打印的syncConcurrent---begin和syncConcurrent---end之后才开始执行的。说明任务不是马上执行，而是将所有任务添加到队列之后才开始同步执行
}

/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncMain {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncMain---begin");
 
    // 1. 创建 主队列    --- dispatch_get_main_queue 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //2. 创建 同步执行 任务
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial---end");
    
    // 在主线程中执行同步任务卡死原因分析：
    //1. 首先 主线程会执行 syncMain 这个方法
    //2. 其次 三个任务 都在主队列中 等待执行
    //3. 因为是 同步任务 ，所以任务1开始执行，必须等待 主线程中 syncMain 执行 完毕。 而 syncMain 执行完毕，又得去执行 任务1
    // 现在的情况就是syncMain任务和任务1都在等对方执行完毕。这样大家互相等待，所以就卡住了，所以我们的任务执行不了，
    
   // 解决办法： 可以将 syncMain 放到其他线程中去执行
    // 使用 NSThread 的 detachNewThreadSelector 方法会创建线程，并自动启动线程执行
   // [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    
    //此时 syncMain 在其他线程中， 任务1，2，3在主线程中依次执行
    
}

/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
- (void)asyncMain {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");
 
    //1. 创建 主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //2. 创建 异步执行 任务
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial---end");
    
    //总结：
    //所有任务都是在当前线程（主线程）中执行的，并没有开启新的线程（虽然异步执行具备开启线程的能力，但因为是主队列，所以所有任务都在主线程中）。
    //所有任务是在打印的syncConcurrent---begin和syncConcurrent---end之后才开始执行的（异步执行不会做任何等待，可以继续执行任务）。
    //任务是按顺序执行的（因为主队列是串行队列，每次只有一个任务被执行，任务一个接一个按顺序执行）。

}

//七：全局队列+ 异步执行
-(void)asyncGloba
{
    //1. 创建 全局并发 队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //2. 创建 异步执行 任务
    for (int i = 0; i < 10; ++i) {
        dispatch_async(queue, ^{
            NSLog(@"asyncGloba：%@ %d", [NSThread currentThread], i);
        });
    }
    
     NSLog(@"come here");
    
    // come here 说明是异步执行，没有马上执行，并且有开子线程执行
}

/**
 * 线程间通信
 */
- (void)communication
{
    // 1. 创建 全局并发 队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //获取 主队列
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
    
    // 2. 创建异步执行任务
    dispatch_async(queue, ^{
         for (int i = 0; i < 5; ++i) {
             [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
             NSLog(@"子线程---%@",[NSThread currentThread]);
         }
        
        dispatch_async(mainqueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"回到主线程 ---%@",[NSThread currentThread]);
        });
    });
}

/*
 <一>什么是dispatch_barrier_async函数
 
 毫无疑问,dispatch_barrier_async函数的作用与barrier的意思相同,在进程管理中起到一个栅栏的作用,它等待所有位于barrier函数之前的操作执行完毕后执行,并且在barrier函数执行之后,barrier函数之后的操作才会得到执行,该函数需要同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
 
 <二>dispatch_barrier_async函数的作用
 
 1.实现高效率的数据库访问和文件访问
 
 2.避免数据竞争
 */
- (void)barrier
{
    // 1. 创建 并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.luxondata.IOSProject", DISPATCH_QUEUE_CONCURRENT);
    
    //创建 多组 异步执行任务
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        // 追加任务4
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4---%@",[NSThread currentThread]);
        }
    });
}

/**
 * 延时执行方法 dispatch_after
 */
- (void)after
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncMain---begin");
    
    // 1. 创建 并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.luxondata.IOSProject", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
       // 2.0秒后异步追加任务代码到队列中，并开始执行
        NSLog(@"子线程---%@",[NSThread currentThread]);
    });
    
     NSLog(@"asyncMain---end");
}

/**
 * 一次性代码（只执行一次）dispatch_once
 我们在创建单例、或者有整个程序运行过程中只执行一次的代码时，我们就用到了 GCD 的 dispatch_once 函数。
 使用dispatch_once 函数能保证某段代码在程序运行过程中只被执行1次，并且即使在多线程的环境下，dispatch_once也可以保证线程安全。
 */
- (void)once
{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这里面默认是线程安全的);
        NSLog(@"dispatch_once");    //不管 once方法被调用多少次 ，这里面的代码只执行一次
    });
}

/**
 * 快速迭代方法 dispatch_apply

 这个函数提交代码块到一个分发队列,以供多次调用,会等迭代其中的任务全部完成以后,才会返回.
 如果被提交的队列是并发队列,那么这个代码块必须保证每次读写的安全.
 这个函数对并行的循环 还有作用,
 
 我理解就是类似遍历一个数组一样,当提交到一个并发的队列上的时候,这个遍历是并发运行的,速度很快.
 */
- (void)apply
{
    // 创建 全局并发队列
   dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
     NSLog(@"apply---begin");
    
    dispatch_apply(100, queue, ^(size_t index) {
         NSLog(@"%zd---%@", index, [NSThread currentThread]);
    });
    
     NSLog(@"apply---begin");
}

/**
 * 队列组  dispatch_group_t
 * 监听group  dispatch_group_notify
 */
- (void)groupNotify
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    //1. 创建一个 队列组
    dispatch_group_t group = dispatch_group_create();
    
    //创建全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //先把任务放到队列中，然后将队列放入队列组中
    dispatch_group_async(group, queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_queue_t mainquece = dispatch_get_main_queue();
    //dispatch_group_notify 监听 group 中任务的完成状态，当所有的任务都执行完成后，追加任务到 mainquece 中，并执行任务。
    dispatch_group_notify(group, mainquece, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
        NSLog(@"3group---end");
    });
     NSLog(@"group---end");
}

/**
 * 队列组 dispatch_group_wait
 */
- (void)groupWait
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    //创建 group
    dispatch_group_t group = dispatch_group_create();
    //创建全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    //DISPATCH_TIME_FOREVER 阻塞当前线程 ， 当group中的任务全部执行结束 后，才会继续往下执行
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"group---end");
}

/**
 * 队列组 dispatch_group_enter、dispatch_group_leave
 */
- (void)groupEnterAndLeave
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
 
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@",[NSThread currentThread]);
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
       // dispatch_group_leave(group);   //当group中还有任务没有离开 ， 则下面的过程不会继续执行
    });
    
    // 等前面的异步操作都执行完毕后，回到主线程.
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@",[NSThread currentThread]);
        }
        NSLog(@"3group---end");
    });

}

/**
 * semaphore 线程同步
 Dispatch Semaphore
 保持线程同步，将异步执行任务转换为同步执行任务
 保证线程安全，为线程加锁
 */
- (void)semaphoreSync {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个Semaphore并初始化信号的总量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
        
        number = 100;
        //发送一个信号，让信号总量加1
        dispatch_semaphore_signal(semaphore);
    });
    
    //可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行。
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     NSLog(@"semaphore---end,number = %d",number);
    
    //过程：
    //1.首先 添加的是异步执行任务 ， 下面的任务不做等待，继续执行，此时信号量为 0，会阻塞线程 ，下面的打印过程不会执行
    //2.异步任务1开始执行后，number = 100; 信号量为1 ， 就会执行下面的打印过程
}

/**
 * 非线程安全：不使用 semaphore
 * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
 */
- (void)initTicketStatusNotSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
 
    self.ticketSurplusCount = 50;
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("com.luxondata.IOSProject1", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("com.luxondata.IOSProject2", DISPATCH_QUEUE_SERIAL);
    
    LMJWeak(self);
    dispatch_async(queue1, ^{
        [weakself saleTicketNotSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakself saleTicketNotSafe];
    });
}
/*
 若每个线程中对全局变量、静态变量只有读操作，而无写操作，一般来说，这个全局变量是线程安全的；若有多个线程同时执行写操作（更改变量），一般都需要考虑线程同步，否则的话就可能影响线程安全。
 */
/**
 * 售卖火车票(非线程安全)
 */
- (void)saleTicketNotSafe {
    while (1) {
        
        if (self.ticketSurplusCount > 0) {  //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { //如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            break;
        }
        
    }
}

/**
 * 线程安全：使用 semaphore 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */
- (void)initTicketStatusSave
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    //创建信号量
    self.semaphoreLock = dispatch_semaphore_create(1);
    
    self.ticketSurplusCount = 50;
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("com.luxondata.IOSProject1", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("com.luxondata.IOSProject2", DISPATCH_QUEUE_SERIAL);
    
    LMJWeak(self);
    dispatch_async(queue1, ^{
        [weakself saleTicketSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakself saleTicketSafe];
    });
}
/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {
        //  相当于 加锁
        dispatch_semaphore_wait(self.semaphoreLock, DISPATCH_TIME_FOREVER);
        /*
         queue1 访问时 semaphoreLock = 1 ，可以继续下去 买票
         执行wait之后 ，semaphoreLock = 0 ，queue2 访问 ，线程阻塞（加锁），无法继续
        */
        if (self.ticketSurplusCount > 0) {  //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { //如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            
            //解锁
            dispatch_semaphore_signal(self.semaphoreLock);
            break;
        }
        // 解锁
        dispatch_semaphore_signal(self.semaphoreLock);
        /*
         每执行一次（卖一张票） ，semaphoreLock + 1 = 1
         下次访问时 ，semaphoreLock = 1 ，就可以买票了
         */
    }
}

//------------------------------------------------------------------------------------------
//理论知识
//同步执行（sync）：只能在当前线程中执行任务，不具备开启新线程的能力
//异步执行（async）：可以在新的线程中执行任务，具备开启新线程的能力
//------------------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------------------
//并发队列（Concurrent Dispatch Queue）：可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）,并发功能只有在异步（dispatch_async）函数下才有效
//串行队列（Serial Dispatch Queue）：让任务一个接着一个地执行（一个任务执行完毕后，再执行下一个任务）
//------------------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------------------
//// 串行队列的创建方法
//dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
//// 并发队列的创建方法
//dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
////创建全局并发队列
//dispatch_get_global_queue来创建全局并发队列

//全局并发队列
//dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//全局并发队列的优先级
//#define DISPATCH_QUEUE_PRIORITY_HIGH 2 // 高优先级
//#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0 // 默认（中）优先级
//#define DISPATCH_QUEUE_PRIORITY_LOW (-2) // 低优先级
//#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN // 后台优先级
//iOS8开始使用服务质量，现在获取全局并发队列时，可以直接传0
//dispatch_get_global_queue(0, 0);
//
//
//dispatch_queue_t queue = dispatch_get_main_queue() 程序一启动，主线程就已经存在，主队列也同时就存在了，所以主队列不需要创建，只需要获取
//
//------------------------------------------------------------------------------------------
//六种类型：
//并发队列 + 同步执行       不会开启新线程，因为是同步的，所以执行完一个任务，再执行下一个任务
//并发队列 + 异步执行       开启多条线程 ，任务交替执行
//串行队列 + 同步执行       执行完一个任务，再执行下一个任务。不开启新线程
//串行队列 + 异步执行       开启一条新线程，因为任务是串行的，所以还是按顺序执行任务。
//主队列 + 同步执行        发生死锁，程序崩溃
//主队列 + 异步执行        主线程中按顺序执

//示例：
/*
 // 异步
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 // 耗时操作放在这里，例如下载图片。（运用线程休眠两秒来模拟耗时操作）
 [NSThread sleepForTimeInterval:2];
 NSString *picURLStr = @"http://www.bangmangxuan.net/uploads/allimg/160320/74-160320130500.jpg";
 NSURL *picURL = [NSURL URLWithString:picURLStr];
 NSData *picData = [NSData dataWithContentsOfURL:picURL];
 UIImage *image = [UIImage imageWithData:picData];
 
 // 回到主线程处理UI
 dispatch_async(dispatch_get_main_queue(), ^{
 // 在主线程上添加图片
 self.imageView.image = image;
 });
 });
 */
@end
