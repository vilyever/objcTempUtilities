//
//  VDRouterNavigationViewController.m
//  Ever
//
//  Created by FTET on 16/6/13.
//  Copyright © 2016年 vilyever. All rights reserved.
//

#import "VDRouterNavigationViewController.h"


@interface VDRouterNavigationViewController ()


@end


@implementation VDRouterNavigationViewController

#pragma mark Public Method
- (void)changeRootViewController:(UIViewController *)controller {
    [self setViewControllers:[NSArray arrayWithObjects:controller, nil]];
}

#pragma mark Properties


#pragma mark Overrides
- (instancetype)init {
    self = [super initWithRootViewController:[UIViewController new]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self internalInit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}


#pragma mark IBActions


#pragma mark Delegates


#pragma mark Private Method
- (void)internalInit {
    
}

@end
