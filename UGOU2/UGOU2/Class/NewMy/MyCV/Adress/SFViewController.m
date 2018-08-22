//
//  SFViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/11/16.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.11.16.4.54 使用 反馈
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "SFViewController.h"
#import "UIImageView+WebCache.h"
#import "AFManger.h"
#import "Uikility.h"
#import "DgViewController.h"
#import "BassAPI.h"
@interface SFViewController ()<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UIView *headview;
    UITextField *ufield;
    UITextField *mfield;
    UITextView *textv;
    NSDictionary  *dic;
    NSString *url;
    
    UILabel *titlabel;
}
@end

@implementation SFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addnavview];
    
    // Do any additional setup after loading the view.
}
-(void)addnavview{
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    titlelabel.textColor=[UIColor whiteColor];
    
    titlelabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
    self.navigationItem.titleView=titlelabel;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    leftButton.tag=1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftButton;
    if (_flag==1) {
        titlelabel.text=@"使用帮助";
        [self addsyview];
    }else if (_flag==2){
        titlelabel.text=@"反馈信息";
        [self addfkview];
    }else if (_flag==3){
     titlelabel.text=@"关于我们";
        [self addgyview];
    }else if (_flag==4){
    titlelabel.text=@"评价";
        [self addpingj];
    }else if (_flag==5){
        titlelabel.text=@"退款-售后";
        [self addpingj];
        
    }
}
-(void)pop{
    if (_flag==4) {
        
        DgViewController *g=[[DgViewController alloc]init];
        g.flags=_flagsdg;
        g.flag=_flagdg;
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(_flag==5){
        DgViewController *g=[[DgViewController alloc]init];
        g.flags=_flagsdg;
        g.flag=_flagdg;
        [self.navigationController pushViewController:g animated:YES];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark  使用帮助
-(void)addsyview{
    UITextView *view=[[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.text=@"U购APP模块使用帮助(只限山东省内销售，其他地区不给发货，可退款)\n一.首页\n1.搜索。可搜索衣服名称、品牌等。\n2.类目。例如点开上衣，可显示全部上衣，可根据销量价格等排序。\n3.广告位。可查看广告，点开广告位后返回web格式活动页面。\n4.签到。点开后可进行签到，并可查看签到天数。\n5.上门试衣。选择附近门店-选择品牌-选择喜欢的商品-选择上门时间-生成订单-店铺收到订单通知，并与买确定订单是否还需修改商品和时间-支付（买家可线上支付，也可送货上门后选择下线支付）-完成-可评价，可申请售后。\n6.到店预订。选择附近门店-选择品牌-选择喜欢的商品-选择到店时间--生成订单-店铺收到订单通知，并与买家确定订单是否还需修改商品和时间-支付（买家可线上支付，也可到店后选择下线支付）-完成-可评价，可申请售后。\n7.U币。登录U币商城，可用U币兑换礼品。每消费1元获得1U币。\n8.潮流前线。展示单品，并可进行购买支付等\n9.最新活动。点开后返回web格式活动页面，可查看活动内容。\n10.推荐商品。可推荐品牌滞销款等，下拉显示20条。\n二． 品牌。\n点击品牌后进入品牌列表，进入某品牌后显示该品牌商品、活动内容等，商品可进行新品、价格、销量排序及筛选。\n三． 主题。\n点开后返回web格式活动页面，可查看活动内容。\n四． 我的。\n1. 可进行登录。注册。\n2. 可设置收货地址管理、清除缓存、关于我们、检查更新。\n3. 可查看收藏商品、品牌、历史足迹。\n4. 可查看待付款、待收货、待评论、退款/售后，并可进行操作。\n5. 查看所有订单。包含上门试衣、到店预订、普通订单。\n6. 我的U币。点进入后查看U币数量并同时进入U币商城。\n7. 我的卡券，将领取的所有卡券，例如优惠券、包邮券等呈现。\n8. 使用帮助。图片版显示特色功能。\n9. 反馈信息。提交反馈建议。\n";
    
    [self.view addSubview:view];
    
}
#pragma mark  反馈信息
-(void)addfkview{
    NSArray *arr=@[@"客户名:",@"联系方式:",@"反馈内容:"];
    for (int i=0; i<arr.count; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH+40*KIphoneWH*i,100*KIphoneWH, 30*KIphoneWH)];
        label.text=[arr objectAtIndex:i];
        [self.view addSubview:label];
    }
    
    mfield=[[UITextField alloc]initWithFrame:CGRectMake(100*KIphoneWH, 5*KIphoneWH, WIDTH-20*KIphoneWH, 30*KIphoneWH)];
    [mfield setBorderStyle:UITextBorderStyleNone];
    mfield.placeholder=@"客户名：";
    mfield.clearButtonMode=YES;
    mfield.delegate=self;
    mfield.tag=2;
    mfield.keyboardType=UIKeyboardTypeDefault;
    mfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    [self.view addSubview:mfield];
    
    
    ufield=[[UITextField alloc]initWithFrame:CGRectMake(100*KIphoneWH, 40*KIphoneWH, WIDTH-20*KIphoneWH, 30*KIphoneWH)];
    [ufield setBorderStyle:UITextBorderStyleNone];
    ufield.placeholder=@"联系方式：";
    ufield.clearButtonMode=YES;
    ufield.delegate=self;
    ufield.tag=1;
    ufield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
    ufield.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:ufield];
    
    
    textv=[[UITextView alloc]initWithFrame:CGRectMake(10*KIphoneWH, 120*KIphoneWH, WIDTH-20*KIphoneWH, 150*KIphoneWH)];
    [textv.layer setBorderWidth:1];
    [self.view addSubview:textv];
    textv.text=@"";
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH,HEIGHT -140*KIphoneWH, WIDTH-20*KIphoneWH, 60*KIphoneWH)];
    
    [but setImage:[UIImage imageNamed:@"确定@2x"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(pushfk:) forControlEvents:UIControlEventTouchUpInside];
    but.tag=1;
    [self.view addSubview:but];
}


//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textv resignFirstResponder];
     [ufield resignFirstResponder];
     [mfield resignFirstResponder];
}
#pragma mark  关于我们
-(void)addgyview{
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    [self addheadview];
    table.tableHeaderView=headview;
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=[UIColor whiteColor];
    table.tableFooterView=v;
}
#pragma mark
-(void)addheadview{
    headview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 100*KIphoneWH)];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 100*KIphoneWH, 100*KIphoneWH)];
    imageView.image=[UIImage imageNamed:@"uuu"];
    [headview addSubview:imageView];
    UILabel *leftlabel=[[UILabel alloc]initWithFrame:CGRectMake(120*KIphoneWH, 5*KIphoneWH, WIDTH-130*KIphoneWH, 100*KIphoneWH)];
    leftlabel.numberOfLines=0;
    leftlabel.text=@"     U购，为您提供足不出户的品牌购物体验，新品实时上架，专柜同步，正品保证，七天无理由退换货，让您躺在家里光品牌，全在办公室逛专卖店。";
    leftlabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [headview addSubview:leftlabel];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(60*KIphoneWH, 5*KIphoneWH, WIDTH-100*KIphoneWH, 40*KIphoneWH)];
    label.textAlignment=NSTextAlignmentRight;
    [cell addSubview:label];
    label.textColor=[UIColor greenColor];
    if(indexPath.row==0){
        cell.textLabel.text=@"官方微博";
        label.text=@"U购购物平台";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"官方微信";
        label.text=@"U购购物平台";
    }else if (indexPath.row==2){
        
        cell.textLabel.text=@"官方网站";
        label.text=@"www.ugouchina.com";
        
    }else if (indexPath.row==3){
        cell.textLabel.text=@"服务热线";
        label.text=@"400-966-7876";
    }
   // if (indexPath.row<2) {
        UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-30*KIphoneWH, 20*KIphoneWH, 15*KIphoneWH, 15*KIphoneWH)];
        imv.image=[UIImage imageNamed:@"向前"];
        [cell addSubview:imv];
        
    //}
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        
    }else if (indexPath.row==1){
        
    }
    
}
#pragma mark 评价
-(void)addpingj{
    
    titlabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, 150*KIphoneWH, 50*KIphoneWH)];
    [self.view addSubview:titlabel];
    textv=[[UITextView alloc]initWithFrame:CGRectMake(10*KIphoneWH, 60*KIphoneWH, WIDTH-20*KIphoneWH, 150*KIphoneWH)];
    [textv.layer setBorderWidth:1];
    [self.view addSubview:textv];
    if (_flag==4) {
        titlabel.text=@"评价：";
    }else{
        titlabel.text=@"退货理由：";
    }
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10*KIphoneWH,HEIGHT -140*KIphoneWH, WIDTH-20*KIphoneWH, 60*KIphoneWH)];
    
    [but setImage:[UIImage imageNamed:@"确定@2x"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(pushfk:) forControlEvents:UIControlEventTouchUpInside];
    but.tag=2;
    [self.view addSubview:but];
}

