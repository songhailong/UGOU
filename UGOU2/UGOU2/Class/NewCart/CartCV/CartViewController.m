//
//  CartViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/9/30.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.10.26.9.24 购物车
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "CartViewController.h"
#import "AFManger.h"
#import "PlaceViewController.h"
#import "LoginViewController.h"
//#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "LPLabel.h"

#import "DingdanViewController.h"
#import "CartModel.h"
#import "Uikility.h"
#import "CartTableViewCell.h"
#import "BassAPI.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "DiscountModel.h"
#import "AllcardModel.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"
#import "VipOrCartTableViewCell.h"
#import "DiscountCalculation.h"
#import "ZheKouModel.h"
#import "LocateFailureView.h"
#import "UGHeader.h"
@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,VipCardDelegate,UGCustomnNavViewDelegate>{
    //底部view
    UIView *toolbar;
    UIView *headview;
    
    NSString *url;
    
    //NSString * shopcartId;
    int zf;
    NSUserDefaults *de;
    NSString *addressId;
    UIButton *b2;
     UIButton *_allbutton;
    UITableView *_table;
    UIView *_view;
    NSMutableArray *_dataarray;
    UIImageView *_imageview;
    CGFloat _price;
    UILabel *_pricelable;
    UIButton *_but;
    NSArray *muarr;
    UIButton *_leftbut1;
    UIButton *_centbutton;
    UIView *_selectview;
    //存储头视图选中个数
    NSMutableArray *_heararr;
    //存储编辑
    NSMutableArray *_Editorarr;
    //品牌普通满几件折扣
    NSDictionary * shopcartDiscountdic;
    //vip满件折扣
    NSDictionary *vipShopcartDiscount;
    //普通满件折扣
    NSDictionary *ordinaryShopcartDiscount;
    NSMutableArray *_selectgoos;
    
    NSMutableArray *_sdSelectGoos;
    
    //
    NSMutableArray *_allSelectGoods;
    NSMutableArray *_discountIdarr;
    NSMutableArray *  _ordinaarr;
    NSMutableArray * _viparr;
    CGFloat _vipallp;
    CGFloat _ordinall;
    NSInteger selectrows;
    BOOL IsEidingaAll;
    
    UIButton * rightButton;
    
    NSDictionary *ZKordinaryDic;
    NSDictionary *ZkVIPDic;
    
    ZheKouModel *ZKModel;
    
    LocateFailureView *_locaFailureView;
}
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    zf=0;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    de=[NSUserDefaults standardUserDefaults];
//    _dataarray=[[NSMutableArray alloc] init];
//    _fistarray=[[NSMutableArray alloc] init];
//    _flag=1;
    //[self addtable];
    //[self json];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden =YES;

    

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden =YES;
    zf=0;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    de=[NSUserDefaults standardUserDefaults];
    _dataarray=[[NSMutableArray alloc] init];
    _selectgoos=[[NSMutableArray alloc] init];
    _discountIdarr=[[NSMutableArray alloc] init];
    _viparr=[[NSMutableArray alloc] init];
    _ordinaarr=[[NSMutableArray alloc] init];
    _sdSelectGoos=[[NSMutableArray alloc] init];
    _allSelectGoods=[[NSMutableArray alloc] init];
    _flag=1;
    [self adddaohanglan];
     _selectview.alpha=0;
    _price=0;
    _pricelable.text=[NSString stringWithFormat:@"￥%d",0];
    [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
    [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
    
    if ([de objectForKey:@"placename"]) {
        [self addtable];
        [self json];
    }else{
    
        [self creatfailView];
    }
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSucess:) name:@"locationSucess" object:nil];
}
-(void)locationSucess:(NSNotification *)notifi{
    _locaFailureView.alpha=0;
    [self addtable];
    [self json];

}
-(void)creatfailView{
    _locaFailureView=[[LocateFailureView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-40)];
    [self.view addSubview:_locaFailureView];

}
#pragma mark 导航栏
-(void)adddaohanglan{
   
    if (iPhoneX) {
      _centbutton=[[UIButton alloc]initWithFrame:CGRectMake(60*KIphoneWH, 44,WIDTH-120*KIphoneWH, 44)];
    }else{
        
        _centbutton=[[UIButton alloc]initWithFrame:CGRectMake(60*KIphoneWH, 20*KIphoneWH,WIDTH-120*KIphoneWH, 44*KIphoneWH)];
    }

    [_centbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_centbutton addTarget:self action:@selector(pushtable:) forControlEvents:UIControlEventTouchUpInside];
    
    //[_imageview addSubview:_centbutton];
    _centbutton.titleLabel.font=[UIFont systemFontOfSize:24*KIphoneWH];
    if (_flag==2) {
        [_centbutton setTitle:@"到店购物车" forState:UIControlStateNormal];
    }else if (_flag==3){
        [_centbutton setTitle:@"上门购物车" forState:UIControlStateNormal];
    }else{
        [_centbutton setTitle:@"购物车" forState:UIControlStateNormal];
    }
    [_centbutton setImage:[UIImage imageNamed:@"展开三角.png"] forState:UIControlStateNormal];
    UGCustomNavView *custemNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    [custemNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    custemNav.custemView=_centbutton;
    [custemNav.RightButton setTitle:@"编辑全部" forState:UIControlStateNormal];
    custemNav.RightButton.titleLabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    [self.view addSubview:custemNav];
    if (_back) {
        custemNav.Delegate=self;
        [custemNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    }
   
}
-(void)rightItemAction{
    
    [self pushpop];
}
#pragma mark----选择购物车
-(void)pushtable:(UIButton *)button{
    if(button.selected==NO){
        _selectview.alpha=1;
        button.selected=YES;
    }else{
        _selectview.alpha=NO;
        button.selected=NO;
        
    }
}
# pragma mark----- 编辑全部
-(void)editorAll:(UIButton *)button{
    if (button.selected==NO) {
        //_table.allowsMultipleSelectionDuringEditing=NO;
        //_table.editing=NO;
        IsEidingaAll=YES;
        [button setTitle:@"完成" forState:UIControlStateNormal];
        if (_block) {
            _block(@"完成");
        }
        button.selected=YES;
    }else{
        //_table.allowsMultipleSelectionDuringEditing=YES;
        //_table.editing=YES;
        IsEidingaAll=NO;
        [button setTitle:@"编辑全部" forState:UIControlStateNormal];
        if (_block) {
            _block(@"编辑");
        }
        button.selected=NO;
    }
    [_table reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    _imageview.hidden=YES;
}
#pragma mark 导航栏点击返回
-(void)pushpop{
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 全选
-(void)pushall:(UIButton *)b{
    if (_allbutton.selected==NO) {
       [self tablecellselectall];
        NSMutableArray *select=[Uikility calculateCellSelectAlldata:_dataarray];
        _price=[Uikility calculateAllPriceGoods:select];
        _pricelable.text=[NSString stringWithFormat:@"%.1f",_price];
        _allbutton.selected=YES;
        [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-可选"] forState:UIControlStateNormal];
        NSInteger selctnow=select.count;
        [_but setTitle:[NSString stringWithFormat:@"结算(%zd)",selctnow] forState:UIControlStateNormal];
        // 满几件折扣
        //会员分类分类
        NSMutableArray *ordier=[Uikility calculateSelelctCellordinary:select];
        NSMutableArray *vipgoods=[Uikility calculateSelelctCellVIP:select];
        //按品牌分类后的数组
        NSMutableArray *brandordier=[Uikility goodtoBrandificationarr:ordier];
        NSMutableArray *brandvip=[Uikility goodtoBrandificationarr:vipgoods];
        
        //得到满件折扣的模型数组
        _discountIdarr= [DiscountCalculation fullDiscountCalculationOrderData:brandordier VipData:brandvip OrderDiscountDic:ordinaryShopcartDiscount VIPDiscountDic:vipShopcartDiscount pageFlag:1];
        //扣钱
        for (DiscountModel *discounmodel in _discountIdarr) {
            
            _price=_price-discounmodel.money.intValue;
            _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
            
        }
        //满件打折后价钱
        ZKModel=[DiscountCalculation fullCountZheKouOrderArray:brandordier VipArr:brandvip orderZhekouDic:ZKordinaryDic vipZheKouDic:ZkVIPDic money:_discountIdarr];
        
        _price=_price-ZKModel.ZKPrice.floatValue;
        _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
        
        
        
        
        
    }else{
    if (_dataarray.count) {
       _allbutton.selected=NO;
        
        [self cellcancelall];
        _price=0;
        _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
        [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
        [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
   }
    }
    [_table reloadData];

}

#pragma mark*****全部选中
-(void)tablecellselectall{
    
    for (int i=0;i<_dataarray.count;i++)
    {
        AllcardModel *allmodel=_dataarray[i];
    for (int j=0;j<allmodel.goods.count;j++) {
            NSMutableArray *brandArr=allmodel.goods[j];
        
            for (int k=0;k<brandArr.count;k++) {
                CartModel *model=brandArr[k];
                model.editing=YES;
                [brandArr replaceObjectAtIndex:k withObject:model];
            }
            [allmodel.goods replaceObjectAtIndex:j withObject:brandArr];
        }
        [_dataarray replaceObjectAtIndex:i withObject:allmodel];
    }
    
    
    [_table reloadData];
    
    
}
#pragma mark******全部取消
-(void)cellcancelall{
    for (int i=0;i<_dataarray.count;i++)
    {
        AllcardModel *allmodel=_dataarray[i];
        
        
        for (int j=0;j<allmodel.goods.count;j++) {
            NSMutableArray *brandArr=allmodel.goods[j];
            for (int k=0;k<brandArr.count;k++) {
                CartModel *model=brandArr[k];
                model.editing=NO;
                [brandArr replaceObjectAtIndex:k withObject:model];
            }
            [allmodel.goods replaceObjectAtIndex:j withObject:brandArr];
            
        }
        [_dataarray replaceObjectAtIndex:i withObject:allmodel];
        
    }
    
    [_table reloadData];
    
}

#pragma mark 行
-(void)pushrow:(UIButton *)b{
    b.selected++;
}
#pragma mark tableview
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_dataarray.count==0) {
        return 0;
    }
    return 30*KIphoneWH;// 设置每组头部视图高度
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0*KIphoneWH;// 设置每组头部视图高度
}
#pragma mark 品牌
-(void)pushbrand:(UIButton *)b{
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*view=[[UIView alloc] init];
    view.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 0, WIDTH-20*KIphoneWH, 30*KIphoneWH)];
    lable.textColor=[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255 alpha:1];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    if(_dataarray.count){
    
    AllcardModel *allmodel=_dataarray[section];
        
        if (allmodel.vipFlag) {
           lable.text=@"VIP购物车";
        }else{
        
        lable.text=@"普通购物车";

        }
    }
    [view addSubview:lable];
    return view;
}

-(void)addtable{
   #pragma mark 第一个 view
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-49-NavHeight)];
   
    _table.delegate=self;
    _table.dataSource=self;
    _table.rowHeight=100*KIphoneWH;
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_table registerClass:[VipOrCartTableViewCell class]forCellReuseIdentifier:@"qqq"];
        [self.view addSubview:_table];
    _selectview=[[UIView alloc] initWithFrame:CGRectMake(100*KIphoneWH, NavHeight, WIDTH-200*KIphoneWH, 150*KIphoneWH)];
    _selectview.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    for (int i=0; i<3; i++) {
        NSArray *array=@[@"购物车",@"到店购物车",@"上门购物车"];
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0, 50*i*KIphoneWH, WIDTH-200*KIphoneWH, 50*KIphoneWH)];
        button.tag=i+100;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selecttoptitle:) forControlEvents:UIControlEventTouchUpInside];
        [_selectview addSubview:button];
    }
    _selectview.alpha=0;
    [self.view addSubview:_selectview];
    [self addtoolbar];
}
#pragma mark---购物车选择弹出
-(void)selecttoptitle:(UIButton *)button{
       _selectview.alpha=0;
    NSArray *array=@[@"购物车",@"到店购物车",@"上门购物车"];
        [_centbutton setTitle:array[button.tag-100] forState:UIControlStateNormal];
        _flag=button.tag-99;
        [self json];
    _centbutton.selected=NO;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dataarray.count==0) {
        return 0;
    }
   
    return _dataarray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_dataarray.count){
        CGFloat all=0;
        AllcardModel *model=_dataarray[indexPath.section];
        for (NSArray *arr in model.goods ) {
            
            all=all+50*KIphoneWH;
            all=arr.count*100*KIphoneWH+all;
        }
       
        return all;
    }
    return  0;

}
#pragma mark  赋值cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VipOrCartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"qqq" forIndexPath:indexPath];
    cell.celltag=indexPath.section;
    cell.delegate=self;
    if (_dataarray.count) {
       AllcardModel *allmodel=_dataarray[indexPath.section];
        if (allmodel.vipFlag) {
            cell.discountDic=vipShopcartDiscount;
        }else{
            cell.discountDic=ordinaryShopcartDiscount;
        }
        
        
        [cell reloadtabview:allmodel.goods isEidingAll:IsEidingaAll];
    }
    return cell;
    
}
#pragma mark ***Cell选中和取消的代理
-(void)selectCellindexarr:(NSArray *)indexarr indexPath:(NSIndexPath *)indexPath cellTag:(NSInteger)cellTag IsSelect:(BOOL)IsSelect{
    //改变模型
    AllcardModel *allmodel=_dataarray[cellTag];
    NSMutableArray*goodarr=allmodel.goods[indexPath.section];
    CartModel *model=goodarr[indexPath.row];
    model.editing=!model.isediting;
    [goodarr replaceObjectAtIndex:indexPath.row withObject:model];
    [allmodel.goods replaceObjectAtIndex:indexPath.section withObject:goodarr];
    [_dataarray replaceObjectAtIndex:cellTag withObject:allmodel];
   // NSMutableArray *brandmuarr=[[NSMutableArray alloc] init];
    _price=0;
    [_allSelectGoods removeAllObjects];
    NSMutableArray *select=[Uikility calculateCellSelectAlldata:_dataarray];
    _price=[Uikility calculateAllPriceGoods:select];

    _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
    selectrows=select.count;
    if ( selectrows) {
        
        [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-可选"] forState:UIControlStateNormal];
        
        [_but setTitle:[NSString stringWithFormat:@"结算(%zd)", selectrows] forState:UIControlStateNormal];
    }else{
        
        [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
        [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
    }
    // 满几件折扣
    //会员分类分类
    NSMutableArray *ordier=[Uikility calculateSelelctCellordinary:select];
    NSMutableArray *vipgoods=[Uikility calculateSelelctCellVIP:select];
    //按品牌分类后的数组
    NSMutableArray *brandordier=[Uikility goodtoBrandificationarr:ordier];
    NSMutableArray *brandvip=[Uikility goodtoBrandificationarr:vipgoods];
    
    //得到满件折扣的模型数组
    _discountIdarr= [DiscountCalculation fullDiscountCalculationOrderData:brandordier VipData:brandvip OrderDiscountDic:ordinaryShopcartDiscount VIPDiscountDic:vipShopcartDiscount pageFlag:1];
    //扣钱
    for (DiscountModel *discounmodel in _discountIdarr) {
        
        _price=_price-discounmodel.money.intValue;
        _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
        
    }
    //满件后打折扣多少钱
    ZKModel=[DiscountCalculation fullCountZheKouOrderArray:brandordier VipArr:brandvip orderZhekouDic:ZKordinaryDic vipZheKouDic:ZkVIPDic money:_discountIdarr];
    
    
    //计算价格
    _price=_price-ZKModel.ZKPrice.floatValue;
    _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
    
}
#pragma mark*******头视图选中和取消的代理
-(void)heardViewSelectSection:(NSInteger)Section cellTag:(NSInteger)cellTag IsSelect:(BOOL)IsSelect{
    AllcardModel *allmodel=_dataarray[cellTag];
    NSMutableArray*goodarr=allmodel.goods[Section];
    for (CartModel *model in goodarr) {
        model.editing=IsSelect;
    }
    [allmodel.goods replaceObjectAtIndex:Section withObject:goodarr];
    [_dataarray replaceObjectAtIndex:cellTag withObject:allmodel];
    NSMutableArray *select=[Uikility calculateCellSelectAlldata:_dataarray];
    _price=[Uikility calculateAllPriceGoods:select];
    
    _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
    selectrows=select.count;
    if ( selectrows) {
        
        [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-可选"] forState:UIControlStateNormal];
        
        [_but setTitle:[NSString stringWithFormat:@"结算(%zd)", selectrows] forState:UIControlStateNormal];
    }else{
        
        [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
        [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
    }
    // 满几件折扣
    //会员分类分类
    NSMutableArray *ordier=[Uikility calculateSelelctCellordinary:select];
    NSMutableArray *vipgoods=[Uikility calculateSelelctCellVIP:select];
    //按品牌分类后的数组
    NSMutableArray *brandordier=[Uikility goodtoBrandificationarr:ordier];
    NSMutableArray *brandvip=[Uikility goodtoBrandificationarr:vipgoods];
    
    //得到满件折扣的模型数组
    _discountIdarr= [DiscountCalculation fullDiscountCalculationOrderData:brandordier VipData:brandvip OrderDiscountDic:ordinaryShopcartDiscount VIPDiscountDic:vipShopcartDiscount pageFlag:1];
    //扣钱
    for (DiscountModel *discounmodel in _discountIdarr) {
        
        _price=_price-discounmodel.money.intValue;
        _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
        
    }
    //满件后打折扣多少钱
    ZKModel=[DiscountCalculation fullCountZheKouOrderArray:brandordier VipArr:brandvip orderZhekouDic:ZKordinaryDic vipZheKouDic:ZkVIPDic money:_discountIdarr];
    _price=_price-ZKModel.ZKPrice.floatValue;
    _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
    
    
}
#pragma mark******删除代理
-(void)removecellindex:(NSNumber *)cardGoodsId indexPath:(NSIndexPath *)indexPath cellTag:(NSInteger)cellTag{
    if ([de objectForKey:@"sessionid"]) {
        // 购物车删除数据
        NSMutableDictionary *jsondic=[Uikility creatSinGoMutableDictionary];
        
        
        if (_flag==1) {
            
            url=[BassAPI requestUrlWithPorType:PortTypeDeletpuCart];
            
            [jsondic setObject:cardGoodsId forKey:@"shopcartId"];
        }else if (_flag==2){
            
            url=[BassAPI requestUrlWithPorType:PortTypeDeletecart];
            [jsondic setObject:cardGoodsId forKey:@"appyyshopcartId"];

        }else if (_flag==3){
            //上门
            url=[BassAPI requestUrlWithPorType:PortTypeDeleteComecart];
            [jsondic setObject:cardGoodsId forKey:@"appsmshopcartId"];
            
        }
        
        NSDictionary *dicss=[Uikility initWithdatajson:jsondic];
        
        [AFManger postWithURLString:url parameters:dicss success:^(id responseObject) {
            id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            
            if (success) {
                if (_dataarray.count) {
                    AllcardModel *allmodel=_dataarray[cellTag];
                    
                    NSMutableArray *arrayse=[allmodel.goods objectAtIndex:indexPath.section];
                    [arrayse removeObjectAtIndex:indexPath.row];
                    
                    if (arrayse.count==0) {
                        [allmodel.goods removeObjectAtIndex:indexPath.section];
                    }
                    
                    if (allmodel.goods.count==0) {
                        [_dataarray removeObjectAtIndex:cellTag];
                    }
                }
               
                
                
                NSMutableArray *select=[Uikility calculateCellSelectAlldata:_dataarray];
                _price=[Uikility calculateAllPriceGoods:select];
                
                _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
                selectrows=select.count;
                if ( selectrows) {
                    
                    [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-可选"] forState:UIControlStateNormal];
                    
                    [_but setTitle:[NSString stringWithFormat:@"结算(%zd)", selectrows] forState:UIControlStateNormal];
                }else{
                    
                    [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
                    [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
                }
                // 满几件折扣
                //数组按品牌分类
           
                NSMutableArray *ordier=[Uikility calculateSelelctCellordinary:select];
                NSMutableArray *vipgoods=[Uikility calculateSelelctCellVIP:select];
                    //遍历按品牌分类后的数组
                NSMutableArray *brandordier=[Uikility goodtoBrandificationarr:ordier];
                NSMutableArray *brandvip=[Uikility goodtoBrandificationarr:vipgoods];
                
            //返回满件折扣的模型数组
         _discountIdarr= [DiscountCalculation fullDiscountCalculationOrderData:brandordier VipData:brandvip OrderDiscountDic:ordinaryShopcartDiscount VIPDiscountDic:vipShopcartDiscount pageFlag:1];
            
                for (DiscountModel *discounmodel in _discountIdarr) {
                    
                    _price=_price-discounmodel.money.intValue;
                    _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
                
                }
        //满件打折后扣多少钱
       ZKModel=[DiscountCalculation fullCountZheKouOrderArray:brandordier VipArr:brandvip orderZhekouDic:ZKordinaryDic vipZheKouDic:ZkVIPDic money:_discountIdarr];
                //满件打折后的价格
                _price=_price-ZKModel.ZKPrice.floatValue;
            _pricelable.text=[NSString stringWithFormat:@"￥%.1f",_price];
            [rightButton setTitle:@"编辑全部" forState:UIControlStateNormal];
                rightButton.selected=NO;
                IsEidingaAll=NO;
                
            [_table reloadData];
        }else{
                
                [Uikility alert:[strs objectForKey:@"msg"]];
                
            }
            
        } failure:^(NSError *error) {
            [Uikility alert:@"数据接受失败！"];
        }];
    }



}

#pragma mark 底部
-(void)addtoolbar{
    toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-(49+50*KIphoneWH), WIDTH, 50*KIphoneWH)];
    toolbar.alpha=1;
    toolbar.backgroundColor=[UIColor colorWithRed:241/255.0 green:239/255.0 blue:239/255.0 alpha:1];
     _allbutton=[[UIButton alloc]initWithFrame:CGRectMake(2*KIphoneWH, 12*KIphoneWH, 25*KIphoneWH, 25*KIphoneWH)];
    [toolbar addSubview:_allbutton];
    toolbar.userInteractionEnabled=YES;
    [_allbutton setImage:[UIImage imageNamed:@"选择圆圈-未选中"] forState:UIControlStateNormal];
    [_allbutton setImage:[UIImage imageNamed:@"选择圆圈-选中"] forState:UIControlStateSelected];
    [_allbutton addTarget:self action:@selector(pushall:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30*KIphoneWH, 5*KIphoneWH,100*KIphoneWH, 40*KIphoneWH)];
    label.text=@"全选";
    //233，94，75
    [toolbar addSubview:label];
   _pricelable=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-200*KIphoneWH, 5*KIphoneWH, 90*KIphoneWH, 20*KIphoneWH)];
   _pricelable.text=[NSString stringWithFormat:@"￥%d",0];
    _pricelable.textAlignment=NSTextAlignmentCenter;
    _pricelable.textColor=[UIColor redColor];
    //233，94，75
  _pricelable.font=[UIFont systemFontOfSize:16*KIphoneWH weight:1.5*KIphoneWH];
    [toolbar addSubview:_pricelable];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-190*KIphoneWH, 25*KIphoneWH, 70*KIphoneWH, 20*KIphoneWH)];
    label2.text=@"不含其他费用";
    label2.font=[UIFont systemFontOfSize:10*KIphoneWH];
    //233，94，75
    [toolbar addSubview:label2];
    _but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-100*KIphoneWH, 0, 90*KIphoneWH, 50*KIphoneWH)];
    
    [toolbar addSubview:_but];
    [_but addTarget:self action:@selector(pushdingdan) forControlEvents:UIControlEventTouchUpInside];
    [_but setBackgroundImage:[UIImage imageNamed:@"结算底框-不能选时"] forState:UIControlStateNormal];
    [_but setTitle:@"结算(0)" forState:UIControlStateNormal];
    [_but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:toolbar];
}
#pragma mark  结算按钮
-(void)pushdingdan{
    
    if (_price==0) {
        [Uikility alert:@"没有商品！"];
    }else{
        DingdanViewController *d=[[DingdanViewController alloc]init];
        
        NSMutableArray *selectArr=[Uikility calculateCellSelectAlldata:_dataarray];
        
        NSMutableArray *brandArr=[Uikility goodtoBrandificationarr:selectArr];
         NSInteger gs3=0;
        for (CartModel *model in selectArr) {
             gs3=gs3+ model.quantity;
        }
        
        
        d.array=brandArr;
        d.allprice=_price;
        d.gs=gs3;
        d.IsCart=YES;
        d.flag=_flag;
        d.discountIds=_discountIdarr;
        d.ZheKouIDs=ZKModel.ZKDisCounts;
        [self.navigationController pushViewController:d animated:YES];
    
    }
    
}
#pragma mark 数据  json 解析
-(void)json{
    [_dataarray removeAllObjects];
    [_ordinaarr removeAllObjects];
    [_viparr removeAllObjects];
    if ([de objectForKey:@"sessionid"]) {
                     //解析数据
            if (_flag==1) {
                url=[BassAPI requestUrlWithPorType:PortTypeNewSelectCart];
             //到店
            }else if (_flag==2){
          url=[BassAPI requestUrlWithPorType:PortTypeIDMakecart];
            }
     // 上门
            else if (_flag==3){
         
                url=[BassAPI requestUrlWithPorType:PortTypeIDComecart];
            
            
            }
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc] init];
        [dic1 setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [dic1 setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
            [dic1 setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
       
        [dic1 setObject:@true forKey:@"model"];
        [dic1 setObject:VERSION forKey:@"ios_version"];
        
        if([de objectForKey:@"placename"]){
        [dic1 setObject:[de objectForKey:@"placename"] forKey:@"area"];
        }
      NSString *urlss=[Uikility initWithdatajsonstring:dic1];
        NSString *userss=[NSString stringWithFormat:@"%@",[de objectForKey:@"userId"]];
        NSString *headss=[GTMBase64 encodeBase64String:userss];
        NSString *jsonaes=[SecurityUtil encryptAESData:urlss passwordKey:[de objectForKey:COOKIE]];
        NSDictionary *urldic=@{@"param":jsonaes};
      
       
        [AFManger headerFilePostWithURLString:url parameters:urldic Hearfile:headss success:^(id responseObject) {
             id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            Boolean success=[[strs objectForKey:@"success"] boolValue];
            
            if (success) {
                //
               
               ordinaryShopcartDiscount=[[strs objectForKey:@"shopcartDiscount"] objectForKey:@"ordinaryShopcartDiscount"];
                
                vipShopcartDiscount=[[strs objectForKey:@"shopcartDiscount"] objectForKey:@"vipShopcartDiscount"];
                ZKordinaryDic=[[strs objectForKey:@"shopcartZhekou"] objectForKey:@"ordinaryShopcartZhekou"];
                ZkVIPDic=[[strs objectForKey:@"shopcartZhekou"] objectForKey:@"vipShopcartZhekou"];
                
                [_dataarray removeAllObjects];
                NSDictionary *dataDic=[strs objectForKey:@"data"];
                
                NSDictionary *ordinary=[dataDic objectForKey:@"ordinaryShopCart"];
                if (ordinary!=nil) {
                    [ordinary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        NSMutableArray *farr=[[NSMutableArray alloc] init];
                        for (NSDictionary *goodsdic in obj) {
                            
                            CartModel *model=[CartModel initwithdic:goodsdic];
                            NSDictionary *dicc=[goodsdic objectForKey:@"appgoodsId"];
                            model.cardgoodid=[goodsdic objectForKey:@"id"];
                            model.goodsName=[[goodsdic objectForKey:@"appgoodsId" ] objectForKey:@"goodsName"];
                            model.id=[dicc objectForKey:@"id"];
                            model.logopicUrl=[dicc objectForKey:@"logopicUrl"];
                            model.goodsPrice=[dicc objectForKey:@"originalPrice"];
                            model.promotionPrice=[dicc objectForKey:@"promotionPrice"];
                            model.vipPrice=[dicc objectForKey:@"vipPrice"];
                            
                            NSDictionary *dicc1=[dicc objectForKey:@"appbrandId"];
                            model.brandName=[dicc1 objectForKey:@"brandName"];
                            model.logopic=[dicc1 objectForKey:@"logopic"];
                            model.brandid=[dicc1 objectForKey:@"id"];
                            model.appStoresId=[[goodsdic objectForKey:@"appStoresId"] objectForKey:@"id"];
                            [farr addObject:model];
                            
                        }
                        
                        [_ordinaarr addObject:farr];
                        
                    }];
                    AllcardModel *model=[[AllcardModel alloc] init];
                    model.vipFlag=NO;
                    model.goods=_ordinaarr;
                    [_dataarray addObject:model];
                }
                
                NSDictionary *vipShopCart=[dataDic objectForKey:@"vipShopCart"];
                if (vipShopCart!=nil) {
                    [vipShopCart enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        NSMutableArray *farr=[[NSMutableArray alloc] init];
                        for (NSDictionary *goodsdic in obj) {
                            
                            CartModel *model=[CartModel initwithdic:goodsdic];
                            NSDictionary *dicc=[goodsdic objectForKey:@"appgoodsId"];
                            model.cardgoodid=[goodsdic objectForKey:@"id"];
                            model.goodsName=[[goodsdic objectForKey:@"appgoodsId" ] objectForKey:@"goodsName"];
                            model.id=[dicc objectForKey:@"id"];
                            model.logopicUrl=[dicc objectForKey:@"logopicUrl"];
                            model.goodsPrice=[dicc objectForKey:@"originalPrice"];
                            model.promotionPrice=[dicc objectForKey:@"promotionPrice"];
                            model.vipPrice=[dicc objectForKey:@"vipPrice"];
                            NSDictionary *dicc1=[dicc objectForKey:@"appbrandId"];
                            model.brandName=[dicc1 objectForKey:@"brandName"];
                            model.logopic=[dicc1 objectForKey:@"logopic"];
                            model.brandid=[dicc1 objectForKey:@"id"];
                            model.appStoresId=[[goodsdic objectForKey:@"appStoresId"] objectForKey:@"id"];
                            [farr addObject:model];
                            
                        }
                        
                        [_viparr addObject:farr];
                        
                    }];
                    AllcardModel *model=[[AllcardModel alloc] init];
                    
                    model.vipFlag=YES;
                    model.goods=_viparr;
                    [_dataarray addObject:model];
                }
              
                [_table reloadData];

                
            }else{
                [_dataarray removeAllObjects];
                
                [_table reloadData];
                if ([[strs objectForKey:@"msg"] isEqual:@"您的购物车中没有商品！"]) {
                    
                }
                [Uikility alert:[strs objectForKey:@"msg"]];
                
            }

        } failure:^(NSError *error) {
           
        
        }];
        
        
        
    }else{
       // [Uikility alert:@"请先登录！"];
        //LoginViewController *log=[[LoginViewController alloc] init];
        //[self.navigationController pushViewController:log animated:YES];
        
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


