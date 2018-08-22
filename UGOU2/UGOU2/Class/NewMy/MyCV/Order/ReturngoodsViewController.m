//
//  ReturngoodsViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/21.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ReturngoodsViewController.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "GTMBase64.h"
#import "AFManger.h"
#import "UIImageView+WebCache.h"
//#import "RetureView.h"
#import "UGHeader.h"
#import "RetureCollectionViewCell.h"
@interface ReturngoodsViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UGCustomnNavViewDelegate>{
    UILabel *titlelabel;
    UIImageView *_imageview;
    UIView *_view1;
   UIView *view2;
    UITextField *textfiled;
    NSUserDefaults *de;
    UIButton *_addbutton;
    NSMutableArray *_imagesarr;
    NSMutableArray *_bassimagearr;
    UIView *_returnview;
    NSInteger _plomrpage;
    UIActionSheet *_deletesheet;
    NSMutableArray *_lastFileName;
    UICollectionView *_collectionview;

}

@end

@implementation ReturngoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    de=[NSUserDefaults standardUserDefaults];
    _imagesarr=[[NSMutableArray alloc] init];
    _bassimagearr=[[NSMutableArray alloc] init];
    _lastFileName=[[NSMutableArray alloc] init];
    _plomrpage=0;
    if (_model.customerFlag==1) {
     [self creatsqui];
    }else  if(_model.customerFlag==2){
        [self creatsqui];
    
    }else if (_model.customerFlag==3){
     [self creatsqui];
    }else if (_model.customerFlag==4){
     [self creatsqui];
    }else{
    [self creatUI];
    }
    //[self creatUI];
    // Do any additional setup after loading the view.
}
-(void)creatsqui{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 64*KIphoneWH, WIDTH, 150*KIphoneWH)];
   UIImageView *goodsimv=[[UIImageView alloc]initWithFrame:CGRectMake(5*KIphoneWH, 5*KIphoneWH, 90*KIphoneWH, 90*KIphoneWH)];
    [goodsimv sd_setImageWithURL:[Uikility URLWithString:_model.logopicUrl]];
    
    [view addSubview:goodsimv];
   UILabel * goodsname=[[UILabel alloc]initWithFrame:CGRectMake(100*KIphoneWH, 5*KIphoneWH, WIDTH-180*KIphoneWH, 50*KIphoneWH)];
    goodsname.font=[UIFont systemFontOfSize:18*KIphoneWH];
    goodsname.numberOfLines=2;
    goodsname.text=_model.goodsName;
    [view addSubview:goodsname];
    
    UILabel *  attlabel=[[UILabel alloc]initWithFrame:CGRectMake(95*KIphoneWH, 70*KIphoneWH, WIDTH-195*KIphoneWH, 20*KIphoneWH)];
    attlabel.font=[UIFont systemFontOfSize:14*KIphoneWH];
    attlabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1];
    attlabel.text=_model.attribute;
    [view addSubview:attlabel];
   UILabel * pircelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-85*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 30*KIphoneWH)];
    pircelabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
    NSString *s=[NSString stringWithFormat:@"￥%.1f",_model.money.floatValue];
    pircelabel.text=s;
    
    [view addSubview:pircelabel];
    UILabel *  qulable=[[UILabel alloc]initWithFrame: CGRectMake(WIDTH-70*KIphoneWH,35*KIphoneWH, 70*KIphoneWH, 30*KIphoneWH)];
    qulable.font=[UIFont systemFontOfSize:16*KIphoneWH];
    qulable.text=[NSString stringWithFormat:@"x%ld",(long)_model.quantity];
    [view addSubview:qulable];

    [self.view   addSubview:view  ];
    
    NSArray *setitle=@[@"退款状态:",@"退款金额:",@"订单编号:",@"退货原因:",@"退货说明:"];
    
    UILabel *titlelable1=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 414*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH)];

    
    titlelable1.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    titlelable1.font=[UIFont systemFontOfSize:16*KIphoneWH];
    [self.view addSubview:titlelable1];
    
