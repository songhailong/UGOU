//
//  GuidancePageViewController.m
//  UgouAppios
//
//  Created by LHW on 16/1/26.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "GuidancePageViewController.h"
#import "Uikility.h"

@interface GuidancePageViewController ()

@end

@implementation GuidancePageViewController
-(instancetype)init{
    self=[super init];
    if (self!=nil) {
        [self createGuidancePageView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createGuidancePageView];

}
-(void)createGuidancePageView{
    //NSLog(@"hgvhgvhgvhvhgvghvhgvhgv");
    self.view.backgroundColor=[UIColor redColor];
//    self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
//    _guidancePageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    _guidancePageScrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, HEIGHT);
//    _guidancePageScrollView.showsHorizontalScrollIndicator = NO;
//    _guidancePageScrollView.showsVerticalScrollIndicator = NO;
//    _guidancePageScrollView.pagingEnabled = YES;
//    
//    for (int i = 0; i<3; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT)];
//        
//        //imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%d@2x.jpg",i]];
//        //NSLog(@"%@",imageView.image);
//        imageView.backgroundColor=[UIColor redColor];
//        [_guidancePageScrollView addSubview:imageView];
//    }
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT);
//    [button addTarget:self action:@selector(deleteGuidancePageView) forControlEvents:UIControlEventTouchUpInside];
//    [_guidancePageScrollView addSubview:button];
//    
//    [self.view addSubview:_guidancePageScrollView];
}

-(void)deleteGuidancePageView{
    [self.delegate showHomePage:self];
}

-(void)dealloc{
    
    self.delegate = nil;
    self.guidancePageScrollView = nil;

}
    
@end
