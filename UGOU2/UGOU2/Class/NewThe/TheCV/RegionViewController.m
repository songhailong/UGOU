//
//  RegionViewController.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "RegionViewController.h"
#import "AFManger.h"
#import "Uikility.h"
#import "BassAPI.h"
#import "CityPlaceModel.h"
@interface RegionViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *_provincearr;
    NSMutableArray *_cityarr;
    NSMutableArray *_regionarr;
    NSMutableArray * _placearr;
    UITableView *_tableview1;
    UITableView *_tableview2;
    UITableView *_tableview3;
    UITableView *_tableview4;
    UIImageView *_imageview;
    UILabel *_titlelable;
    UIScrollView *_scrollview;
    NSMutableString *_placestr;

}

@end

@implementation RegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _provincearr=[[NSMutableArray alloc] init];
    _cityarr=[[NSMutableArray alloc] init];
    _regionarr=[[NSMutableArray alloc] init];
    _placearr=[[NSMutableArray alloc] init];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatUI];
    [self readdata:1 placeid:0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-40*KIphoneWH, 20*KIphoneWH, 80*KIphoneWH, 50*KIphoneWH)];
    _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    UIImage *image=[UIImage imageNamed:@"矩形-1@2x"];
    _imageview.image=image;
    //_imageview.backgroundColor=[UIColor greenColor];
    
    _imageview.userInteractionEnabled=YES;
    label.textColor=[UIColor whiteColor];
    label.text=@"选择地区";
    label.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [_imageview addSubview:label];
    
    UIButton *leftButton =[[UIButton alloc]initWithFrame:CGRectMake(0*KIphoneWH, 0*KIphoneWH, 60*KIphoneWH, 64*KIphoneWH )];
    //[leftButton setImage:[UIImage imageNamed:@"返回o"] forState:UIControlStateNormal];
    UIImage *img=[UIImage imageNamed:@"返回p"];
    UIImageView *imgv=[[UIImageView alloc]initWithImage:img];
    [leftButton addSubview:imgv];
    imgv.frame=CGRectMake(15*KIphoneWH, 35*KIphoneWH, 10*KIphoneWH, 14*KIphoneWH);
    
    [leftButton addTarget:self action:@selector(pushmain) forControlEvents:UIControlEventTouchDown];
    
    leftButton.tag=1;
    
    [self.view addSubview:_imageview];
    [_imageview  addSubview:leftButton];
    
    
}
-(void)pushmain{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)creatUI{
    
    _titlelable=[[UILabel alloc] initWithFrame:CGRectMake(0, 64*KIphoneWH, WIDTH, 60*KIphoneWH)];
    
    for (int i=0; i<4; i++) {
        UIButton *but=[[UIButton alloc] initWithFrame:CGRectMake(WIDTH/4*i, 0, WIDTH/4, 60*KIphoneWH)];
        but.tag=100+i;
        [but  setTitleColor:[UIColor colorWithRed:254.0/255.0 green:90.0/255.0 blue:72.0/255.0 alpha:1] forState:UIControlStateNormal];
        but.titleLabel.font=[UIFont systemFontOfSize:16*KIphoneWH];
        if (i==0) {
            [but setTitle:@"请选择" forState:UIControlStateNormal];
        }
        [_titlelable addSubview:but];
    }
    
    
    
    
    _scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 124*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
    _scrollview.pagingEnabled=YES;
    _scrollview.contentSize=CGSizeMake(WIDTH*4, HEIGHT-124*KIphoneWH);
    _scrollview.scrollEnabled=YES;
    _scrollview.bounces = NO;
    _scrollview.showsHorizontalScrollIndicator =NO;
    _scrollview.delegate=self;
    
    _tableview1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
    _tableview1.delegate=self;
    _tableview1.dataSource=self;
    _tableview1.separatorStyle=UITableViewCellSelectionStyleNone;
    _tableview2=[[UITableView alloc] initWithFrame:CGRectMake(WIDTH, 0*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
  
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    _tableview2.separatorStyle=UITableViewCellSelectionStyleNone;
    _tableview3=[[UITableView alloc] initWithFrame:CGRectMake(WIDTH*2, 0*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
    _tableview3.delegate=self;
    _tableview3.dataSource=self;
    _tableview3.separatorStyle=UITableViewCellSelectionStyleNone;
    _tableview4=[[UITableView alloc] initWithFrame:CGRectMake(WIDTH*3, 0*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
    _tableview4.delegate=self;
    _tableview4.dataSource=self;
    _tableview4.separatorStyle=UITableViewCellSelectionStyleNone;
    [_scrollview addSubview:_tableview1];
    [_scrollview addSubview:_tableview2];
    [_scrollview addSubview:_tableview3];
    [_scrollview addSubview:_tableview4];
    [self.view addSubview:_scrollview];
    [self.view addSubview:_titlelable];
   
}

//b  判断地区的第几级
-(void)readdata:(NSInteger)b placeid:(NSNumber *)placeid{
    NSString *Urlstr=[BassAPI requestUrlWithPorType:PortTypeGetChinaplace];
    NSDictionary *dic=nil;
    if (b==1) {
        dic=@{@"ios_version":VERSION,@"model":@1};
    }else if (b==2){
        dic=@{@"ios_version":VERSION,@"model":@1,@"pid":placeid};
    }else if (b==3){
        dic=@{@"ios_version":VERSION,@"model":@1,@"pid":placeid};
        
    }else if (b==4){
    dic=@{@"ios_version":VERSION,@"model":@1,@"pid":placeid};
    
    }

    NSDictionary *dicjson=[Uikility initWithdatajson:dic];
   [AFManger postWithURLString:Urlstr parameters:dicjson success:^(id responseObject) {
       id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       Boolean sucess=[[object objectForKey:@"success"] boolValue];
       if (sucess) {
           NSArray *arr=[object objectForKey:@"data"];
           for ( NSDictionary *dic in arr) {
               CityPlaceModel *model=[CityPlaceModel initWithdic:dic];
               if (b==1) {
                [_provincearr addObject:model];
               }else if (b==2){
               [_cityarr   addObject:model];
               }else if (b==3){
               [_regionarr addObject:model];
               }else if (b==4){
                   
                   [_placearr addObject:model];
               
               }
              
           }
           
           switch (b) {
               case 1:
                   [_tableview1 reloadData];
                   break;
               case 2:
                   _scrollview.contentSize=CGSizeMake(WIDTH*2, 0);
                   [_scrollview setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
                   [_tableview2 reloadData];
                   break;
               case 3:
                _scrollview.contentSize=CGSizeMake(WIDTH*3, HEIGHT-124*KIphoneWH);
                [_scrollview setContentOffset:CGPointMake(WIDTH*2, 0) animated:YES];
                   [_tableview3 reloadData];
                   break;
               case 4:
                   _scrollview.contentSize=CGSizeMake(WIDTH*4, HEIGHT-124*KIphoneWH);
                   [_scrollview setContentOffset:CGPointMake(WIDTH*3, 0) animated:YES];
                   [_tableview4 reloadData];
                   break;
               default:
                   break;
           }
        
           //[self creattableview:b];
           //[_tableview1 reloadData];
       }
   } failure:^(NSError *error) {
       [Uikility alert:@"请求失败"];
   }];


}

-(void)creattableview:(NSInteger)index{
    switch (index) {
        case 1:{
            _tableview2=[[UITableView alloc] initWithFrame:CGRectMake(WIDTH, 64*KIphoneWH, WIDTH, HEIGHT-124*KIphoneWH)];
            _tableview2.delegate=self;
            _tableview2.dataSource=self;
          [_scrollview addSubview:_tableview2];
        
        }
            
            break;
            
        default:
            break;
    }


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_tableview1) {
        if (_provincearr.count) {
            return _provincearr.count;
        }

    }else if (tableView==_tableview2){
        if (_cityarr.count) {
            return _cityarr.count;
        }
    
    }else if (tableView==_tableview3){
        if (_regionarr.count) {
            return _regionarr.count;
        }
    
    
    }else if (tableView==_tableview4){
        if (_placearr.count) {
                       return _placearr.count;
        }
    
    }
    
    
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 40*KIphoneWH;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"placecell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placecell"];
        //cell.selectedBackgroundView=[UIColor redColor];
    }
    if (tableView==_tableview1) {
        if (_provincearr.count) {
            CityPlaceModel *model=_provincearr[indexPath.row];
            cell.textLabel.text=model.name;
            
        }

        
    }else if (tableView==_tableview2){
        if (_cityarr.count) {
            CityPlaceModel *model=_cityarr[indexPath.row];
            cell.textLabel.text=model.name;
        }

    
    }else if (tableView==_tableview3){
        if (_regionarr.count) {
            CityPlaceModel *model=_regionarr[indexPath.row];
            cell.textLabel.text=model.name;
        }
    }else if (tableView==_tableview4){
            if (_placearr.count) {
                CityPlaceModel *model=_placearr[indexPath.row];
                cell.textLabel.text=model.name;
            }

        }
    
    
    
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableview1) {
        if(_provincearr.count){
            CityPlaceModel *model=_provincearr[indexPath.row];
            [_cityarr removeAllObjects];
            [_regionarr removeAllObjects];
            UIButton *bt=(id)[_titlelable viewWithTag:100];
            [bt setTitle:model.name forState:UIControlStateNormal];
            [self readdata:2 placeid:model.id];
        
        }
        
    }else if (tableView==_tableview2){
        if(_cityarr.count){
            CityPlaceModel *model=_cityarr[indexPath.row];
            [_regionarr removeAllObjects];
//            UIButton *rehisonbt=(id)[_titlelable viewWithTag:102];
//            [rehisonbt setTitle:@"" forState:UIControlStateNormal];
//            UIButton *placebt=(id)[_titlelable viewWithTag:103];
//            [placebt setTitle:@"" forState:UIControlStateNormal];
//            UIButton *bt=(id)[_titlelable viewWithTag:101];
//            [bt setTitle:model.name forState:UIControlStateNormal];
//            [self readdata:3 placeid:model.id];
//
            NSString *b=[model.name substringFromIndex:model.name.length-1];
            
            BOOL qu=[b isEqualToString:@"区"];
            BOOL xian=[b isEqualToString:@"县"];
            if (qu|| xian) {
                [self.placedelegate selectpalecereload:model.id placename:model.name];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                UIButton *rehisonbt=(id)[_titlelable viewWithTag:102];
                [rehisonbt setTitle:@"" forState:UIControlStateNormal];
                UIButton *placebt=(id)[_titlelable viewWithTag:103];
                [placebt setTitle:@"" forState:UIControlStateNormal];
                UIButton *bt=(id)[_titlelable viewWithTag:101];
                [bt setTitle:model.name forState:UIControlStateNormal];
                [self readdata:3 placeid:model.id];
            
            
            }
            
        }

        
    }else if (tableView==_tableview3){
        if (_regionarr.count) {
            CityPlaceModel *model=_regionarr[indexPath.row];
            if ([model.name isEqualToString:@"市辖区"]) {
                [_placearr removeAllObjects];
               
                UIButton *placebt=(id)[_titlelable viewWithTag:103];
                [placebt setTitle:@"" forState:UIControlStateNormal];
                UIButton *bt=(id)[_titlelable viewWithTag:102];
                [bt setTitle:model.name forState:UIControlStateNormal];
                [self readdata:4 placeid:model.id];
            }else {
            
                [self.placedelegate selectpalecereload:model.id placename:model.name];
                [self dismissViewControllerAnimated:YES completion:nil];
            
            }
            
    }
        
    }else if (tableView==_tableview4){
        if (_placearr.count) {
            CityPlaceModel * model=_placearr[indexPath.row];
            [self.placedelegate selectpalecereload:model.id placename:model.name];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
    
    }

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
