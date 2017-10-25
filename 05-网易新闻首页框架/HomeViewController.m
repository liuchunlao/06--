//
//  HomeViewController.m
//  05-网易新闻首页框架
//
//  Created by apple on 15/1/15.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeLabelButton.h"
#import "HealineViewController.h"
#import "UIView+Extension.h"

@interface HomeViewController () <UIScrollViewDelegate>
/** 存放标签 */
@property (weak, nonatomic) IBOutlet UIScrollView *labelsScrollView;
/** 存放具体的子控制器 */
@property (weak, nonatomic) IBOutlet UIScrollView *contentsScrollView;
@property (nonatomic, weak) HomeLabelButton *selectedButton;
@end

@implementation HomeViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setupChildVcs];
    
    // 初始化顶部标签
    [self setupLabels];
}

/**
 *  初始化顶部标签
 */
- (void)setupLabels
{
    // 不要刻意去调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat labelButtonW = 90;
    NSUInteger count = self.childViewControllers.count;
    for (NSUInteger i = 0; i < count; i++) {
        // 取出i位置对应的子控制器
        UIViewController *childVc = self.childViewControllers[i];
        
        // 添加标签
        HomeLabelButton *labelButton = [[HomeLabelButton alloc] init];
        labelButton.height = self.labelsScrollView.height;
        labelButton.width = labelButtonW;
        labelButton.y = 0;
        labelButton.x = i * labelButtonW;
        [labelButton setTitle:childVc.title forState:UIControlStateNormal];
        [labelButton addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.labelsScrollView addSubview:labelButton];
    }
    
    // 设置内容大小
    self.labelsScrollView.contentSize = CGSizeMake(count * labelButtonW, 0);
    self.contentsScrollView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
    
    // 设置输入法
    self.contentsScrollView.delegate = self;
}

/**
 *  初始化子控制器
 */
- (void)setupChildVcs
{
    HealineViewController *vc0 = [[HealineViewController alloc] init];
    vc0.title = @"头条";
    [self addChildViewController:vc0];
    
    HealineViewController *vc1 = [[HealineViewController alloc] init];
    vc1.title = @"政治";
    [self addChildViewController:vc1];
    
    HealineViewController *vc2 = [[HealineViewController alloc] init];
    vc2.title = @"经济";
    [self addChildViewController:vc2];
    
    HealineViewController *vc3 = [[HealineViewController alloc] init];
    vc3.title = @"体育";
    [self addChildViewController:vc3];
    
    HealineViewController *vc4 = [[HealineViewController alloc] init];
    vc4.title = @"国际";
    [self addChildViewController:vc4];
    
    HealineViewController *vc5 = [[HealineViewController alloc] init];
    vc5.title = @"哈哈";
    [self addChildViewController:vc5];
    
    HealineViewController *vc6 = [[HealineViewController alloc] init];
    vc6.title = @"呵呵";
    [self addChildViewController:vc6];
}

#pragma mark - 私有方法
/**
 *  监听按钮点击
 */
- (void)labelClick:(HomeLabelButton *)labelButton
{
    // 切换按钮状态
    self.selectedButton.selected = NO;
    labelButton.selected = YES;
    self.selectedButton = labelButton;
    
    // 切换子控制器
    NSUInteger index = [self.labelsScrollView.subviews indexOfObject:labelButton];
    [self switchChildVc:index];
}

/**
 *  切换子控制器
 *
 *  @param index 子控制器对应的索引
 */
- (void)switchChildVc:(NSUInteger)index
{
    // 添加index位置对应的控制器
    UIViewController *newChildVc = self.childViewControllers[index];
    if (newChildVc.view.superview == nil) {
        newChildVc.view.y = 0;
        newChildVc.view.width = self.contentsScrollView.width;
        newChildVc.view.height = self.contentsScrollView.height;
        newChildVc.view.x = index * newChildVc.view.width;
        [self.contentsScrollView addSubview:newChildVc.view];
    }
    
    // 滚动到index控制器对应的位置
    [self.contentsScrollView setContentOffset: CGPointMake(newChildVc.view.x, 0) animated:YES];
    
    // 让被点击的标签按钮显示在最中间
    CGFloat offsetX = self.selectedButton.centerX - self.labelsScrollView.width * 0.5;
    CGFloat maxOffsetX = self.labelsScrollView.contentSize.width - self.labelsScrollView.width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.labelsScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  当scrollView减速完毕时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    HomeLabelButton *labelButton = self.labelsScrollView.subviews[index];
    [self labelClick:labelButton];
}

/**
 *  当scrollView正在滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = scrollView.contentOffset.x / scrollView.width;
    NSUInteger oneIndex = (NSUInteger)value;
    NSUInteger twoIndex = oneIndex + 1;
    CGFloat twoPercent = value - oneIndex;
    CGFloat onePercent = 1 - twoPercent;
    
    HomeLabelButton *oneButton = self.labelsScrollView.subviews[oneIndex];
    [oneButton adjust:onePercent];
    
    if (twoIndex < self.labelsScrollView.subviews.count) {
        HomeLabelButton *twoButton = self.labelsScrollView.subviews[twoIndex];
        [twoButton adjust:twoPercent];
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"scrollViewDidEndDragging");
//}
@end
