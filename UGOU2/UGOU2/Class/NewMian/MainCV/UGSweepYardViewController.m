//
//  UGSweepYardViewController.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/1/5.
//
//

#import "UGSweepYardViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Uikility.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "SpViewController.h"
#define SCANVIEW_EdgeTop 40.0
#define SCANVIEW_EdgeLeft 50.0
#define TINTCOLOR_ALPHA 0.2 //浅色透明度
#define DARKCOLOR_ALPHA 0.5 //深色透明度
@interface UGSweepYardViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    
    AVCaptureSession *session;//输入输出中间桥梁
    UIView *AVCapView;//此 view用来放扫描框 取消按钮 说明lable
    UIView *_QrCodeline;//上下移动绿色线条
    NSTimer *_timer;
    
    NSUserDefaults *de;
}

@end

@implementation UGSweepYardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    de=[NSUserDefaults standardUserDefaults];
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, [UIScreen mainScreen].bounds.size.height -64*KIphoneWH)];
    AVCapView = tempView;
    AVCapView.backgroundColor = [UIColor colorWithRed:54.f/255 green:53.f/255 blue:58.f/255 alpha:1];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*KIphoneWH, [UIScreen mainScreen].bounds.size.height - 150*KIphoneWH, 50*KIphoneWH, 25*KIphoneWH)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15*KIphoneWH, SCANVIEW_EdgeTop*KIphoneWH + WIDTH- 2 * SCANVIEW_EdgeLeft*KIphoneWH+20*KIphoneWH, 290*KIphoneWH, 60*KIphoneWH)];
    label.numberOfLines = 0;
    label.text = @"小提示：将条形码或二维码对准上方区域中心即可";
    label.textColor = [UIColor grayColor];
    [cancelBtn setTitle:@"取消" forState: UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchAVCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [AVCapView addSubview:label];
    [AVCapView addSubview:cancelBtn];
    [self.view addSubview:AVCapView];
    
    
    //画上边框
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH, SCANVIEW_EdgeTop*KIphoneWH, WIDTH- 2 * SCANVIEW_EdgeLeft*KIphoneWH, 1)];
    topView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:topView];
    
    //画左边框
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH, SCANVIEW_EdgeTop*KIphoneWH , 1,WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH )];
    leftView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:leftView];
    
    //画右边框
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH + WIDTH- 2 * SCANVIEW_EdgeLeft*KIphoneWH, SCANVIEW_EdgeTop*KIphoneWH , 1,WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH + 1)];
    rightView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:rightView];
    
    //画下边框
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH, SCANVIEW_EdgeTop*KIphoneWH + WIDTH- 2 * SCANVIEW_EdgeLeft*KIphoneWH,WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH ,1 )];
    downView.backgroundColor = [UIColor whiteColor];
    [AVCapView addSubview:downView];
    
    
    //画中间的基准线
    _QrCodeline = [[UIView alloc] initWithFrame:CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH + 1, SCANVIEW_EdgeTop*KIphoneWH, WIDTH- 2 * SCANVIEW_EdgeLeft*KIphoneWH - 1, 2)];
    _QrCodeline.backgroundColor = [UIColor greenColor];
    [AVCapView addSubview:_QrCodeline];
    
    
    // 先让基准线运动一次，避免定时器的时差
    [UIView animateWithDuration:1.2 animations:^{
        
        _QrCodeline.frame = CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH + 1, WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH + SCANVIEW_EdgeTop*KIphoneWH , WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH - 1, 2);
        
    }];
    
    [self performSelector:@selector(createTimer) withObject:nil afterDelay:0.4];
    
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame = CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH, SCANVIEW_EdgeTop*KIphoneWH, WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH, WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH);
    [AVCapView.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
-(void)popmain{
    [self.navigationController popViewControllerAnimated:YES];

}
//创建定时器
- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
}
#pragma mark***********滚动条上下滚动
-(void)moveUpAndDownLine{
    
    CGFloat YY = _QrCodeline.frame.origin.y;
    
    if (YY != WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH + SCANVIEW_EdgeTop*KIphoneWH ) {
        [UIView animateWithDuration:1.2 animations:^{
            _QrCodeline.frame = CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH + 1,WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH + SCANVIEW_EdgeTop*KIphoneWH , WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH - 1,2);
        }];
    }else {
        [UIView animateWithDuration:1.2 animations:^{
            _QrCodeline.frame = CGRectMake(SCANVIEW_EdgeLeft*KIphoneWH + 1, SCANVIEW_EdgeTop*KIphoneWH, WIDTH - 2 * SCANVIEW_EdgeLeft*KIphoneWH - 1,2);
        }];
    }



}
#pragma mark********扫描成功的代理
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        //NSLog(@"%@",metadataObject.stringValue);
        
        
        [self scanSuccess:metadataObject.stringValue];
        
        [session stopRunning];
        [self stopTimer];
        [AVCapView removeFromSuperview];
        
    }
}

#pragma mark**********取消按钮
-(void)touchAVCancelBtn{
    [session stopRunning];//摄像也要停止
    [self stopTimer];//定时器要停止
    [AVCapView removeFromSuperview];//刚刚创建的 view 要移除
    [self.navigationController popViewControllerAnimated:YES];
    


}
//定时器停止
- (void)stopTimer
{
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
    
}
-(void)scanSuccess:(NSString *)metadataStr{
    
    [session stopRunning];//摄像也要停止
    [self stopTimer];//定时器要停止
    [AVCapView removeFromSuperview];
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
       //NSLog(@"%@",objct);
       
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
               [Uikility alert:[objct objectForKey:@"没有找到该商品"]];
               [self.navigationController popViewControllerAnimated:YES];
           }else{
           spVC.flag=1;
           spVC.goodsId=goodid;
           [self.navigationController pushViewController:spVC animated:YES];
           }
       }else{
       
           [Uikility alert:[objct objectForKey:@"没有找到该商品"]];
           [self.navigationController popViewControllerAnimated:YES];
       
       }
       
       
   } failure:^(NSError *error) {
       [self.navigationController popViewControllerAnimated:YES];
       [Uikility alert:@"查询商品失败"];
   }];


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
