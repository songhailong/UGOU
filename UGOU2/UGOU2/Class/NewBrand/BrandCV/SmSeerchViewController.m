//
//  SmSeerchViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/28.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "SmSeerchViewController.h"
#import "Uikility.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
#import "SearchCollectionViewCell.h"
#import "MainCollectionViewCell.h"
#import "MJRefresh.h"
#import "SpViewController.h"
#import "FMDBSingleTon.h"
#import "BassAPI.h"
@interface SmSeerchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UITextField *sfield;
    UIView *leftview;
    UILabel *label;
    UIView *rightview;
    UIView *v1;
    UIView *_xuanzeview;
    int sf;
    NSInteger _page;
    UITableView *table;
    NSInteger _hang;
    NSDictionary *_dic;
    NSMutableArray *_dataarray;
    UICollectionView *_collectionview;
    UICollectionView *_collectionviewbut;
    
    NSArray *_historyarry;
    NSString *_secherstr;
    BOOL YN;
    UITableView *_tableview;



}

@end

@implementation SmSeerchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _dataarray=[[NSMutableArray alloc] init];
    _historyarry=[[NSArray alloc] init];
    
    //导航栏的搜索框
    v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    v1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:v1];
    UIButton *leftbut =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 40*KIphoneWH, 64*KIphoneWH )];
    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
    UIImage *img=[UIImage imageNamed:@"返回p"];
    UIImageView *imgv1=[[UIImageView alloc]initWithImage:img];
    [leftbut addSubview:imgv1];
    imgv1.frame=CGRectMake(15*KIphoneWH, 31*KIphoneWH, 15*KIphoneWH, 15*KIphoneWH);
    [leftbut addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    [v1 addSubview:leftbut];
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(40*KIphoneWH, 25*KIphoneWH, WIDTH-100*KIphoneWH, 30*KIphoneWH)];
    imgv.image=[UIImage imageNamed:@"搜索框"];
    [v1 addSubview:imgv];
    imgv.userInteractionEnabled=YES;
    
    sfield=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH-90*KIphoneWH, 30*KIphoneWH)];
    [imgv addSubview:sfield];
    sfield.delegate=self;
    sfield.returnKeyType=UIReturnKeySearch;
    sfield.clearButtonMode=YES;
    sfield.leftViewMode=UITextFieldViewModeAlways;
    [self addview];
    sfield.leftView=leftview;
    sfield.rightViewMode=UITextFieldViewModeAlways;
    sfield.rightView=rightview;
    UIButton *cancelbut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60*KIphoneWH, 20*KIphoneWH, 50*KIphoneWH, 40*KIphoneWH)];
    [v1 addSubview:cancelbut];
    [cancelbut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbut setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forState:UIControlStateNormal];
    [cancelbut addTarget:self action:@selector(butpush:) forControlEvents:UIControlEventTouchUpInside];
    cancelbut.tag=1;
    if (iPhoneX) {
        leftbut.frame=CGRectMake(0*KIphoneWH, 24, 40*KIphoneWH, 64);
        imgv.frame=CGRectMake(40*KIphoneWH, 25*KIphoneWH+24, WIDTH-100*KIphoneWH, 30*KIphoneWH);
        cancelbut.frame=CGRectMake(WIDTH-60*KIphoneWH, 20*KIphoneWH+24, 50*KIphoneWH, 40*KIphoneWH);
    }
    
    [self addbutview];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    _historyarry=[df objectForKey:@"smseerchhistory"];
   
    [_collectionviewbut reloadData];
    
    [self addcolectionview];
    //[self json1];
    sf=0;
    _hang=1;
    YN=YES;
    // [self addbut];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=NO;

}
-(void)addcolectionview{
    
    self.automaticallyAdjustsScrollViewInsets=YES;
    _collectionview.contentInset=UIEdgeInsetsMake(0,NavHeight, WIDTH, HEIGHT);
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) collectionViewLayout:flowlayout];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    _collectionview.alpha=0;
    [self.view addSubview:_collectionview];
    [_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];
    
    _collectionview.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _hang++;
        [self json1];
        [_collectionview.footer endRefreshing];
    }];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [sfield resignFirstResponder];
    if ([sfield.text isEqual:@""]) {
        [Uikility alert:@"请输入内容！"];
    }else{
        _secherstr=sfield.text;
        [_dataarray removeAllObjects];
        _collectionview.alpha=1;
        _hang=1;
        [self json1];
        NSArray *arr=[NSArray array];
        NSMutableArray *muarr=[NSMutableArray array];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        if ([df objectForKey:@"smseerchhistory"]) {
            arr =[df objectForKey:@"smseerchhistory"];
            [muarr addObjectsFromArray:arr];
            
        }
        
        for (int i=0;i<muarr.count ;i++ ) {
            if ([muarr[i]isEqualToString: sfield.text]) {
                [muarr removeObjectAtIndex:i];
                
                //return;
            }
        }
        [muarr addObject:sfield.text];
        
        if (muarr.count>8) {
            [muarr removeObjectAtIndex:0];
        }
        [df setObject:muarr forKey:@"smseerchhistory"];
        
        _historyarry=[df objectForKey:@"smseerchhistory"];
        
        
        [_collectionviewbut reloadData];
    }



    return YES;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView==_collectionviewbut) {
        if (_historyarry.count) {
            return _historyarry.count;
        }
    }else if (collectionView==_collectionview){
        if (_dataarray.count) {
            return _dataarray.count;
        }
    }
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_collectionviewbut) {
        
        return CGSizeMake((WIDTH-20*KIphoneWH)/2, 50*KIphoneWH);
        
    }else if (collectionView==_collectionview){
        
        return CGSizeMake((WIDTH-20*KIphoneWH)/2, 100*KIphoneWH+(WIDTH-20*KIphoneWH)/2);
    }
    return CGSizeMake(0, 0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // 上 左下右
    if(collectionView==_collectionviewbut){
        
        return UIEdgeInsetsMake(10*KIphoneWH, 5*KIphoneWH, 10*KIphoneWH, 5*KIphoneWH);
        
        
    }else{
        
        
        return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
        
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=nil;
    if (collectionView==_collectionview) {
        
        
        MainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"qqq" forIndexPath:indexPath];
        if (_dataarray.count) {
            CartModel *model=_dataarray[indexPath.row];
            
            [cell.imageview sd_setImageWithURL:[Uikility URLWithString:model.logopicUrl]placeholderImage:[UIImage imageNamed:@"uuu"]];
            cell.textlable.text=model.goodsName;
            CGFloat s=model.promotionPrice.floatValue;
            cell.pricelable.text=[NSString stringWithFormat:@"￥%.2f",s];
            CGFloat s1=model.goodsPrice.floatValue;
            if (s1) {
                cell.procelable.text=[NSString stringWithFormat:@"￥%.2f",s1];
            }
            return cell;
        }
    }else if (collectionView==_collectionviewbut){
        SearchCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ddd" forIndexPath:indexPath];
        
        if (_historyarry.count) {
            
            NSString *titstr=_historyarry[(int)_historyarry.count-1-(int)indexPath.row];
            cell.titlelable.text=titstr;
        }
        return cell;
    }
    
    return cell;
}
#pragma mark 右侧
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_collectionview) {
        SpViewController *sp=[[SpViewController alloc]init];
        CartModel *model=[_dataarray objectAtIndex:indexPath.row];
        NSString *sreid=[NSString stringWithFormat:@"%zd",model.id.intValue];
        sp.goodsId=sreid;
        sp.storeId=_storeId;
        sp.flag=_flag;
        sp.hidesBottomBarWhenPushed=YES;
        
        //存储
        FMDBSingleTon *singon=[FMDBSingleTon shareSinglotn];
        [singon addshop:model];
        [self.navigationController pushViewController:sp animated:YES];
    }else{
        NSString *str=_historyarry[_historyarry.count-1- indexPath.row];
        if ( [self validateNumber:str]) {
            label.text=@"货号";
            sfield.text=str;
            _hang=1;
            _collectionview.alpha=1;
            _secherstr=str;
            YN=NO;
            [_dataarray removeAllObjects];
            [self json1];
        }else{
            label.text=@"名称";
            sfield.text=str;
            _collectionview.alpha=1;
            YN=YES;
            _secherstr=str;
            _hang=1;
            [_dataarray removeAllObjects];
            [self json1];
            
        }
        NSArray *arr=[NSArray array];
        NSMutableArray *muarr=[NSMutableArray array];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        if ([df objectForKey:@"smseerchhistory"]) {
            arr =[df objectForKey:@"smseerchhistory"];
            [muarr addObjectsFromArray:arr];
            
        }
        
        for (int i=0;i<muarr.count ;i++ ) {
            if ([muarr[i]isEqualToString: sfield.text]) {
                [muarr removeObjectAtIndex:i];
                
                //return;
            }
        }
        [muarr addObject:sfield.text];
        
        if (muarr.count>8) {
            [muarr removeObjectAtIndex:0];
        }
        [df setObject:muarr forKey:@"smseerchhistory"];
        
        _historyarry=[df objectForKey:@"smseerchhistory"];
        [_collectionviewbut reloadData];
    }
    
    
}
-(void)addview{
    leftview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50*KIphoneWH, 40*KIphoneWH)];
    // [v1 addSubview:leftview];
    label=[[UILabel alloc]initWithFrame:CGRectMake(2*KIphoneWH, 0, 40*KIphoneWH, 40*KIphoneWH)];
    label.text=@"名称";
    label.font=[UIFont systemFontOfSize:16*KIphoneWH];
    label.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [leftview addSubview:label];
    
    label.tag=1;
    label.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtaps=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    [label addGestureRecognizer:imgtaps];
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(42*KIphoneWH, 17*KIphoneWH, 8*KIphoneWH, 8*KIphoneWH)];
    imv.image=[UIImage imageNamed:@"多边形-11"];
    [leftview addSubview:imv];
    imv.tag=1;
    imv.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    [imv addGestureRecognizer:imgtap];
    
    rightview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*KIphoneWH, 30*KIphoneWH)];
    // [v1 addSubview:leftview];
    
    UIImageView *imv1=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    imv1.image=[UIImage imageNamed:@"search2@2x"];
    [rightview addSubview:imv1];
    imv1.tag=2;
    imv1.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    [imv1 addGestureRecognizer:imgtap1];
}
#pragma mark
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 按钮
-(void)addbutview{
    
    
    UIImageView *imv=[[UIImageView alloc]initWithFrame:CGRectMake(15*KIphoneWH, 80*KIphoneWH, 20*KIphoneWH, 20*KIphoneWH)];
    [self.view addSubview:imv];
    imv.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvpush:)];
    imv.image=[UIImage imageNamed:@"clock"];
    [imv addGestureRecognizer:imgtap];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40*KIphoneWH,80*KIphoneWH, 100*KIphoneWH, 30*KIphoneWH)];
    label1.text=@"最近搜索";
    label1.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    [self.view addSubview:label1];
    
    
    self.automaticallyAdjustsScrollViewInsets=YES;
    _collectionviewbut.contentInset=UIEdgeInsetsMake(0,115*KIphoneWH, WIDTH, 180*KIphoneWH);
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionviewbut=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 115*KIphoneWH, WIDTH, 180*KIphoneWH) collectionViewLayout:flowlayout];
    _collectionviewbut.delegate=self;
    _collectionviewbut.dataSource=self;
    _collectionviewbut.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_collectionviewbut];
    [_collectionviewbut registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"ddd"];
    UIImageView *imv1=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-100*KIphoneWH, HEIGHT/2, 200*KIphoneWH, 40*KIphoneWH)];
    [self.view addSubview:imv1];
    imv1.image=[UIImage imageNamed:@"清空历史记录"];
    imv1.tag=3;
    imv1.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imvp:)];
    [imv1 addGestureRecognizer:imgtap1];
    
    table=[[UITableView alloc]initWithFrame:CGRectMake(5*KIphoneWH,50*KIphoneWH,80*KIphoneWH,100*KIphoneWH) style:UITableViewStylePlain];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.alpha=0;
    if (iPhoneX) {
        imv.frame=CGRectMake(15*KIphoneWH, 80*KIphoneWH+24, 20*KIphoneWH, 20*KIphoneWH);
        label1.frame=CGRectMake(40*KIphoneWH,80*KIphoneWH+24, 100*KIphoneWH, 30*KIphoneWH);
        _collectionviewbut.frame=CGRectMake(0, 115*KIphoneWH+24, WIDTH, 180*KIphoneWH);
        table.frame=CGRectMake(5*KIphoneWH,50*KIphoneWH+24,80*KIphoneWH,100*KIphoneWH);
        
    }
    
}

