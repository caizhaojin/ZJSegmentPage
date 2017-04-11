//
//  ZJSegmentPageTab.h
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSegmentPageTab : UIView

@property (copy, nonatomic) void ((^tabAction)(NSInteger index));

- (instancetype)initWithFrame:(CGRect)frame tabTitles:(NSArray *)titles;

- (void)scrollCurrentPage:(NSInteger)currentPage rightScale:(CGFloat)r_l_scale leftScale:(CGFloat)l_r_scale;


@end
