//
//  ViewController.m
//  objcTempUtilities
//
//  Created by FTET on 16/6/7.
//  Copyright © 2016年 vilyever. All rights reserved.
//

#import "ViewController.h"
#import "Aspects.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self aspect_hookSelector:@selector(observeValueForKeyPath:ofObject:change:context:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
        
    } error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
