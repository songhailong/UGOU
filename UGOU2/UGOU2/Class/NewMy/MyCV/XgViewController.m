//
//  XgViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 15/10/27.
//  Copyright © 2015年 靓萌服饰. All rights reserved.
//
/*
 xujing2015.10.27.9.24 我的资料
 */
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height

#import "XgViewController.h"
#import "AFManger.h"
#import "TableViewCell.h"
#import "PMViewController.h"
#import "MyViewController.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "GTMBase64.h"
@interface XgViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    UITextField *ufield;
    UITextField *mfield;
    UITextField *nfield;
   // UITextField *yfield;
    UITextField *sfield;
    UITextField *pfield;
    UIButton *but;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    NSTimer *_timer1;
    UILabel *timelabel;
    UILabel *label;
   // UIView *view;
    UIView *headview;
    NSDictionary *dictionary;
    UIImageView *imv;
    UIView *_footview;
    NSUserDefaults *de;
   
 
}
@end

@implementation XgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden=NO;
    
    [self addnavview];
    [self addtableview];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    de = [NSUserDefaults standardUserDefaults];
        if ([de objectForKey:@"headimg"]==nil) {
             _headimg.image=[UIImage imageNamed:@"头像底圈"];
        }else{
            if ([[de objectForKey:@"headimgbase"] isEqual:@"base"]) {
                
               // NSData *_decodedImageData =[[NSData alloc] initWithBase64Encoding:[de objectForKey:@"headimg"]];
               
                NSData *_decodedImageData=[[NSData alloc] initWithBase64EncodedString:[de objectForKey:@"headimg"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                UIImage *Image      = [UIImage imageWithData:_decodedImageData];
                _headimg.image=Image;
            }else{
               
            [_headimg sd_setImageWithURL:[de objectForKey:@"headimg"]];
            }
        }

    if ([de objectForKey:@"username"]==nil) {
        
    }else{
        nfield.text=[de objectForKey:@"username"];
    }
    if ([de objectForKey:@"mobile"]==nil) {
        
    }else{
        sfield.text=[de objectForKey:@"mobile"];
    }  if ([de objectForKey:@"pass"]==nil) {
        
    }else{
        pfield.text=[de objectForKey:@"pass"];
    }
    if ([de objectForKey:@"birthday"]==nil) {
        
    }else{
        ufield.text=[de objectForKey:@"birthday"];
    }
    if ([de objectForKey:@"address"]==nil) {
        
    }else{
        mfield.text=[de objectForKey:@"address"];
    }
}

#pragma mark 2015.10.27.2.30 导航栏
-(void)addnavview{
    UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    titlelabel.textColor=[UIColor whiteColor];
    titlelabel.text=@"我的资料";
    titlelabel.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=titlelabel;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(push:)];
    leftButton.tag=1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem=leftButton;
}
#pragma mark tableview  方便上下滑动
-(void)addtableview{
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 510*KIphoneWH) style:UITableViewStylePlain];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=60*KIphoneWH;
    [self addheadview];
    table.tableHeaderView=headview;
    [self addfoot];
    table.tableFooterView=_footview;

}
-(void)addfoot{
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 5*KIphoneWH, WIDTH, 60*KIphoneWH)];
    UIButton *dlbut=[[UIButton alloc]init];
    dlbut.frame=CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-20*KIphoneWH, 50*KIphoneWH);
    [dlbut setBackgroundImage:[UIImage imageNamed:@"完--成"] forState:UIControlStateNormal];
    [dlbut addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    dlbut.tag=2;
    [_footview addSubview:dlbut];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
  if (indexPath.row==0){
            nfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-70*KIphoneWH, 40*KIphoneWH)];
            [nfield setBorderStyle:UITextBorderStyleNone];
            nfield.placeholder=@"昵称";
            nfield.clearButtonMode=YES;
            nfield.delegate=self;
            nfield.tag=1;
            nfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
            nfield.keyboardType=UIKeyboardTypeDefault;
            [cell addSubview:nfield];
    }else if (indexPath.row==1){
        
        ufield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-70*KIphoneWH, 40*KIphoneWH)];
        [ufield setBorderStyle:UITextBorderStyleNone];
        ufield.placeholder=@"生日";
        ufield.clearButtonMode=YES;
        ufield.delegate=self;
        ufield.tag=2;
        ufield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
        ufield.keyboardType=UIKeyboardTypeDecimalPad;
        [cell addSubview:ufield];

        
    }else if (indexPath.row==2){
        mfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-70*KIphoneWH, 40*KIphoneWH)];
        [mfield setBorderStyle:UITextBorderStyleNone];
        mfield.placeholder=@"地址";
        mfield.clearButtonMode=YES;
        mfield.keyboardType=UIKeyboardTypeDefault;
        mfield.tag=3;
        mfield.delegate=self;
        mfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
        [cell addSubview:mfield];

        
    }else if (indexPath.row==3){
        sfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-70*KIphoneWH, 40*KIphoneWH)];
        [sfield setBorderStyle:UITextBorderStyleNone];
        sfield.placeholder=@"手机号";
        [sfield resignFirstResponder];
        sfield.clearButtonMode=YES;
        sfield.keyboardType=UIKeyboardTypeDefault;
        sfield.tag=4;
        sfield.delegate=self;
        sfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
        [cell addSubview:sfield];
        

        
    }else if (indexPath.row==4){
        pfield=[[UITextField alloc]initWithFrame:CGRectMake(10*KIphoneWH, 5*KIphoneWH, WIDTH-70*KIphoneWH, 40*KIphoneWH)];
        [pfield setBorderStyle:UITextBorderStyleNone];
        pfield.placeholder=@"密码";
        pfield.clearButtonMode=YES;
        pfield.keyboardType=UIKeyboardTypeDefault;
        pfield.tag=5;
        pfield.secureTextEntry=YES;
        pfield.delegate=self;
        pfield.textColor=[UIColor colorWithRed:141/255.0 green:133/255.0 blue:148/255.0 alpha:1];
        [cell addSubview:pfield];
 
    }

    UIImage *im=[UIImage imageNamed:@"向前"];
        imv=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-50*KIphoneWH, 15*KIphoneWH,10*KIphoneWH, 10*KIphoneWH)];
        imv.image=im;
        [cell addSubview:imv];
        imv.tag=indexPath.row+1;
        imv.userInteractionEnabled=YES;
        UITapGestureRecognizer *imvtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushpm:)];
        [imv addGestureRecognizer:imvtap];
    


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 头部视图 上传头像
-(void)addheadview{
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 5*KIphoneWH, WIDTH, 150*KIphoneWH)];
    headview.backgroundColor=[UIColor whiteColor];
    UILabel *headlabel=[[UILabel alloc]initWithFrame:CGRectMake(10*KIphoneWH, 60*KIphoneWH, 100*KIphoneWH, 30*KIphoneWH)];
    headlabel.text=@"头像";
    headlabel.textColor=[UIColor  colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    [headview addSubview:headlabel];

    _headimg=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-180*KIphoneWH, 20*KIphoneWH, 100*KIphoneWH, 100*KIphoneWH)];
    UITapGestureRecognizer *imgtap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UesrImageClicked)];
    
    [headview addGestureRecognizer:imgtap];
    _headimg.layer.cornerRadius=50*KIphoneWH;
    _headimg.clipsToBounds=YES;

    [headview addSubview:_headimg];
    UIImageView *imv1=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-40*KIphoneWH, 60*KIphoneWH, 10*KIphoneWH, 10*KIphoneWH)];
    imv1.image=[UIImage imageNamed:@"向前"];
    [headview addSubview:imv1];
    [self.view addSubview:headview];

}
#pragma mark 头像
- (void)UesrImageClicked{
    UIActionSheet *sheet= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

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
#pragma mark 获取到图片 并上传
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *im=[[UIImage alloc]init];
    im=[self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
//    NSData *data;
//    if (UIImagePNGRepresentation(im)==nil) {
//        data=UIImageJPEGRepresentation(im, 1);
//    }
//    else{
//        data=UIImagePNGRepresentation(im);
//    }
    NSData *_data = UIImageJPEGRepresentation(im, 1.0f);
    NSString *_str = [GTMBase64 encodeBase64Data:_data];
    // NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    
    if ([de objectForKey:@"userId"]) {
        
    
    NSString *userid=[de objectForKey:@"userId"];
     NSNumber * nums = @([userid integerValue]);
    NSString *sessionid=[de objectForKey:@"sessionid"];
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetUpHeadimg];
        NSMutableDictionary *dic=[Uikility creatSinGoMutableDictionary];
        [dic setObject:_str forKey:@"headimg"];
//    NSDictionary  * dic=@{@"sessionid":sessionid,@"userId ":nums,@"newUserId":[de objectForKey:@"newUserId"],@"headimg":_str,@"model":@1,@"ios_version":VERSION};

        NSDictionary *json1=[Uikility initWithdatajson:dic];
   [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
       id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
       
       Boolean success=[[obj objectForKey:@"success"] boolValue];
       
       if (success) {
           [Uikility alert:@"修改成功"];
           _headimg.image=image;
           //存储
           
           [de setObject:_str forKey:@"headimg"];
           
           [de setObject:@"base" forKey:@"headimgbase"];
           //同步存储到磁盘
           [de synchronize];
       }else{
           [Uikility alert:[obj objectForKey:@"msg"]];
       }

       
   } failure:^(NSError *error) {
       [Uikility alert:@"连接失败！"];
   }];
    //服务器允许的请求内容格式
    }else{
        [Uikility alert:@"请先登录！"];
    }
}
#pragma mark 更改图片大小
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
#pragma mark 点击后 手机 密码
-(void)pushpm:(UIGestureRecognizer *)g{
        if (g.view.tag==4){
            PMViewController *pm=[[PMViewController alloc]init];
            pm.flag=2;
            [self.navigationController pushViewController:pm animated:YES];
    
        }else if (g.view.tag==5){
            PMViewController *pm=[[PMViewController alloc]init];
            pm.flag=3;
            [self.navigationController pushViewController:pm animated:YES];
        }else{
        
        }
}
#pragma mark 返回
-(void)push:(UIButton *)b{
    //返回上一页
    if (b.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
      //  MyViewController *my=[[MyViewController alloc]init];
       // [self.navigationController pushViewController:my animated:YES];
    }else if (b.tag==2){
        //判断是否修改
        if (((nfield.text.length==0)||[[de objectForKey:@"username"]isEqualToString: nfield.text])&&((ufield.text.length==0)||[[de objectForKey:@"birthday"]isEqualToString:ufield.text])&&((mfield.text.length==0)||[[de objectForKey:@"address"]isEqualToString:mfield.text])) {
           [Uikility alert:@"没有修改！"];
            return;
        }
        [self postMethod];
    }
}

