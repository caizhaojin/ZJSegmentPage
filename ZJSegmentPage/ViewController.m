//
//  ViewController.m
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ViewController.h"
#import "ZJSegmentPage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"tab0", @"tab1", @"tab2", @"tab3"];
    
    UIViewController *vc0 = [[UIViewController alloc] init];
    vc0.view.backgroundColor = [UIColor lightGrayColor];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor darkGrayColor];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor blackColor];
    
    NSArray *controllers = @[vc0, vc1, vc2, vc3];
    
    ZJSegmentPage *segmentPage = [[ZJSegmentPage alloc] initWithFrame:self.view.frame tabTitles:titles viewControllers:controllers rootController:self];
    [self.view addSubview:segmentPage];
    
    
}





@end