#pragma mark 设置text自适应

#pragma mark 清空历史记录
-(void)imvp:(UITapGestureRecognizer *)g{
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    if ([df objectForKey:@"smseerchhistory"]) {
        [df removeObjectForKey:@"smseerchhistory"];
        _historyarry=[df objectForKey:@"smseerchhistory"];
    }
    [_collectionviewbut reloadData];
}
#pragma mark //下拉列表  搜索按钮
-(void)imvpush:(UITapGestureRecognizer *)g{
    
    if (g.view.tag==1) {
        
        
        if (sf%2) {
            table.alpha=0;
            _collectionview.alpha=1;
        }else{
            _collectionview.alpha=0;
            table.alpha=1;
        }
        
        sf++;
    }else if(g.view.tag==2){
        if ([sfield.text isEqual:@""]) {
            [Uikility alert:@"请输入内容！"];
        }else{
            _secherstr=sfield.text;
            [_dataarray removeAllObjects];
            _collectionview.alpha=1;
            _hang=1;
            [self json1];
            NSArray *arr=[NSArray array];
            NSMutableArray *muarr=[NSMutableArray array];
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            if ([df objectForKey:@"smseerchhistory"]) {
                arr =[df objectForKey:@"smseerchhistory"];
                [muarr addObjectsFromArray:arr];
                
            }
            
            for (int i=0;i<muarr.count ;i++ ) {
                if ([muarr[i]isEqualToString: sfield.text]) {
                    [muarr removeObjectAtIndex:i];
                    
                    //return;
                }
            }
            [muarr addObject:sfield.text];
            
            if (muarr.count>8) {
                [muarr removeObjectAtIndex:0];
            }
            [df setObject:muarr forKey:@"smseerchhistory"];
            
            _historyarry=[df objectForKey:@"smseerchhistory"];
            
            [_collectionviewbut reloadData];
        }
    }
}
- (void)writeToLocal:(NSData *)data {
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",NSStringFromClass([self class])];
    [data writeToFile:path atomically:YES];
}

