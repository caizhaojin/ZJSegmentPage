//
//  ZJSegmentPageView.h
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSegmentPageView : UIScrollView

@property (copy, nonatomic) void ((^scrollAction)(NSInteger currentPage,CGFloat R_L_scale,CGFloat L_R_scale));

- (instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray *)controllers rootController:(UIViewController *)rootController;

- (void)scrollToIndex:(NSInteger)index;


@end
