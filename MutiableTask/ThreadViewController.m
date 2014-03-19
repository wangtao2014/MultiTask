//
//  ThreadViewController.m
//  MutiableTask
//
//  Created by wangtao on 14-3-19.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "ThreadViewController.h"

@interface ThreadViewController ()

@end

@implementation ThreadViewController

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
    textView.contentSize = CGSizeMake(appRect.size.width - 10.0f, 2 * appRect.size.height);
    NSLog(@"contentSize=%@", NSStringFromCGSize(textView.contentSize));
    textView.font = [UIFont systemFontOfSize:16];
    textView.text = @"Tasks \n\nInitializing an NSThread Object \n– init \n– initWithTarget:selector:object: \n\nStarting a Thread \n+detachNewThreadSelector:toTarget:withObject: \n– start \n– main \n\nStopping a Thread \n+ sleepUntilDate: \n+ sleepForTimeInterval: \n+ exit \n– cancel \n\nDetermining the Thread’s Execution State \n– isExecuting \n– isFinished \n– isCancelled \n\nWorking with the Main Thread \n+ isMainThread \n– isMainThread \n+ mainThread \n\nQuerying the Environment \n+ isMultiThreaded \n+ currentThread \n+ callStackReturnAddresses \n+ callStackSymbols \n\nWorking with Thread Properties \n– threadDictionary \n– name \n– setName: \n– stackSize \n– setStackSize: \n\nWorking with Thread Priorities\n+ threadPriority \n– threadPriority\n+ setThreadPriority:\n– setThreadPriority:";
    [self.view addSubview:textView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitThread:) name:NSThreadWillExitNotification object:nil];
    
    NSLog(@"currentThread=%@", [NSThread currentThread]);
    // Initializing an NSThread Object
    NSThread *secThread = [[NSThread alloc] initWithTarget:self selector:@selector(handle:) object:@"hello"];
    // start an NSThread Object
    [secThread start];
    
    // Initializing + start an NSThread Object
    [NSThread detachNewThreadSelector:@selector(handle:) toTarget:self withObject:@"third"];
    
    NSLog(@"nihaoms");
}

- (void)exitThread:(NSNotification *)notification
{
    NSLog(@"NSThreadWillExitNotification");
}

- (void)handle:(NSString *)param
{
    NSLog(@"param=%@", param);
    NSLog(@"thread=%@", [NSThread currentThread]);
    
    if ([param isEqualToString:@"third"]) {
        // Stopping a Thread
        [NSThread sleepForTimeInterval:3];
        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
        // Invoking this method should be avoided as it does not give your thread a chance to clean up any resources it allocated during its execution.
        // Terminates the current thread
        
        if ([[NSThread currentThread] isCancelled]) {
            // [[NSThread currentThread] cancel]
            // Changes the cancelled state of the receiver to indicate that it should exit.
            [NSThread exit];
        }
        
        NSLog(@"sleep");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSThreadWillExitNotification object:nil];
}

@end
