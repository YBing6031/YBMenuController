//
//  YBBaseMenuController.h
//  HongLiQuan
//
//  Created by 游兵 on 2017/6/17.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "YBNavMenuView.h"

@interface YBBaseMenuControllerItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIViewController *vc;

+ (instancetype)itemWithTitle:(NSString *)title vc:(UIViewController *)vc;

@end

@interface YBBaseMenuController : UIViewController

@property (nonatomic, strong, readonly) YBNavMenuView *navMenuView;

@property (nonatomic, strong) NSArray<YBBaseMenuControllerItem *> *items;

@property (nonatomic, assign, getter=isScrollEnabled) BOOL scrollEnabled;

@end
