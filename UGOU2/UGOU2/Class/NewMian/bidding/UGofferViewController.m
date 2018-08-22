//
//  UGofferViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/23.
//

#import "UGofferViewController.h"
#import "UGHeader.h"
#import "BassAPI.h"
#import "SVProgressHUD.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"

@interface UGofferViewController (){
    //当前价格
    UILabel *_currentPLable;
    //减价按钮
    UIButton *_saleBtn;
    CGFloat _nowPrice;
}

@end

@implementation UGofferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ug_creatOfferUI];
}
-(void)ug_creatOfferUI{
    CGFloat topLbaleH=20*KIphoneWH;
    CGFloat spacingH=30*KIphoneWH;
    UILabel *topLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, topLbaleH)];
    topLable.textAlignment=NSTextAlignmentCenter;
    topLable.textColor=UGColor(93, 93, 93);
    topLable.text=[NSString stringWithFormat:@"最低价:¥%.1f",_lowPrice];
    [self.view addSubview:topLable];
    _saleBtn=[[UIButton alloc] initWithFrame:CGRectMake(spacingH, topLbaleH+spacingH, 60*KIphoneWH, 60*KIphoneWH)];
    _saleBtn.backgroundColor=UGColor(180, 211, 107);
    _saleBtn.layer.cornerRadius=30*KIphoneWH;
    NSString *pricestr=[NSString stringWithFormat:@"-%@",_offerPrice];
    [_saleBtn setTitle:pricestr forState:UIControlStateNormal];
    [_saleBtn addTarget:self action:@selector(leftsaleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_saleBtn];
    UIButton *premiumBtn=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH-spacingH-60*KIphoneWH, topLbaleH+spacingH, 60*KIphoneWH,60*KIphoneWH)];
    premiumBtn.backgroundColor=UGColor(180, 211, 107);
    premiumBtn.layer.cornerRadius=30*KIphoneWH;
    NSString *addprice=[NSString stringWithFormat:@"+%@",_offerPrice];
    [premiumBtn setTitle:addprice forState:UIControlStateNormal];
    [premiumBtn addTarget:self action:@selector(rightPremiumAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:premiumBtn];
    CGFloat currentW=100*KIphoneWH;
    _currentPLable=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-currentW/2, topLbaleH+spacingH, currentW, 60*KIphoneWH)];
    _currentPLable.textAlignment=NSTextAlignmentCenter;
    _nowPrice=self.lowPrice;
    _currentPLable.text=[NSString stringWithFormat:@"¥%.1f",_nowPrice];
    _currentPLable.font=[UIFont systemFontOfSize:24*KIphoneWH];
    [self.view addSubview:_currentPLable];
    UIButton *determineBtn=[[UIButton alloc] initWithFrame:CGRectMake(10*KIphoneWH, 150*KIphoneWH, WIDTH-20*KIphoneWH, 40*KIphoneWH)];
    //[determineBtn setTitle:@"" forState:UIControlStateNormal];
    [determineBtn setTitle:@"确定出价" forState:UIControlStateNormal];
    [determineBtn addTarget:self action:@selector(determineAction) forControlEvents:UIControlEventTouchUpInside];
    [determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineBtn setBackgroundColor:[UIColor colorWithRed:233/255.0 green:54/255.0  blue:36/255.0  alpha:1]];
    determineBtn.titleLabel.font=[UIFont systemFontOfSize:18*KIphoneWH];
    [self.view addSubview:determineBtn];
}
#pragma mark******减价
-(void)leftsaleAction{
    if (_nowPrice>_lowPrice) {
        _nowPrice=_nowPrice-_offerPrice.floatValue;
         _currentPLable.text=[NSString stringWithFormat:@"¥%.1f",_nowPrice];
    }else{
          [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"你的出价要大于最低价"];
        [SVProgressHUD dismissWithDelay:2.0];
    }
}
#pragma mark*****点击加价
-(void)rightPremiumAction{
   
    _nowPrice=_nowPrice+_offerPrice.floatValue;
    _currentPLable.text=[NSString stringWithFormat:@"¥%.1f",_nowPrice];
    
    
}
#pragma mark******确定出价
-(void)determineAction{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    if (_nowPrice<_lowPrice) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"当前价要大于最低价"];
        return;
    }
    NSString *url=[BassAPI requestUrlWithPorType:portTypeGiveInsertPrice];
    NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
    NSNumber *nowpeicenum=[NSNumber numberWithFloat:_nowPrice];
    [dic setObject:nowpeicenum forKey:@"sePrice"];
    [dic setObject:self.auctionId forKey:@"auctionId"];
   NSString *postdic=[Uikility initWithdatajsonstring:dic];
    
    NSString *asestr=[SecurityUtil encryptAESData:postdic passwordKey:[de objectForKey:COOKIE]];
    
    NSDictionary*  json1=@{@"param":asestr};
    
    NSString * userid=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
    
    NSString *bassuser=[GTMBase64 encodeBase64String:userid];
    
//    [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
//        id  object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"出价%@",object);
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"当前网速不佳"];
//    }];
    [AFManger headerFilePostWithURLString:url parameters:json1 Hearfile:bassuser success:^(id responseObject) {
        [SVProgressHUD dismiss];
        id  object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dateDic=[object objectForKey:@"data"];
        
        BOOL issucess=[[object objectForKey:@"success"] boolValue];
        if (issucess) {
            //NSLog(@"%@",object);
            [SVProgressHUD showSuccessWithStatus:@"出价成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:2.0];
            [[ NSNotificationCenter defaultCenter] postNotificationName:fullScreenbiddingNotice object:dateDic];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:[object objectForKey:@"msg"]];
            [SVProgressHUD dismissWithDelay:2.0];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网速不给力"];
        [SVProgressHUD dismissWithDelay:2.0];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    //发送通知要移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
