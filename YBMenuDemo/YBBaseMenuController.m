//
//  YBBaseMenuController.m
//  HongLiQuan
//
//  Created by 游兵 on 2017/6/17.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "YBBaseMenuController.h"
#import "YBNavMenuView.h"

@implementation YBBaseMenuControllerItem

+ (instancetype)itemWithTitle:(NSString *)title vc:(UIViewController *)vc
{
    YBBaseMenuControllerItem *item = [[YBBaseMenuControllerItem alloc] init];
    item.title = title;
    item.vc = vc;
    return item;
}

@end

@interface YBBaseMenuController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL isClickedAnimate;//点击导致的scrollView滚动


@end

@implementation YBBaseMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    _scrollEnabled = scrollEnabled;
    self.scrollView.scrollEnabled = scrollEnabled;
}

- (void)setItems:(NSArray<YBBaseMenuControllerItem *> *)items
{
    _items = items;
    [self setupUI];
}

- (void)setupUI
{
    [self setupMenuView];
    [self setupScrollView];
    [self addChildVC];
}

- (void)addChildVC
{
    [self.items enumerateObjectsUsingBlock:^(YBBaseMenuControllerItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.vc.view.frame = CGRectMake(idx*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:obj.vc.view];
        [self addChildViewController:obj.vc];
    }];
}

- (void)setupMenuView
{
    __weak typeof(self) weakSelf = self;
    _navMenuView = [[YBNavMenuView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) items:[self.items valueForKey:@"title"] didClicked:^(NSInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.isClickedAnimate = YES;
        [strongSelf.scrollView setContentOffset:CGPointMake(index*weakSelf.scrollView.frame.size.width, 0) animated:self.scrollEnabled];
    }];
    [self.view addSubview:self.navMenuView];
}

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navMenuView.frame), self.navMenuView.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.navMenuView.frame))];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*self.items.count, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isClickedAnimate) return;
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (point.x + (scrollView.frame.size.width/2))/scrollView.frame.size.width;
    self.navMenuView.selectIndex = index;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isClickedAnimate = NO;
}


@end
