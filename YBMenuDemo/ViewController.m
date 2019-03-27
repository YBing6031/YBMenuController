//
//  ViewController.m
//  YBMenuDemo
//
//  Created by YB on 2019/3/27.
//  Copyright © 2019 com.ybing.www. All rights reserved.
//

#import "ViewController.h"
#import "YBController.h"
#import "YBController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YBBaseMenuControllerItem *item = [YBBaseMenuControllerItem itemWithTitle:@"test1" vc:YBController.new];
    YBBaseMenuControllerItem *item1 = [YBBaseMenuControllerItem itemWithTitle:@"test2" vc:YBController2.new];
    self.items = @[item, item1];
    self.scrollEnabled = NO;
    [self.navMenuView.btns.firstObject setTitle:@"123" forState:UIControlStateNormal];
}


@end
