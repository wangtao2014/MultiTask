//
//  PerformSelectorViewController.m
//  MultiTask
//
//  Created by wangtao on 14-3-20.
//  Copyright (c) 2014年 wangtao. All rights reserved.
// iOS开发中,在主线程之外的线程更新主线程所显示的界面元素,如果直接调用主线程的类的更新界面的方法,界面看不到任何结果,即使在其他线程中强制调用setNeedsDisplay也无济于事。

#import "PerformSelectorViewController.h"

@interface PerformSelectorViewController ()

- (void)handleMainThread:(id)mainParam;

@end

@implementation PerformSelectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect appRect = [UIScreen mainScreen].bounds;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 20.0f, appRect.size.width - 10.0f, appRect.size.height)];
    textView.contentSize = CGSizeMake(appRect.size.width - 10.0f, appRect.size.height);
    NSLog(@"contentSize=%@", NSStringFromCGSize(textView.contentSize));
    textView.font = [UIFont systemFontOfSize:16];
    textView.text = @"\nSending Messages \n\n–performSelectorOnMainThread:withObject:waitUntilDone: \n\n–performSelectorOnMainThread:withObject:waitUntilDone:modes: \n\n–performSelector:onThread:withObject:waitUntilDone: \n\n–performSelector:onThread:withObject:waitUntilDone:modes: \n\n–performSelectorInBackground:withObject:";
    [self.view addSubview:textView];
    NSLog(@"start");
    NSLog(@"main = %@", [NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(handlePerform:) toTarget:self withObject:@"hello"];
    // 当前线程是主线程时，waitUntilDone:YES 无效 相当于方法调用 顺序执行，当是NO时，方法立即返回。
//    [self performSelectorOnMainThread:@selector(handleMainThread:) withObject:@"main" waitUntilDone:NO];
    // Invokes a method of the receiver on a new background thread
    [self performSelectorInBackground:@selector(backgroundHandle:) withObject:@"helel"];
    [NSThread sleepForTimeInterval:3];
    NSLog(@"end");
}

- (void)handlePerform:(id)param
{
    NSLog(@"param=%@", param);
    NSLog(@"handlePerform = %@", [NSThread currentThread]);
    // Specify YES to block this thread; otherwise, specify NO to have this method return immediately.
    // 当waitUntilDone:NO时 或者YES 只是影响到当前方法的调用顺序，
    // 执行主线程操作是放到主线程队列中，并且是以队列的执行顺序，先进先出 不管调用多少次，都是同样的执行顺序
    [self performSelectorOnMainThread:@selector(handleMainThread:) withObject:@"main" waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(handleMainThread:) withObject:@"main" waitUntilDone:YES];
    NSLog(@"##############");
    // 方法执行结束 线程也就结束了，会post NSThreadWillExitNotification通知
}

// The method should not have a significant return value and should take a single argument of type id, or no arguments.
- (void)handleMainThread:(id)mainParam
{
    NSLog(@"mian param=%@", mainParam);
    NSLog(@"handleMainThread = %@", [NSThread currentThread]);
    // 主线程没结束 一直都在runloop 所以没有post NSThreadWillExitNotification通知 不是主线程的执行结束 都会post NSThreadWillExitNotification通知。
}

- (void)backgroundHandle:(id)param
{
    NSLog(@"backgroundHandle param=%@", param);
    NSLog(@"backgroundHandle thread = %@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
