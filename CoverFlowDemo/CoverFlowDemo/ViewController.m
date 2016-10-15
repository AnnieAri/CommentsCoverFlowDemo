//
//  ViewController.m
//  CoverFlowDemo
//
//  Created by Ari on 16/10/15.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ViewController.h"
#import "CoverFlowView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CoverFlowView *coverFlowView = [[CoverFlowView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 180)];
    [self.view addSubview:coverFlowView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
