//
//  ConnectVIewController.m
//  ListenMusic
//
//  Created by 凤凰八音 on 2017/9/19.
//  Copyright © 2017年 fenghuangbayin. All rights reserved.
//

#import "ConnectVIewController.h"
#import "ConnectVIew.h"
#import "HelpView.h"


@interface ConnectVIewController ()<UIScrollViewDelegate>

// 写滚动视图的全局变量，以便全局调用
@property (nonatomic, strong) UIScrollView *scroll;
// 分页指示器
@property (nonatomic, strong) UIPageControl *pageControl;
// 连接界面
@property (nonatomic, strong) ConnectVIew *cView;
// 帮助界面
@property (nonatomic, strong) HelpView *hView;

@end

@implementation ConnectVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 调用一下方法
    [self scroll];
    // 加载内容
    [self createImageV];
    // 分页控制器
    [self pageControl];
}

#pragma mark====== <UIScrollViewDelegate> ===========
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self setUpScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self setUpScroll:scrollView];
}

- (void)setUpScroll:(UIScrollView *)sc{
    
    //拿到页数
    NSInteger _page = sc.contentOffset.x/CGRectGetWidth(sc.frame);
    //   当前页数，需要让拿到的页数减一
    _pageControl.currentPage = _page - 1;
    
    if (_page == 0) {
        _pageControl.currentPage = 0;
    }else if (_page == 1){
        _pageControl.currentPage = 1;
    }

}

#pragma ====循环创建 UIImageView 来加载图片====
- (void)createImageV{
    
    
    for (int i=0; i<2; i++) {
        
        if (i==0) {
            self.cView.frame = CGRectMake(CGRectGetWidth(self.scroll.frame)*i, 0, CGRectGetWidth(self.scroll.frame), CGRectGetHeight(self.scroll.frame));
            [self.scroll addSubview:self.cView];
            
            // 有了滚动视图本身的大小，一定不要忘了设置一下他所滚动的内容大小，这是他实现滚动的重要属性
            self.scroll.contentSize = CGSizeMake(CGRectGetMaxX(self.cView.frame), 0);
        }
        
        if (i==1) {
            self.hView.frame = CGRectMake(CGRectGetWidth(self.scroll.frame)*i, 0, CGRectGetWidth(self.scroll.frame), CGRectGetHeight(self.scroll.frame));
            [self.scroll addSubview:self.hView];
            
            // 有了滚动视图本身的大小，一定不要忘了设置一下他所滚动的内容大小，这是他实现滚动的重要属性
            self.scroll.contentSize = CGSizeMake(CGRectGetMaxX(self.hView.frame), 0);
        }
        
    }
    // 给内容 设置 开始的时候的偏移量
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

#pragma mark ========分页指示器懒加载======
- (UIPageControl *)pageControl{
    
    
    if (_pageControl==nil) {
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 120, CGRectGetWidth(self.scroll.frame), 40)];
        
        // _pageControl.backgroundColor = [UIColor blueColor];
        // 当前的页数
        _pageControl.currentPage = 0;
        // 总页数
        _pageControl.numberOfPages = 2;
        // 当前分页指示器的页的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        // 非当前分页指示器的页的颜色
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
        [self.view addSubview:_pageControl];
        
    }
    
    return _pageControl;
}

#pragma mark ========滚动视图懒加载======
- (UIScrollView *)scroll{
    
    if (_scroll == nil) {
        
        _scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        
        _scroll.backgroundColor = [UIColor whiteColor];
        // 分页滚动
        _scroll.pagingEnabled = YES;
        // 指示器的style 样式
        _scroll.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        // 隐藏底部滑动条
        _scroll.showsVerticalScrollIndicator = FALSE;
        _scroll.showsHorizontalScrollIndicator = FALSE;
        // 遵循代理
        _scroll.delegate = self;
        // 将滚动视图添加到当前的视图上
        [self.view addSubview:_scroll];
    }
    return _scroll;
}

-(ConnectVIew *)cView{
    if (!_cView) {
        _cView = [[ConnectVIew alloc] init];
    }
    return _cView;
}

-(HelpView *)hView{
    if (!_hView) {
        _hView = [[HelpView alloc] init];
    }
    return _hView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