- (NSData *)readLocal {
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.txt",NSStringFromClass([self class])];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [NSData dataWithContentsOfFile:path];
    }
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *arr=@[@"名称",@"货号"];
    cell.textLabel.text=arr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSArray *arr=@[@"名称",@"货号"];
    label.text=arr[indexPath.row];
    if (indexPath.row==0) {
        YN=YES;
    }else if (indexPath.row==1){
        YN=NO;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    sf++;
    table.alpha=0;
}
#pragma mark 取消搜索
-(void)butpush:(UIButton *)b{
    if (b.tag==1) {
        sfield.text=@"";
        _collectionview.alpha=0;
        _collectionviewbut.alpha=1;
        [_collectionviewbut reloadData];
        //[self addbuts];
    }
}
#pragma mark  点击后输入按钮边框上方
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self addtoolBar];
}
#pragma mark 键盘 消失否
-(void)addtoolBar{
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30*KIphoneWH)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [sfield setInputAccessoryView:topview];
    
}

#pragma mark 隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [sfield resignFirstResponder];
    
}
-(void)resignKeyboard{
    [sfield resignFirstResponder];
    
}
-(void)json1{
    //_hang=1;
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:@10 forKey:@"max"];
    [mudic setObject:[de objectForKey:@"placename"] forKey:@"area"];
   
    if ([de objectForKey:@"userId"]) {
        if (_hang==1) {
            if (YN) {
                [mudic setObject:@0 forKey:@"min"];
                [mudic setObject:_secherstr forKey:@"goodsName"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                
            }else {
                [mudic setObject:_secherstr forKey:@"barCode"];
                [mudic setObject:@0 forKey:@"min"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                
                if ([de objectForKey:@"newUserId"]) {
                [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
            }
            
        }else{
            NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
            NSNumber * min = @([minstr integerValue]);
            
            
            if (YN) {
                [mudic setObject:_secherstr forKey:@"goodsName"];
                [mudic setObject:min forKey:@"min"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
                if ([de objectForKey:@"newUserId"]) {
                [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
            }else{
                [mudic setObject:_secherstr forKey:@"barCode"];
                [mudic setObject:min forKey:@"min"];
                [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
                [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
               if ([de objectForKey:@"newUserId"]) {
                    [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
                }
                
            }
        }
        
        
        NSString *url=[BassAPI requestUrlWithPorType:PortTypeSearchGoods];
        
        NSDictionary *dicurl=[Uikility initWithdatajson:mudic];
        [AFManger postWithURLString:url parameters:dicurl success:^(id responseObject) {
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
            
            Boolean success=[[obj objectForKey:@"success"] boolValue];
            if (success) {
                NSDictionary *datadic=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSArray * array=[datadic objectForKey:@"data"];
                for (NSDictionary *dicc in array) {
                    [_dataarray addObject:[CartModel initwithdic:dicc]];
                    
                }
                //_collectionview.alpha=1;
                [_collectionview reloadData];
            }else{
                
                [Uikility alert:[obj objectForKey:@"msg"]];
                
            }

            
        } failure:^(NSError *error) {
            [Uikility alert:@"数据接受失败！"];
        }];
        
        
    }else{
        //[Uikility alert:@"请先登录！"];
        
        
        if (_hang==1) {
            if (YN) {
                [mudic setObject:_secherstr forKey:@"goodsName"];
                [mudic setObject:@0 forKey:@"min"];
                //_dic=@{@"goodsName":_secherstr,@"min":@0,@"max":@10,@"model":@"1",@"ios_version":VERSION
                      // };
            }else {
                [mudic setObject:_secherstr forKey:@"barCode"];
                [mudic setObject:@0 forKey:@"min"];
                //_dic=@{@"barCode":_secherstr,@"min":@0,@"max":@10,@"model":@1,@"ios_version":VERSION                       };
            }
            
        }else{
            NSString *minstr=[[NSString alloc]initWithFormat:@"%zd",10*(_hang-1)+1];
            NSNumber * min = @([minstr integerValue]);
            if (YN) {
                [mudic setObject:_secherstr forKey:@"goodsName"];
                [mudic setObject:min forKey:@"min"];
                //_dic=@{@"goodsName":_secherstr,@"min":min,@"max":@10,@"model":@1,@"ios_version":VERSION
                       //};
            }else{
                [mudic setObject:_secherstr forKey:@"barCode"];
                [mudic setObject:min forKey:@"min"];
                //_dic=@{@"barCode":_secherstr,@"min":min,@"max":@10,@"model":@1,@"ios_version":VERSION
                      // };
            }
        }
        
        
        NSString *url=[BassAPI requestUrlWithPorType:PortTypeSearchGoods];
        
        NSDictionary *dicurl=[Uikility initWithdatajson:mudic];
        
       [AFManger postWithURLString:url parameters:dicurl success:^(id responseObject) {
           id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
           
           Boolean success=[[obj objectForKey:@"success"] boolValue];
           if (success) {
               NSDictionary *datadic=[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
               NSArray * array=[datadic objectForKey:@"data"];
               for (NSDictionary *dicc in array) {
                   [_dataarray addObject:[CartModel initwithdic:dicc]];
                   
               }
               //_collectionview.alpha=1;
               [_collectionview reloadData];
           }else{
               
               [Uikility alert:[obj objectForKey:@"msg"]];
               
           }
 
           
       } failure:^(NSError *error) {
           [Uikility alert:@"数据接受失败！"];
       }];
    }
    
    
}
//只许数字输入
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
