//
//  HYSegmentedControl.m
//  CustomSegControlView
//
//  Created by sxzw on 14-6-12.
//  Copyright (c) 2014年 sxzw. All rights reserved.
//

#import "HYSegmentedControl.h"

#import "Uikility.h"
#define HYSegmentedControl_Height 30.0
#define Min_Width_4_Button 50.0

#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HYSegmentedControl()



@end

@implementation HYSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOriginY:(CGFloat)y width:(CGFloat)w color:(UIColor *)c Titles:(NSArray *)titles delegate:(id)delegate {
    CGRect rect4View = CGRectMake(.0f, y, w, HYSegmentedControl_Height);
    if (self = [super initWithFrame:rect4View]) {
        
        self.backgroundColor =[UIColor whiteColor];
        [self setUserInteractionEnabled:YES];
        
        self.delegate = delegate;
        if (_title) {
            titles=_title;
        }
        //
        //  array4btn
        //
        _array4Btn = [[NSMutableArray alloc] initWithCapacity:[titles count]];
        
        //
        //  set button
        //
        CGFloat width4btn = rect4View.size.width/[titles count];
        if (width4btn < Min_Width_4_Button) {
            width4btn = Min_Width_4_Button;
        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentSize = CGSizeMake([titles count]*width4btn, HYSegmentedControl_Height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        //_color=[UIColor colorWithRed:246/255.0 green:186/255.0 blue:90/255.0 alpha:1];
        for (int i = 0; i<[titles count]; i++) {
            
            _btn = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn.frame = CGRectMake(i*width4btn, .0f, width4btn, HYSegmentedControl_Height);
            [_btn setTitleColor:[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1] forState:UIControlStateNormal];
            _btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [_btn setTitleColor:c forState:UIControlStateSelected];
            [_btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [_btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            _btn.tag = Define_Tag_add+i;
            [_scrollView addSubview:_btn];
            [_array4Btn addObject:_btn];
            
            if (i == 0) {
                _btn.selected = YES;
            }
        }
        
        //
        //  lineView
        //
        CGFloat height4Line = HYSegmentedControl_Height/3.0f;
        CGFloat originY = (HYSegmentedControl_Height - height4Line)/2;
        for (int i = 1; i<[titles count]; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*width4btn-1.0f, originY, 1.0f, height4Line)];
            lineView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:lineView];
        }
        
        //
        //  bottom lineView
        //
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, HYSegmentedControl_Height-1, width4btn-10.0f, 1.0f)];
        _bottomLineView.backgroundColor = c;
        [_scrollView addSubview:_bottomLineView];
        
        [self addSubview:_scrollView];
    }
    return self;
}

//
//  btn clicked
//
- (void)segmentedControlChange:(UIButton *)btn
{
    btn.selected = YES;
    for (UIButton *subBtn in self.array4Btn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    
    CGRect rect4boottomLine = self.bottomLineView.frame;
    rect4boottomLine.origin.x = btn.frame.origin.x +5;
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 && [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
        pt.x = btn.frame.origin.x - Min_Width_4_Button*1.5f;
        canScrolle = YES;
    }else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]){
        pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
        canScrolle = YES;
    }else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2){
        pt.x = 0;
        canScrolle = YES;
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = pt;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.bottomLineView.frame = rect4boottomLine;
            }];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomLineView.frame = rect4boottomLine;
        }];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hySegmentedControlSelectAtIndex:)]) {
        [self.delegate hySegmentedControlSelectAtIndex:btn.tag - 1000];
    }
}



// delegete method
- (void)changeSegmentedControlWithIndex:(NSInteger)index
{
    if (index > [_array4Btn count]-1) {
        ////////////////////////NSLog(@"index 超出范围");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"index 超出范围" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        return;
    }
    
    UIButton *btn = [_array4Btn objectAtIndex:index];
    [self segmentedControlChange:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