#pragma mark  反馈内容 确定
-(void)pushfk:(UIButton *)b{
    //if (b.tag==1) {
    [self json:(int)b.tag];
    //}
}
#pragma mark  数据
-(void)json:(int)i{
    
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    
    if ([de objectForKey:@"userId"]) {
         NSMutableDictionary *mudic=[Uikility creatSinGoMutableDictionary];
        if (i==1) {
            
            
            NSDictionary *d=nil;
            
            if ([de objectForKey:@"newUserId"]) {
                d=@{@"userId":[de objectForKey:@"userId"]
                    };
            }else{
                d=@{@"userId":[de objectForKey:@"userId"]
                    
                    };
            }
            
            NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
            //去掉空白格和换行符
            jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
            jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            [mudic setObject:jsond forKey:@"appuserId"];
             [mudic setObject:ufield.text forKey:@"contact"];
             [mudic setObject:mfield.text forKey:@"customername"];
             [mudic setObject:textv.text forKey:@"content"];
            
            
//            dic=@{@"sessionid":[de objectForKey:@"sessionid"],@"userId":[de objectForKey:@"userId"],@"newUserId":[de objectForKey:@"newUserId"],@"appuserId":jsond,@"contact":ufield.text,
//                  @"content":textv.text,@"customername ":mfield.text,@"model":@true,@"ios_version":VERSION
//                  };
           //反馈
            url=[BassAPI requestUrlWithPorType:PortTypeSavefeedback];
            
          
        }else if (i==2){
           
            //评价
            if (_flag==4) {
                url=[BassAPI requestUrlWithPorType:PortTypeSaveEvaluate];
                //退货
            }else{
                url=[BassAPI requestUrlWithPorType:PortTypeSaveCustomer];
                
            }
            
            NSDictionary *d1=@{
                               @"id":_ids
                               };
            NSData *jsonDatad1 = [NSJSONSerialization dataWithJSONObject:d1 options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsond1=[[NSString alloc] initWithData:jsonDatad1 encoding:NSUTF8StringEncoding];
            //去掉空白格和换行符
            jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsond1=[jsond1 stringByReplacingOccurrencesOfString:@" " withString:@""];
            jsond1=[jsond1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            NSDictionary *d=nil;
            if ([de objectForKey:@"newUserId"]) {
                 d=@{@"userId":[de objectForKey:@"userId"]};
            }else{
                d=@{@"userId":[de objectForKey:@"userId"]
                    };
            }
            
            NSData *jsonDatad = [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsond=[[NSString alloc] initWithData:jsonDatad encoding:NSUTF8StringEncoding];
            //去掉空白格和换行符
            jsond=[jsond stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsond=[jsond stringByReplacingOccurrencesOfString:@" " withString:@""];
            jsond=[jsond stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            NSMutableDictionary *mudic=[Uikility creatSinGoMutableDictionary];
            
            
            if (_flag==4) {
                
                [mudic setObject:@1 forKey:@"flag"];
                [mudic setObject:jsond forKey:@"appuserId"];
                [mudic setObject:textv.text forKey:@"content"];
                [mudic setObject:_attribute forKey:@"attribute"];
                
                
//                dic=@{@"uesrId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"appuserId":jsond, @"appgoodsId":jsond1,@"newUserId":[de objectForKey:@"newUserId"], @"flag":@1, @"content":textv.text, @"attribute":_attribute,@"model":@true,@"ios_version":VERSION
//                      };
            }else{
                [mudic setObject:jsond forKey:@"appuserId"];
                 [mudic setObject:jsond1 forKey:@"apporderId"];
                 [mudic setObject:textv.text forKey:@"content"];
                 [mudic setObject:@1 forKey:@"customerFlag"];
//                dic=@{@"uesrId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId" ],@"appuserId":jsond, @"apporderId":jsond1, @"content":textv.text,@"customerFlag":@1,@"model":@true,@"ios_version":VERSION
//                      };
            }
            
        }
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mudic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *json=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //去掉空白格和换行符
        json=[json stringByReplacingOccurrencesOfString:@" \"{\\" withString:@"{"];
        json=[json stringByReplacingOccurrencesOfString:@"userId\\" withString:@"userId"];
        json=[json stringByReplacingOccurrencesOfString:@"id\\" withString:@"id"];
        json=[json stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        json=[json stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@" " withString:@""];
        json=[json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSDictionary *json1=@{@"param":json
                              };
       
        [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            if (success) {
                if (i==1) {
                    [Uikility alert:@"谢谢您的反馈！"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else if (i==2){
                    if (_flag==4) {
                        [Uikility alert:@"谢谢评价！"];
                    }else{
                        [Uikility alert:@"申请退货成功！"];
                    }
                    
                    DgViewController *g=[[DgViewController alloc]init];
                    g.flags=_flagsdg;
                    g.flag=_flagdg;
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
            }else{
                [Uikility alert:[strs objectForKey:@"msg"]];
            }

            
        } failure:^(NSError *error) {
             [Uikility alert:@"连接失败！"];
        }];
    }else{
         [Uikility alert:@"请先登录！"];
    }
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
