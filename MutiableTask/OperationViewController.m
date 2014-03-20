//
//  OperationViewController.m
//  MutiableTask
//
//  Created by wangtao on 14-3-19.
//  Copyright (c) 2014年 wangtao. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

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
    textView.text = @"Tasks \n\nInitialization \n– init \n\nExecuting the Operation \n– start \n– main \n– completionBlock \n– setCompletionBlock: \n\nCanceling Operations \n– cancel \n\nGetting the Operation Status \n– isCancelled  \n– isExecuting \n– isFinished \n– isConcurrent \n – isReady \n\nManaging Dependencies \n– addDependency: \n– removeDependency: \n– dependencies \n\nPrioritizing Operations in an Operation Queue \n– queuePriority \n– setQueuePriority: \n\nManaging the Execution Priority \n– threadPriority \n– setThreadPriority: \n\nWaiting for Completion \n– waitUntilFinished";
    [self.view addSubview:textView];
    
    NSLog(@"main thread=%@", [NSThread currentThread]);
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(handleInvocation:) object:@"Invocation"];
    [invocationOperation start];
}

- (void)handleInvocation:(id)param{
    NSLog(@"param=%@", param);
    NSLog(@"invocation thread=%@", [NSThread currentThread]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
