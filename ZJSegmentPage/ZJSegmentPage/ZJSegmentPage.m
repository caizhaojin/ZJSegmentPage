//
//  ZJSegmentPage.m
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ZJSegmentPage.h"
#import "ZJSegmentPageTab.h"
#import "ZJSegmentPageView.h"

@interface ZJSegmentPage ()

@property (strong, nonatomic) ZJSegmentPageTab *pageTab;
@property (strong, nonatomic) ZJSegmentPageView *pageView;

@end

@implementation ZJSegmentPage

- (instancetype)initWithFrame:(CGRect)frame tabTitles:(NSArray *)titles viewControllers:(NSArray *)controllers rootController:(UIViewController *)rootController
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect tabFrame = CGRectMake(0, 20, frame.size.width, 44);
        ZJSegmentPageTab *pageTab = [[ZJSegmentPageTab alloc] initWithFrame:tabFrame tabTitles:titles];
        [self addSubview:pageTab];
        _pageTab = pageTab;
        
        CGFloat scrollY = CGRectGetMaxY(pageTab.frame);
        CGRect scrollFrame = CGRectMake(0, scrollY+0.3, frame.size.width, frame.size.height - scrollY);
        ZJSegmentPageView *pageView = [[ZJSegmentPageView alloc] initWithFrame:scrollFrame viewControllers:controllers rootController:rootController];
        [self addSubview:pageView];
        _pageView = pageView;
        
        __weak __typeof(self)weakSelf = self;
        [pageView setScrollAction:^(NSInteger currentPage, CGFloat R_L_scale, CGFloat L_R_scale) {
            
            [weakSelf.pageTab scrollCurrentPage:currentPage rightScale:R_L_scale leftScale:L_R_scale];
        }];
        
        [pageTab setTabAction:^(NSInteger index) {
            [weakSelf.pageView scrollToIndex:index];
        }];
    }
    return self;
}




- (void)dealloc
{
    NSLog(@"dealloc - segmentpage");
}

@end
