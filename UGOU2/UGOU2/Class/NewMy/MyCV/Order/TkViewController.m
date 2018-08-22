//
//  TkViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/16.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.16.2.24 订单管理
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "TkViewController.h"
#import "Uikility.h"
@interface TkViewController ()<UITextFieldDelegate>{
    UITextField *sfield;
    UIView *rightview;
}

@end

@implementation TkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addserch];
    // Do any additional setup after loading the view.
}
#pragma mark  导航栏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addnavview];


}
-(void)addnavview{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40, 50)];
    titlelabel.textColor=[UIColor whiteColor];
    
    titlelabel.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=titlelabel;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    leftButton.tag=1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftButton;
    titlelabel.text=@"售后服务-订单列表";
    //[self addserch];
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addserch{
    //导航栏的搜索框
   // v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*KIphoneWH)];
   // v1.backgroundColor=[UIColor whiteColor];
   // [self.view addSubview:v1];
   /*
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-70*KIphoneWH, 30*KIphoneWH)];
    imgv.image=[UIImage imageNamed:@"搜索框"];
    [self.view addSubview:imgv];
    imgv.userInteractionEnabled=YES;
    
    sfield=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH-70*KIphoneWH, 30*KIphoneWH)];
    [imgv addSubview:sfield];
    sfield.delegate=self;
    sfield.clearButtonMode=YES;
    sfield.placeholder=@"商品名称，订单名称，订单编号";
    sfield.font=[UIFont systemFontOfSize:17*KIphoneWH];
    //sfield.leftViewMode=UITextFieldViewModeAlways;
    [self addview];
   // sfield.leftView=leftview;
    sfield.rightViewMode=UITextFieldViewModeAlways;
    sfield.rightView=rightview;
    UIButton *cancelbut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 0*KIphoneWH, 50*KIphoneWH, 40*KIphoneWH)];
    [self.view addSubview:cancelbut];
    [cancelbut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbut setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelbut addTarget:self action:@selector(butpush:) forControlEvents:UIControlEventTouchUpInside];
    cancelbut.tag=1;
    */

    UILabel *lanble=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 0, WIDTH-10*KIphoneWH, HEIGHT-200*KIphoneWH)];
    lanble.numberOfLines=0;
    lanble.text= @"七天退换货规则U购商品支持\n“七天退换货”，如需换货先退货，再由买家重新下单进行购买。退换货要求如下：\n1.	商品支持7天退换货。\n2.	因质量问题产生的退货，所有邮费由卖家承担，7天退货质量问题的界定为货品破损或残缺。\n3. 退货要求具备商品收到的完整包装（包含配饰）、水洗标、logo、吊牌、小票等；购买物品个人破坏不予退换。\n 4. 商品沾染油渍、异物、异味等不予退换。\n 5. 非商品质量问题的退换货，由买家承担运费。\n 6. 为避免由于商品在途中造成经济损失或产生其他纠纷，所有退货商品，买家需电话通知品牌发货方、并及时返回至指定地址。\n7. 退款于卖家收到商品后的1-7个工作日内退款，退款最终到账时间以银行办理时间为准。\n 8. 售后电话：400-966-7876（早9:00-晚17:00)";
    lanble.textColor=[UIColor blackColor];
    [self.view addSubview:lanble];
    

}
-(void)addview{
   /* rightview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30*KIphoneWH, 30*KIphoneWH)];
    // [v1 addSubview:leftview];
    
    UIImageView *imv1=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    imv1.image=[UIImage imageNamed:@"search2@2x"];
    [rightview addSubview:imv1];
    imv1.tag=1;
    imv1.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    [imv1 addGestureRecognizer:imgtap1];
    */
    

}
-(void)butpush:(UIButton *)b{

}
-(void)imvpush:(UITapGestureRecognizer *)g{
    

}
#pragma mark  tableview
-(void)addtableview{


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
