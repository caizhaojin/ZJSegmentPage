//
//  ZJSegmentPage.h
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSegmentPage : UIView

- (instancetype)initWithFrame:(CGRect)frame tabTitles:(NSArray *)titles viewControllers:(NSArray *)controllers rootController:(UIViewController *)rootController;

@end
