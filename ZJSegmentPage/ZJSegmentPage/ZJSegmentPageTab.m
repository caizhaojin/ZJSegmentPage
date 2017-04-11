//
//  ZJSegmentPageTab.m
//  ZJSegmentPage
//
//  Created by Choi on 2017/3/30.
//  Copyright © 2017年 CZJ. All rights reserved.
//

#import "ZJSegmentPageTab.h"

@interface ZJSegmentPageTab ()

@property (strong, nonatomic) UIView *btnContentView;
@property (strong, nonatomic) NSMutableArray *btns;
@property (strong, nonatomic) UIView *line;
@property (nonatomic) CGRect lineOriginframe;
@property (nonatomic) CGFloat totalBtnWidth;

@end

@implementation ZJSegmentPageTab

- (instancetype)initWithFrame:(CGRect)frame tabTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat totalBtnWidth = 0;
        
        UIView *btnContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:btnContentView];
        _btnContentView = btnContentView;
        
        
        NSMutableArray *btns = [NSMutableArray array];
        for (NSInteger i = 0; i < titles.count; i++) {
            
            UIButton *btn = [[UIButton alloc] init];
            [btn setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
            [btn sizeToFit];
            totalBtnWidth += btn.frame.size.width;
            btn.tag = i;
            if (i == 0) {
                btn.selected = YES;
            }
            [btn addTarget:self action:@selector(clickTabButton:) forControlEvents:UIControlEventTouchUpInside];
            [btnContentView addSubview:btn];
            [btns addObject:btn];
        }
        
        _btns = btns;
        _totalBtnWidth = totalBtnWidth;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        [btnContentView addSubview:line];
        _line = line;
        
        [self setupSubViewFrame:frame];
        
    }
    return self;
}
- (void)setupSubViewFrame:(CGRect)frame
{
    CGFloat contentWidth = frame.size.width - _totalBtnWidth;
    CGFloat margin = contentWidth / (_btns.count+1);
    
    for (NSInteger i = 0; i < _btns.count; i++) {
        UIButton *button = _btns[i];
        CGRect btnFrame = button.frame;
        btnFrame.size.height = frame.size.height;
        if (i == 0) {
            btnFrame.origin.x = margin + i*btnFrame.size.width + i*margin;
        } else {
            UIButton *lastBtn = _btns[i - 1];
            btnFrame.origin.x = CGRectGetMaxX(lastBtn.frame) + margin;
        }
        button.frame = btnFrame;
    }
    
    UILabel *btn = _btns[0];
    _line.frame = CGRectMake(0, CGRectGetMaxY(btn.frame) - 2, 26, 3);
    _line.center = CGPointMake(btn.center.x, _line.frame.origin.y);
    
    _lineOriginframe = _line.frame;
}

- (void)scrollCurrentPage:(NSInteger)currentPage rightScale:(CGFloat)r_l_scale leftScale:(CGFloat)l_r_scale
{
    NSArray *arr = _btns;
    if (currentPage < arr.count && currentPage >= 0) {
        
        UIView *currentView;
        CGFloat referWidth;
        if (currentPage == arr.count-1) {
            //最后一页的时候,参考宽度另外计算
            referWidth = ((UIView *)arr[currentPage]).center.x - ((UIView *)arr[currentPage - 1]).center.x;
        } else {
            referWidth = ((UIView *)arr[currentPage + 1]).center.x - ((UIView *)arr[currentPage]).center.x;
        }
        
        currentView = arr[currentPage];
        CGRect tempFrame = _line.frame;;
        if (l_r_scale < 0.5) {
            // 移动前百分之五十伸长全部，中心点右移动一半
            tempFrame.size.width = _lineOriginframe.size.width + l_r_scale*referWidth*2;
            
            for (UIButton *btn in arr) {
                btn.selected = NO;
            }
            UIButton *currentBtn = arr[currentPage];
            currentBtn.selected = YES;
            
        } else if (l_r_scale > 0.5){
            // 移后百分之五十缩短全部，中心点右移剩下的一半
            tempFrame.size.width = _lineOriginframe.size.width + (1 - l_r_scale) * referWidth*2;
            
            for (UIButton *btn in arr) {
                btn.selected = NO;
            }
            UIButton *currentBtn = arr[currentPage+1];
            currentBtn.selected = YES;
            
        } else {
            // 刚刚好一半的时候，给一个中间状态
            tempFrame.size.width = _lineOriginframe.size.width + referWidth;
        }
        
        _line.frame = tempFrame;
        _line.center = CGPointMake(currentView.center.x + l_r_scale * referWidth, _line.center.y);
        
    }
}

- (void)clickTabButton:(UIButton *)sender
{
    if (sender.isSelected) {
        return;
    }
    if (self.tabAction) {
        self.tabAction(sender.tag);
    }
}

- (void)dealloc
{
    NSLog(@"dealloc - pagetab");
}

@end