#pragma mark 上传数据到后台
-(void)postMethod{
    if ([de objectForKey:@"userId"]) {
        
    
    NSString *userid=[de objectForKey:@"userId"];
    NSNumber * nums = @([userid integerValue]);
        dictionary=@{@"userId":nums,@"username":nfield.text,@"birthday":ufield.text,@"address":mfield.text,@"model":@1,@"sessionid":[de objectForKey:@"sessionid"],@"newUserId":[de objectForKey:@"newUserId"],@"model":@1,@"ios_version":VERSION};
   
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetUpUser];
    
    NSDictionary *json1=[Uikility initWithdatajson:dictionary];
        
    [AFManger postWithURLString:url parameters:json1 success:^(id responseObject) {
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[obj objectForKey:@"success"] boolValue];
        
        if (success) {
            //存储
            if (ufield.text.length) {
                [de setObject:ufield.text forKey:@"birthday"];
            }
            if (nfield.text.length) {
                [de setObject:nfield.text forKey:@"username"];
            }
            if (mfield.text.length) {
                [de setObject:mfield.text forKey:@"address"];
            }
            //同步存储到磁盘
            [de synchronize];
            //要改
            [Uikility alert:@"修改成功！"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Uikility alert:[obj objectForKey:@"msg"]];
        }

        
    } failure:^(NSError *error) {
       [Uikility alert:@"连接失败！"];
    }];
    }else{
        [Uikility alert:@"请先登录！"];
    }
}