//    UILabel *titlelable2=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH, 150*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH)];
//    
//    titlelable2.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
//    titlelable2.font=[UIFont systemFontOfSize:16*KIphoneWH];
//    [self.view addSubview:titlelable2];

    if (_customerflag==1) {
        
        titlelable1.text=@"申请时间";
    }else if (_customerflag==2){
        
         titlelable1.text=@"处理时间";
    }else if (_customerflag==3){
        
          titlelable1.text=@"收货时间";
    
    }else if (_customerflag==4){
        
       titlelable1.text=@"退款时间";
    
    }
    
    
    for (int i=0; i<setitle.count; i++) {
        UILabel *titlelable=[[UILabel alloc] initWithFrame:CGRectMake(5*KIphoneWH,164*KIphoneWH+50*i*KIphoneWH, 100*KIphoneWH, 50*KIphoneWH)];
        titlelable.text=setitle[i];
        titlelable.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
        titlelable.font=[UIFont systemFontOfSize:16*KIphoneWH];
        [self.view addSubview:titlelable];
    }
    
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(110*KIphoneWH, 164*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    lable1.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    lable1.font=[UIFont systemFontOfSize:16*KIphoneWH];
    UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(110*KIphoneWH, 214*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    lable2.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    lable2.font=[UIFont systemFontOfSize:16*KIphoneWH];
    UILabel *lable3=[[UILabel alloc] initWithFrame:CGRectMake(110*KIphoneWH, 264*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    lable3.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    lable3.font=[UIFont systemFontOfSize:16*KIphoneWH];
    UILabel *lable4=[[UILabel alloc] initWithFrame:CGRectMake(110*KIphoneWH, 314*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    lable4.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    lable4.font=[UIFont systemFontOfSize:16*KIphoneWH];
    UILabel *lable5=[[UILabel alloc] initWithFrame:CGRectMake(110*KIphoneWH, 364*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    lable5.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    lable5.font=[UIFont systemFontOfSize:16*KIphoneWH];
    UILabel *lable6=[[UILabel alloc] initWithFrame:CGRectMake(110*KIphoneWH, 414*KIphoneWH, 200*KIphoneWH, 50*KIphoneWH)];
    lable6.textColor=[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1];
    lable6.font=[UIFont systemFontOfSize:16*KIphoneWH];
   
    if (_customerflag==1) {
        lable1.text=@"申请中";
        long long ssss =  _model.customerReTime.longLongValue;
        NSString *ss=[NSString stringWithFormat:@"%lld",ssss/1000];
        long time=ss.integerValue;
        NSString *timestr=[Uikility Datetodatestyle:time ];
        lable6.text=timestr;
        
    }else if (_customerflag==2){
    lable1.text=@"店家同意";
        long long ssss =  _model.customerStartTime.longLongValue;
        NSString *ss=[NSString stringWithFormat:@"%lld",ssss/1000];
        long time=ss.integerValue;
        NSString *timestr=[Uikility Datetodatestyle:time ];
        lable6.text=timestr;

        
        
    }else if (_customerflag==3){
    lable1.text=@"确认收货";
        long long ssss =  _model.customerCenterTime.longLongValue;
        NSString *ss=[NSString stringWithFormat:@"%lld",ssss/1000];
        long time=ss.integerValue;
        NSString *timestr=[Uikility Datetodatestyle:time ];
        lable6.text=timestr;
        
    }else if (_customerflag==4){
    lable1.text=@"已退款";
        long long ssss =  _model.customerEndTime.longLongValue;
        NSString *ss=[NSString stringWithFormat:@"%lld",ssss/1000];
        long time=ss.integerValue;
        NSString *timestr=[Uikility Datetodatestyle:time ];
        lable6.text=timestr;
    }
    lable2.text=[NSString stringWithFormat:@"%.1f",_model.money.floatValue];
    lable3.text=[NSString stringWithFormat:@"%@",_model.orderNo];
    lable4.text=_model.customerProblem;
    
//    long long ssss =  _model.customerStartTime.longLongValue;
//    NSString *ss=[NSString stringWithFormat:@"%lld",ssss/1000];
//    long time=ss.integerValue;
//    NSString *timestr=[Uikility Datetodatestyle:time ];
//    lable6.text=timestr;
    [self.view addSubview:lable1];
    [self.view addSubview:lable2];
    [self.view addSubview:lable3];
    [self.view addSubview:lable4];
    [self.view addSubview:lable5];
    [self.view addSubview:lable6];
    
    
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatnavaget];

}
-(void)creatnavaget{
    
    titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(60*KIphoneWH, 20*KIphoneWH,WIDTH-120*KIphoneWH, 44*KIphoneWH)];
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64*KIphoneWH)];
    
    _imageview.userInteractionEnabled=YES;
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [_imageview addSubview:titlelabel];
    
        if (_customerflag==1){
    
     titlelabel.text=@"申请退货中";
    }else if (_customerflag==2){
    
    titlelabel.text=@"商家同意退货";
    
    }else if (_customerflag==3){
      titlelabel.text=@"确认收货";
    }else if (_customerflag==4){
    
       titlelabel.text=@"已退款";
    }else{
    
    titlelabel.text=@"退货申请";
    }
    
    UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
    _imageview.image=image;
    
    
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 200*KIphoneWH, 64*KIphoneWH )];
    
    UIImage *img=[UIImage imageNamed:@"返回o"];
    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
    [leftButton addSubview:imgv];
    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
    [leftButton addTarget:self action:@selector(pushpop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageview];
    [_imageview  addSubview:leftButton];
    UGCustomNavView *custemaNav=[[UGCustomNavView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NavHeight)];
    custemaNav.Delegate=self;
    [custemaNav.backgroundView setImage:[UIImage imageNamed:@"矩形-1"]];
    [custemaNav setLeftImage:[UIImage imageNamed:@"返回o"]];
    [self.view addSubview:custemaNav];
    if (_customerflag==1){
        
        custemaNav.title=@"申请退货中";
    }else if (_customerflag==2){
        
        custemaNav.title=@"商家同意退货";
        
    }else if (_customerflag==3){
        custemaNav.title=@"确认收货";
    }else if (_customerflag==4){
        
        custemaNav.title=@"已退款";
    }else{
        
        custemaNav.title=@"退货申请";
    }
    
}
-(void)LeftItemAction{
    [self pushpop];
    
}
-(void)pushpop{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)creatUI{
    _view1=[[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, 160*KIphoneWH)];
    _view1.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    NSArray *problemarr=@[@"质量问题",@"尺码不合适",@"不喜欢"];
    for (int i=0;i<problemarr.count ;i++ ) {
        CGFloat with=(WIDTH-40*KIphoneWH)/3;
        UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(20*KIphoneWH+i*with, 25*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
        [but setBackgroundImage:[UIImage imageNamed:@"使用优惠券-"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"使用优惠券-选中"] forState:UIControlStateSelected];
        but.backgroundColor=[UIColor whiteColor];
        but.tag=i+1;
        [but addTarget:self action:@selector(selectproblem:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(20*KIphoneWH+i*with+30*KIphoneWH, 10*KIphoneWH, with-40*KIphoneWH, 60*KIphoneWH)];
        lable.text=problemarr[i];
        lable.font=[UIFont systemFontOfSize:14*KIphoneWH];
        lable.textColor=[UIColor blackColor];
        [_view1 addSubview:lable];
        [_view1 addSubview:but];
        
        
    }
    
    
    
//    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(20*KIphoneWH, 10*KIphoneWH, 200*KIphoneWH, 60*KIphoneWH)];
//    lable.text=@"退货说明";
//    lable.backgroundColor=[UIColor  colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    
    textfiled=[[UITextField alloc] initWithFrame:CGRectMake(20*KIphoneWH, 80*KIphoneWH, WIDTH-40*KIphoneWH, 40*KIphoneWH)];
    textfiled.delegate=self;
    textfiled.placeholder=@"退款理由";
    textfiled.backgroundColor=[UIColor whiteColor];
  textfiled.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:_view1];
    //[_view1 addSubview:lable];
    [_view1 addSubview:textfiled];
    view2=[[UIView  alloc] initWithFrame:CGRectMake(0, 160*KIphoneWH+NavHeight, WIDTH, 200*KIphoneWH)];
    self.automaticallyAdjustsScrollViewInsets=YES;
    //_collectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200*KIphoneWH)];
    
    
    _collectionview.contentInset=UIEdgeInsetsMake(0, 0, view2.frame.size.width, view2.frame.size.height);
    //_collectionview.backgroundColor=[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, WIDTH, 200*KIphoneWH)   collectionViewLayout:flowlayout];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    //_collectionview.backgroundColor=[UIColor whiteColor];
    
    _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [_collectionview registerClass:[RetureCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];
    
    
    [view2 addSubview:_collectionview];
    
    void(^myblock)(NSInteger text,NSInteger index)=^(NSInteger text,NSInteger index){
        if (text==1) {
            
            [self buttonclick];
        }else{
        
            _deletesheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
            [_deletesheet  showInView:self.view];
            _deletesheet.tag=index;
            
            //[self deleteimagearr:index];
        
        
        }
    
    
    
    };
    _returnblock=myblock;
    
    [self.view addSubview:view2];
    [_collectionview  reloadData];
    //[view2 addSubview:_addbutton];
    
    UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(5*KIphoneWH, HEIGHT-65*KIphoneWH, WIDTH-10*KIphoneWH, 60*KIphoneWH)];
    [but setTitle:@"提交" forState:UIControlStateNormal];
    but.backgroundColor=[UIColor redColor];
    [but addTarget:self action:@selector(postreturnreson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textfiled resignFirstResponder];

    return YES;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_imagesarr.count<5){
        
       
        return _imagesarr.count+1;
        
    }else{
        
        return _imagesarr.count;
        
    }
    
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // 上 左下右
    return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(80*KIphoneWH, 80*KIphoneWH);
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RetureCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"qqq" forIndexPath:indexPath];
    if (_imagesarr.count) {
       
        if (_imagesarr.count<5) {
            if (_imagesarr.count==indexPath.row) {
                
                UIImage *image=[UIImage imageNamed:@"添加图片"];
                cell.rimageview.image=image;
            }else{
                NSData *data=_imagesarr[indexPath.row];
                UIImage *image=[UIImage imageWithData:data];
                cell.rimageview.image=image;
            }
            
            
            
        }else{
            NSData *data=_imagesarr[indexPath.row];
            UIImage *image=[UIImage imageWithData:data];
            cell.rimageview.image=image;
            
        }
    }else{
     
        
        UIImage *image=[UIImage imageNamed:@"添加图片"];
        cell.rimageview.image=image;
    
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        
        
    
            if (_imagesarr.count<5) {
                if (_imagesarr.count==indexPath.row) {
                    //1为添加  2为删除
                    //NSLog(@)
                    [self buttonclick];
                    
                }else{
                    
                    _deletesheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
                    [_deletesheet  showInView:self.view];
                    _deletesheet.tag=indexPath.row;

                    
                }
                
                
                
            }else{
                
                _deletesheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
                [_deletesheet  showInView:self.view];
                _deletesheet.tag=indexPath.row;
                
                
            }
            
    
        
        
        
   
    
    
}
//-(void)reloacollectionview{
//    
//    [_collectionview reloadData];
//    
//}








-(void)selectproblem:(UIButton *)b{
     _plomrpage=b.tag;

    for (int i=1;i<4 ; i++) {
        UIButton *bu=(id)[_view1 viewWithTag:i];
        if (i==b.tag) {
            bu.selected=YES;
        }else{
            bu.selected=NO;
        
        }
    }
    



}
-(void)deleteimagearr:(NSInteger)index{

    [_imagesarr removeObjectAtIndex:index];
    [_lastFileName removeObjectAtIndex:index];
    //view2.array=_imagesarr;
    //[view2 reloacollectionview];
    [_collectionview reloadData];


}

-(void)buttonclick{
   
    

    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:self.view];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(actionSheet==_deletesheet){
    
        [self  deleteimagearr:_deletesheet.tag];
    
    }else{
    
    
    
    
      
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1: //相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            return;
    }

    // 判断是否支持相机
    if (sourceType==UIImagePickerControllerSourceTypeCamera) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [Uikility alert:@"相机不能用！"];
            return;
        }
        
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];

    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
     [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImagePNGRepresentation(_iconView.image)将图片转成NSData
    //第一个参数是需要上传的文件（NSData格式）
    //第二个参数是后台规定的参数名
    //第三个参数告诉后台我的图片叫什么，其实没什么意义
    //第四个参数，文件类型

    
    UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImage *im=[[UIImage alloc]init];
    im=[self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
        NSData *data;
        if (UIImagePNGRepresentation(im)==nil) {
            data=UIImageJPEGRepresentation(im, 1);
            NSString *str=[NSString stringWithFormat:@"%@",@".jpg"];
            [_lastFileName addObject:str];
        }
        else{
            data=UIImagePNGRepresentation(im);
            NSString *str=[NSString stringWithFormat:@"%@",@".png"];
            [_lastFileName addObject:str];
        }
   // NSData *_data = UIImageJPEGRepresentation(im, 1.0f);
    //NSData *imdata=[UIImage]
    
    [_imagesarr addObject:data];
   // view2.array=_imagesarr;
    [_collectionview reloadData];
    //NSData *  = [_data base64Encoding];



}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

-(void)postreturnreson{
    if (_plomrpage==0) {
        
        [Uikility alert:@"请选择退货原因"];
        return;
    }
    if (_imagesarr.count==0) {
        [Uikility alert:@"请选择图片"];
        return;
    }
    if(textfiled.text.length==0){
        [Uikility alert:@"请填写退货理由"];
        return ;
    
    }
    for (int i=0; i<_imagesarr.count; i++) {
       NSString *bassdata=[GTMBase64 encodeBase64Data:_imagesarr[i]];
        [_bassimagearr addObject:bassdata];
    }
    
    NSString * urlstr=[BassAPI requestUrlWithPorType:PortTypeReturegoods];
    
    NSMutableDictionary *mudic=[[NSMutableDictionary alloc] init];
    
    //NSDictionary *dic=@{@"userId":[de objectForKey:@"userId"],@"sessionid":[de objectForKey:@"sessionid"],@"model":@1,@"ios_version":VERSION};
    [mudic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
    [mudic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
    if ([de objectForKey:@"newUserId"]) {
      [mudic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
    }
    
    [mudic setObject:@1 forKey:@"model"];
    [mudic setObject:VERSION forKey:@"ios_version"];
    [mudic setObject:_bassimagearr forKey:@"images"];
    [mudic setObject:_lastFileName forKey:@"lastFileName"];
    NSString * page=[NSString stringWithFormat:@"%zd",_plomrpage];
    [mudic setObject:page forKey:@"problem"];
    //[mudic setObject:<#(nonnull id)#> forKey:@""];
    if (_flag==1) {
        NSDictionary *dic=@{@"id":_apporderid};
        NSString *jsonstr=[Uikility initWithdatajsonstring:dic];
       
        [mudic setObject:jsonstr forKey:@"apporderId"];
        
    }else if (_flag==2){
        NSDictionary *dic=@{@"id":_apporderid};
        NSString *jsonstr=[Uikility initWithdatajsonstring:dic];
        [mudic setObject:jsonstr forKey:@"appyyorderId"];
    
    }else if (_flag==3){
        NSDictionary *dic=@{@"id":_apporderid};
        NSString *jsonstr=[Uikility initWithdatajsonstring:dic];
        [mudic setObject:jsonstr forKey:@"appsmorderId"];

    
    
    }
    if (textfiled.text.length!=0) {
        [mudic setObject:textfiled.text forKey:@"explain"];
    }
    
    NSDictionary *dicurl=[Uikility  initWithdatajson:mudic];
//    [manger POST:urlstr parameters:dicurl constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//       // [formData appendPartWithFileData:<#(NSData *)#> name:<#(NSString *)#> fileName:<#(NSString *)#> mimeType:<#(NSString *)#>]
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [Uikility alert:@"加载失败"];
//    }];
    
    
    [AFManger postWithURLString:urlstr parameters:dicurl success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        Boolean sucess=[[object objectForKey:@"success"] boolValue];
        if (sucess) {
            [Uikility alert:@"上传成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }

    } failure:^(NSError *error) {
         [Uikility alert:@"上传失败"];
    }];
        



}

//-(void)pushpop{
//    [self.navigationController popViewControllerAnimated:YES];
//
//
//
//}
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
