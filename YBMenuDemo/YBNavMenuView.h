//
//  YBNavMenuView.h
//  HongLiQuan
//
//  Created by 游兵 on 2017/6/17.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBNavMenuView : UIView

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong, readonly) NSArray<UIButton *> *btns;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items didClicked:(void(^)(NSInteger index))didClicked;



@end
