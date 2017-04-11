//
//  ZJSegmentPageView.m
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ZJSegmentPageView.h"

#define kKVOKEY_SCROLL_OBSERVER_CONTENTOFFSET @"contentOffset"

@interface ZJSegmentPageView ()

@property (strong, nonatomic) NSArray *controllers;
@property (weak, nonatomic) UIViewController *rootController;

@property (nonatomic) BOOL isAddDone;

@end

@implementation ZJSegmentPageView

- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray *)controllers rootController:(UIViewController *)rootController
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(frame.size.width * controllers.count, 0);
        [self layoutIfNeeded];
        [self addObserver:self forKeyPath:kKVOKEY_SCROLL_OBSERVER_CONTENTOFFSET options:NSKeyValueObservingOptionNew context:nil];
        self.contentOffset = CGPointMake(0, 0);
//        self.showsVerticalScrollIndicator = NO;
//        self.showsHorizontalScrollIndicator = NO;
        
        _controllers = controllers;
        _rootController = rootController;
        
        for (NSInteger i = 0; i<_controllers.count; i++) {
            UIViewController *vc = _controllers[i];
            CGRect vcFrame = vc.view.frame;
            vcFrame.origin.x = i*vcFrame.size.width;
            vcFrame.size.width = self.frame.size.width;
            vcFrame.size.height = self.frame.size.height;
            vc.view.frame = vcFrame;
            [self addSubview:vc.view];
            
            [_rootController addChildViewController:vc];
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    UIScrollView *scrollView = object;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger currentPage = (int)(currentOffsetX/scrollView.frame.size.width);
    
    CGFloat l_r_scale = 0;
    CGFloat r_l_scale = 0;
    
    CGFloat currentPageReferOffsetX = currentOffsetX -  currentPage * scrollView.frame.size.width;
    l_r_scale = currentPageReferOffsetX/scrollView.frame.size.width;
    r_l_scale = (scrollView.frame.size.width - currentPageReferOffsetX)/scrollView.frame.size.width;
    
    if (self.scrollAction) {
        self.scrollAction(currentPage,r_l_scale,l_r_scale);
    }
    
    if (!_isAddDone) {
        
        if (_rootController.childViewControllers.count >= _controllers.count) {
            _isAddDone = YES;
        } else {
            
//            if (_rootController.childViewControllers.count > currentPage) {
//                
//                id currentVC = _controllers[currentPage];
//                
//                id childVC = _rootController.childViewControllers[currentPage];
//                if ([currentVC isEqual:childVC]) {
//                    return;
//                }
//            }
//            UIViewController *vc = _controllers[currentPage];
//            CGRect vcFrame = vc.view.frame;
//            vcFrame.origin.x = currentPage*vcFrame.size.width;
//            vcFrame.size.width = self.frame.size.width;
//            vcFrame.size.height = self.frame.size.height;
//            vc.view.frame = vcFrame;
//            [self addSubview:vc.view];
//            
//            [_rootController addChildViewController:vc];
            
        }
    }
    
}

- (void)scrollToIndex:(NSInteger)index
{
    [self setContentOffset:CGPointMake(self.frame.size.width*index, 0) animated:NO];
}

- (void)dealloc
{
    NSLog(@"dealloc - pageview");
    [self removeObserver:self forKeyPath:kKVOKEY_SCROLL_OBSERVER_CONTENTOFFSET];
}


@end
