//
//  YBNavMenuView.m
//  HongLiQuan
//
//  Created by 游兵 on 2017/6/17.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "YBNavMenuView.h"

#define kNavColor [UIColor redColor]

@interface YBNavMenuView ()

@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, copy) void(^didClicked)(NSInteger index);
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation YBNavMenuView

- (void)setSelectBtn:(UIButton *)selectBtn
{
    _selectBtn.selected = NO;
    _selectBtn = selectBtn;
    selectBtn.selected = YES;
}

- (UIView *)bottomLine
{
    if (_bottomLine==nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width/self.items.count, 2)];
        _bottomLine.backgroundColor = kNavColor;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *btns = [NSMutableArray array];
    CGFloat w = self.frame.size.width/items.count;
    [items enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.numberOfLines = 0;
        btn.frame = CGRectMake(w*idx, 0, w, self.frame.size.height);
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:kNavColor forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.tag = 10+idx;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
    }];
    _btns = btns;
    self.selectIndex = 0;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    self.bottomLine.frame = CGRectMake(selectIndex*self.bottomLine.frame.size.width, self.bottomLine.frame.origin.y, self.bottomLine.frame.size.width, self.bottomLine.frame.size.height);
    self.selectBtn = [self viewWithTag:10+selectIndex];
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items didClicked:(void (^)(NSInteger))didClicked
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGrayLine];
        self.didClicked = didClicked;
        self.items = items;
    }
    return self;
}

- (void)setupGrayLine
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

- (void)click:(UIButton *)btn
{
    if (self.selectBtn == btn) return;
    self.selectIndex = btn.tag-10;
    
    if (self.didClicked) {
        self.didClicked(btn.tag-10);
    }
}

@end
