//
//  UGSecuritydepositViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import "UGSecuritydepositViewController.h"
#import "UGCustomNavView.h"
#import "UGHeader.h"
@interface UGSecuritydepositViewController ()<UGCustomnNavViewDelegate>

@end

@implementation UGSecuritydepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _marginModel=[UGMarginModel copy];
    [self ug_creatUI];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UGCustomNavView* nav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    nav.Delegate=self;
    nav.title=@"报名交保证金";
    [nav setLeftImage:[UIImage imageNamed:@"返回p"]];
    [self.view addSubview:nav];
}
-(void)LeftItemAction{
    
}
-(void)ug_creatUI{
    
    UIButton *confirmBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, NavHeight-60*KIphoneWH, WIDTH, 60*KIphoneWH)];
    [confirmBtn setImage:[UIImage imageNamed:@"马上抢购"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"同意协议并缴纳保证金" forState:UIControlStateNormal];
    confirmBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [confirmBtn addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    //UITextView *textview=[[UITextView alloc] initWithFrame:CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
}
#pragma mark********点击同意
-(void)confirmButtonClick:(UIButton *)btn{
    
}
@end