//只允许输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
    if (textField==sfield) {
        return [self validateNumber:string];
    }
    
    return YES;
   }
//只许数字输入
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
#pragma mark 点击uitextfield 时 上方内容
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag>=4) {
        //只读权限 不能编辑
        if (textField.tag==4) {
             [sfield resignFirstResponder];
            PMViewController *pm=[[PMViewController alloc]init];
            pm.flag=2;
            [self.navigationController pushViewController:pm animated:YES];
            
        }else if(textField.tag==5){
        [pfield resignFirstResponder];
            PMViewController *pm=[[PMViewController alloc]init];
            pm.flag=3;
            [self.navigationController pushViewController:pm animated:YES];
        }
        
    }else{
    [self addtoolBar];
      }
}
//点击空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [mfield resignFirstResponder];
    [ufield resignFirstResponder];
    //[yfield resignFirstResponder];
    [nfield resignFirstResponder];
   // view.frame=CGRectMake(0, 170, WIDTH, 600);

}
//下方  键盘消失
-(void)addtoolBar{
    UIToolbar *topview=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 30*KIphoneWH)];
    [topview setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *but1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *but2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *donebut=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray *butarr=[NSArray arrayWithObjects:but1,but2,donebut, nil];
    [topview setItems:butarr];
    [mfield setInputAccessoryView:topview];
    [ufield setInputAccessoryView:topview];
    //[yfield setInputAccessoryView:topview];
    [nfield setInputAccessoryView:topview];

}
-(void)resignKeyboard{
    [mfield resignFirstResponder];
    [ufield resignFirstResponder];
    //[yfield resignFirstResponder];
    [nfield resignFirstResponder];
    
   // view.frame=CGRectMake(0, 170, WIDTH, 600);
    
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
