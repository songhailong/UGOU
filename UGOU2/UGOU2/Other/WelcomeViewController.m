//
//  WelcomeViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/2.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Uikility.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
-(instancetype)init{
    self=[super init];
    if (self!=nil) {
        [self createGuidancePageView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //[self createGuidancePageView];
}
-(void)createGuidancePageView{
    self.view.backgroundColor=[UIColor whiteColor];
        self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _guidancePageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _guidancePageScrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, HEIGHT);
        _guidancePageScrollView.showsHorizontalScrollIndicator = NO;
        _guidancePageScrollView.showsVerticalScrollIndicator = NO;
        _guidancePageScrollView.pagingEnabled = YES;
    
        for (int i = 0; i<3; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT)];
    
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"welcome%d@2x.jpg",i]];
           
            [_guidancePageScrollView addSubview:imageView];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH*2, 0, WIDTH, HEIGHT);
        [button addTarget:self action:@selector(deleteGuidancePageView) forControlEvents:UIControlEventTouchUpInside];
        [_guidancePageScrollView addSubview:button];
    
        [self.view addSubview:_guidancePageScrollView];
}

-(void)deleteGuidancePageView{
    [self.delegate showHomePage:self];
}

-(void)dealloc{
    
    self.delegate = nil;
    self.guidancePageScrollView = nil;
    
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
