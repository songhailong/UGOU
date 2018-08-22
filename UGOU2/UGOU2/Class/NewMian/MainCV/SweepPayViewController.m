//
//  SweepPayViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/5/12.
//
//

#import "SweepPayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Uikility.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "SpViewController.h"


#define LEFT (WIDTH-260*KIphoneWH)/2
#define TOP  80*KIphoneWH
//AVCaptureMetadataOutputObjectsDelegate   扫描元数据代理
@interface SweepPayViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    //扫描摄影区
    CAShapeLayer *cropLayer;
}
//AVCaptureDevice实例可用于提供媒体数据创建一个的AVCaptureSession AVCaptureDeviceInput捕获会话的设备和添加。
@property(nonatomic,strong)AVCaptureDevice *device;
//输入源
@property(nonatomic,strong)AVCaptureDeviceInput* input;
//元数据输出
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
//session 通道
@property(nonatomic,strong)AVCaptureSession *session;
//
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@property(nonatomic,strong)UIImageView *line;
@end

@implementation SweepPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
  [self configView];
    // Do any additional setup after loading the view.
}
-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-260*KIphoneWH)/2, TOP, 260*KIphoneWH, 260*KIphoneWH)];
    //imageView.backgroundColor=[UIColor redColor];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-260*KIphoneWH)/2, TOP+10*KIphoneWH, 260*KIphoneWH, 2*KIphoneWH)];
    _line.image = [UIImage imageNamed:@"line.png"];
    
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized||status==AVAuthorizationStatusNotDetermined) {
        // authorized
        //[self setupCamera];
        //UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“U购”打开相机访问权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        //[alert show];
        [self setupCamera];
    } else {
        //[SVProgressHUD showWithStatus:tips];
       // []
        //[self setupCamera];
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“U购”打开相机访问权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
    
    //[self setupCamera];
//    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*KIphoneWH, [UIScreen mainScreen].bounds.size.height - 150*KIphoneWH, 50*KIphoneWH, 25*KIphoneWH)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15*KIphoneWH, 410*KIphoneWH, 290*KIphoneWH, 60*KIphoneWH)];
//    label.numberOfLines = 0;
//    label.text = @"小提示：将条形码或二维码对准上方区域中心即可";
//    label.textColor = [UIColor grayColor];
//    [cancelBtn setTitle:@"取消" forState: UIControlStateNormal];
//    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(touchAVCancelBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:label];
//    [self.view addSubview:cancelBtn];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self  creatNatav];
   [self setCropRect:CGRectMake((WIDTH-260*KIphoneWH)/2, TOP, 260*KIphoneWH, 260*KIphoneWH)];
    //[self performSelector:@selector(setupCamera)withObject:nil afterDelay:6];

}
#pragma mark*******创建扫描区域
- (void)setCropRect:(CGRect)cropRect{
    
    
    
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

-(void)creatNatav{
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden =YES;
    self.navigationController.navigationBar.hidden = NO;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, 40*KIphoneWH, 50*KIphoneWH)];
    label.textColor=[UIColor whiteColor];
    label.text=@"扫码支付";
    label.font=[UIFont systemFontOfSize:20];
    self.navigationItem.titleView=label;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回o"] style:UIBarButtonItemStyleDone target:self action:@selector(popmain)];
    self.navigationItem.leftBarButtonItem=leftButton;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1@2x"] forBarMetrics:UIBarMetricsDefault];
    //self.navigationItem.rightBarButtonItem=rightButton;
    self.navigationController.navigationBar.translucent=NO;

}
-(void)setupCamera{
    //获取摄像头
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(device==nil){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;

    }
    
    _device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //设备的输入流
    _input=[AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //设备输出流
    _output=[[AVCaptureMetadataOutput alloc ] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    ///top 与 left 互换  width 与 height 互换
    CGFloat top=TOP/HEIGHT;
    CGFloat left=LEFT/WIDTH;
    CGFloat width=260*KIphoneWH/WIDTH;
    CGFloat height=260*KIphoneWH/HEIGHT;
    //设置扫描范围（每一个值0--1，以屏幕右上角为坐标原点）
    [_output setRectOfInterest:CGRectMake(top, left,height, width)];
    //创建  session
    _session=[[AVCaptureSession alloc] init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if([_session canAddInput:self.input]){
        //_session通道 添加输入流
        [_session addInput:self.input];
    }
    if([_session canAddOutput:self.output]){
        //添加输出流
        [_session addOutput:self.output];
    }
    
    //条码类型（AVMetadataObjectTypeQRCode，）
    _output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    //实例化图层 传递——_session是为了告诉图层将来显示什么内容
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
   
    //启动扫描
    [_session startRunning];


}
-(void)popmain{
  [self.navigationController popViewControllerAnimated:YES];

}

-(void)animation1{

    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10*KIphoneWH+2*num*KIphoneWH, 260*KIphoneWH, 2*KIphoneWH);
        if (2*num == 240) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10*KIphoneWH+2*num*KIphoneWH, 260*KIphoneWH, 2*KIphoneWH);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}
#pragma mark***********扫描成功的代理
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if(metadataObjects.count>0){
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        //AVMetadataMachineReadableCodeObject 扫描结果类
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
       
        [self scanSuccess:metadataObject.stringValue];
    }else{
        //NSLog(@"没有扫描结果");
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)scanSuccess:(NSString *)metadataStr{
    
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    NSString *urlstr=[BassAPI requestUrlWithPorType:PortTypeSearchGoods];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    if ([de objectForKey:@"userId"]) {
        [dic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [dic setObject:[de objectForKey:@"sessionid"]forKey:@"sessionid"];
        if ([de objectForKey:@"newUserId"]) {
            [dic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
    }
    [dic setObject:@1 forKey:@"model"];
    [dic setObject:VERSION forKey:@"ios_version"];
    if ([de objectForKey:@"placename"]) {
        [dic setObject:[de objectForKey:@"placename"] forKey:@"area"];
    }
    
    [dic setObject:metadataStr forKey:@"barCode"];
    [dic setObject:@0 forKey:@"min"];
    [dic setObject:@10 forKey:@"max"];
    //
    
    
    NSDictionary *jsondic=[Uikility initWithdatajson:dic];
    [AFManger postWithURLString:urlstr parameters:jsondic success:^(id responseObject) {
        id objct=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
      
        
        BOOL sucess=[[objct objectForKey:@"success"]boolValue];
        if (sucess) {
            
            SpViewController*spVC=[[SpViewController alloc] init];
            NSArray *dataArr=[objct objectForKey:@"data"];
            NSString *goodid=nil;
            //NSLog(@"%@",objct);
            for (NSDictionary *datadic in dataArr) {
                //NSDictionary *datadic=arr[0];
                goodid=[NSString stringWithFormat:@"%@",[datadic  objectForKey:@"id"]];
            }
            if (dataArr.count==0) {
                [Uikility alert:@"没有找到该商品"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                spVC.flag=1;
                spVC.goodsId=goodid;
                [self.navigationController pushViewController:spVC animated:YES];
            }
        }else{
            
            [Uikility alert:@"没有找到该商品"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [Uikility alert:@"查询商品失败"];
    }];
    
    
}
-(void)touchAVCancelBtn{
    [self.navigationController popViewControllerAnimated:YES];

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
