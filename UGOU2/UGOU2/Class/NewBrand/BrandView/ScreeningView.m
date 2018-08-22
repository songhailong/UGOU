//
//  ScreeningView.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/6/17.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "ScreeningView.h"
#import "Uikility.h"
#import "ScreenCollectionViewCell.h"
#import "ScreenCollectionReusableView.h"
#import "BassAPI.h"
#import "AFManger.h"
#import "AFNetworking.h"
#import "CategoryModel.h"
@implementation ScreeningView{
    NSArray *_toparr;
    NSMutableDictionary *_dic;
    UITextField *_textfile1;
    UITextField *_textfile2;
    UICollectionView *_colectionview2;
    UICollectionView *_colectionview3;

}

-(instancetype)initWithFrame:(CGRect)frame{
   
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatviews];
        
    }

    return self;

}
-(void)creatviews{
    _jsondic=[[NSMutableDictionary alloc] init];
    _dic=[[NSMutableDictionary alloc] init];
    _toparr=@[@"季节",@"分类",@"年份"];
    
    _dataarray=[[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        NSArray *arr=[[NSArray alloc] init];
        switch (i) {
            
            case 0:
                arr=@[@"春",@"夏",@"秋",@"冬"];
                [_dataarray addObject:arr];
                break;
            
            case 1:{
                CategoryModel  *mode=[[CategoryModel alloc] init];
                //NSString *numberid=[NSString stringWithFormat:@"%zd",6];
                mode.name=@"连衣裙";
                arr=@[mode];
                [_dataarray addObject:arr];
            }
                break;
            case 2:
                arr=@[@"2015",@"2016",@"2017"];
                [_dataarray addObject:arr];
                [self getYears];
                break;
                
            default:
                break;
        }
    }
    
    [self  classification];
    
    self.userInteractionEnabled=YES;
    
    UILabel *labletext=[[UILabel alloc] initWithFrame:CGRectMake(10*KIphoneWH, 20*KIphoneWH, 120*KIphoneWH, 50*KIphoneWH)];
   labletext.text=@"价格区间";
    labletext.textColor=[UIColor blackColor];
    labletext.font=[UIFont systemFontOfSize:20*KIphoneWH];
    [self addSubview:labletext];
    _textfile1=[[UITextField alloc] initWithFrame:CGRectMake(10*KIphoneWH, 70*KIphoneWH, 120*KIphoneWH, 30*KIphoneWH)];
    _textfile2=[[UITextField alloc] initWithFrame:CGRectMake(170*KIphoneWH, 70*KIphoneWH, 120*KIphoneWH, 30*KIphoneWH)];
    _textfile1.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    _textfile2.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    _textfile1.textAlignment=NSTextAlignmentCenter;
    _textfile2.textAlignment=NSTextAlignmentCenter;
    _textfile2.placeholder=@"最高价";
    _textfile1.placeholder=@"最低价";
    _textfile1.delegate=self;
    _textfile2.delegate=self;
    _textfile1.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _textfile2.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _textfile1.returnKeyType=UIReturnKeyDone;
    _textfile2.returnKeyType=UIReturnKeyDone;
    _textfile1.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _textfile2.font=[UIFont systemFontOfSize:14*KIphoneWH];
    _textfile2.layer.cornerRadius=5*KIphoneWH;
    _textfile1.layer.cornerRadius=5*KIphoneWH;
    [self addSubview:_textfile2];
    [self addSubview:_textfile1];
    
    UILabel *middlelable=[[UILabel alloc] initWithFrame:CGRectMake(130*KIphoneWH, 70*KIphoneWH, 40*KIphoneWH, 30*KIphoneWH)];
    middlelable.backgroundColor=[UIColor whiteColor];
    middlelable.text=@"-";
    middlelable.textAlignment=NSTextAlignmentCenter;
    [self addSubview:middlelable];
    
    
    _colectionview.contentInset=UIEdgeInsetsMake(0*KIphoneWH, 100*KIphoneWH, WIDTH-40*KIphoneWH, HEIGHT-130*KIphoneWH);
    
    UICollectionViewFlowLayout *viewlayout=[[UICollectionViewFlowLayout alloc] init];
   

    //竖屏还是横屏
    [viewlayout setScrollDirection: UICollectionViewScrollDirectionVertical];
     _colectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 100*KIphoneWH, WIDTH-40*KIphoneWH, HEIGHT-130*KIphoneWH) collectionViewLayout:viewlayout];
    viewlayout.minimumInteritemSpacing=5*KIphoneWH;
    _colectionview.backgroundColor=[UIColor whiteColor];
    
    _colectionview.delegate=self;
    _colectionview.dataSource=self;
    //_colectionview.allowsMultipleSelection=YES;
    [_colectionview registerClass:[ScreenCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heard"];
    
    [_colectionview registerClass:[ScreenCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_colectionview];
    
#pragma mark-------第二个
   _colectionview2.contentInset=UIEdgeInsetsMake(0*KIphoneWH, 100*KIphoneWH, WIDTH-40*KIphoneWH, HEIGHT-400*KIphoneWH);
    
    UICollectionViewFlowLayout *viewlayout2=[[UICollectionViewFlowLayout alloc] init];
    
    
    //竖屏还是横屏
    [viewlayout2 setScrollDirection: UICollectionViewScrollDirectionVertical];
    _colectionview2=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 100*KIphoneWH, WIDTH-40*KIphoneWH, HEIGHT-30*KIphoneWH) collectionViewLayout:viewlayout2];
    viewlayout2.minimumInteritemSpacing=5*KIphoneWH;
    _colectionview2.backgroundColor=[UIColor whiteColor];
    
   _colectionview2.delegate=self;
  _colectionview2.dataSource=self;
   _colectionview2.allowsMultipleSelection=YES;
    [_colectionview2 registerClass:[ScreenCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"secondheard"];
    [_colectionview2 registerClass:[ScreenCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //[self addSubview:_colectionview2];
    
    
    
    
    UIButton *surebt=[[UIButton alloc] initWithFrame:CGRectMake((WIDTH-40*KIphoneWH)/2, HEIGHT-40*KIphoneWH, (WIDTH-40*KIphoneWH)/2, 40*KIphoneWH)];
    [surebt addTarget:self action:@selector(surebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [surebt setTitle:@"确定" forState:UIControlStateNormal];
    surebt.backgroundColor=[UIColor colorWithRed:226.0/255.0 green:54.0/255.0 blue:35.0/255.0 alpha:1];
    surebt.titleLabel.textAlignment=NSTextAlignmentCenter;
    //surebt.backgroundColor=[UIColor redColor];
    //UIButton *czbut=[[UIButton alloc] initWithFrame:CGRectMake(0, HEIGHT-40*KIphoneWH, (WIDTH-40*KIphoneWH)/2, 40*KIphoneWH/)];
       // [czbut addTarget:self action:@selector(chongzhi:) forControlEvents:UIControlEventTouchUpInside];
       //[czbut setTitle:@"重置" forState:UIControlStateNormal];
   // czbut.backgroundColor=[UIColor greenColor];
    //czbut.titleLabel.textAlignment=NSTextAlignmentCenter;
    ///[self addSubview:czbut];
    [self addSubview:surebt];

}

-(void)getYears{
    NSString *yearurl=[BassAPI requestUrlWithPorType:PortTypeGetForYear];
    NSMutableDictionary *yeardic=[Uikility creatSinGoMutableDictionary];
    NSDictionary *jsondic= [Uikility initWithdatajson:yeardic];
    [AFManger postWithURLString:yearurl parameters:jsondic success:^(id responseObject) {
        id object=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BOOL sucess=[[object objectForKey:@"success"] boolValue];
        if (sucess) {
            
            NSMutableArray *dataArr=[[NSMutableArray alloc] init];
            NSArray *jsonarr=[object objectForKey:@"data"];
            for (NSDictionary *dataDic in jsonarr) {
                NSString *yearStr=[dataDic objectForKey:@"name"];
                [dataArr addObject:yearStr];
            }
            [_dataarray replaceObjectAtIndex:2 withObject:dataArr];
            
           
        }
        
        
    } failure:^(NSError *error) {
        [Uikility alert:@"当前网速不佳"];
    }];


}




//获取加密key值
-(void)classification{
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
  NSDictionary *  d=[[NSDictionary alloc]init];
    NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
    if ([de objectForKey:@"placename"]) {
        [dics setObject:[de objectForKey:@"placename"] forKey:@"area"];
        
    }

    
    
    if ([de objectForKey:@"userId"]) {
        
        [dics setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        [dics setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        if ([de objectForKey:@"newUserId"]) {
        [dics setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        }
        [dics setObject:@1 forKey:@"model"];
        [dics setObject:VERSION forKey:@"ios_version"];
        
        d=[Uikility initWithdatajson:dics];
    }else{
        NSDictionary *dicss=@{ @"model":@1,@"ios_version":VERSION };
        d=nil;
        d=[Uikility initWithdatajson:dicss];
    }
    NSString *url=[BassAPI requestUrlWithPorType:PortTypeGetHome];
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manger POST:url parameters:d progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *respons=(NSHTTPURLResponse *)task.response;
        [de setObject:respons.allHeaderFields[@"Set-Cookie"] forKey:@"setcookie"];//setcookie
        
      
        //NSLog(@"新的是%@",[de objectForKey:@"setcookie"]);
        
        
        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
        
        Boolean success=[[strs objectForKey:@"success"] boolValue];
        NSMutableArray *catearr=[[NSMutableArray alloc] init];
        if (success) {
            NSArray *dataarr=[[strs objectForKey:@"data"] objectForKey:@"category"];
            
            for (NSDictionary *datadic in dataarr) {
                
                [catearr addObject:[CategoryModel initwithModel:datadic]];
            }
            [catearr removeObjectAtIndex:0];
            [_dataarray replaceObjectAtIndex:1 withObject:catearr];
            [_colectionview reloadData];
            
        }else{
            [Uikility alert:[strs objectForKey:@"msg"]];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         //[Uikility alert:@"数据接受失败！"];
    }];
//    [AFManger postWithURLString:url parameters:d success:^(id responseObject) {
//        id strs = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];//解析
//        
//        Boolean success=[[strs objectForKey:@"success"] boolValue];
//        NSMutableArray *catearr=[[NSMutableArray alloc] init];
//        if (success) {
//            NSArray *dataarr=[[strs objectForKey:@"data"] objectForKey:@"category"];
//            
//            for (NSDictionary *datadic in dataarr) {
//                
//                [catearr addObject:[CategoryModel initwithModel:datadic]];
//            }
//            [catearr removeObjectAtIndex:0];
//            [_dataarray replaceObjectAtIndex:1 withObject:catearr];
//            [_colectionview reloadData];
//            
//        }else{
//            [Uikility alert:[strs objectForKey:@"msg"]];
//        }
//
//    } failure:^(NSError *error) {
//       [Uikility alert:@"数据接受失败！"];
//    }];
    

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textfile1 resignFirstResponder];
    [_textfile2 resignFirstResponder];

    return YES;

}
-(void)surebuttonclick:(UIButton *)bt{
    
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
  
    if (_textfile2.text.length!=0) {
        [_jsondic setObject:_textfile2.text forKey:@"maxMoney"];
    }
    if (_textfile1.text.length!=0) {
        [_jsondic setObject:_textfile1.text forKey:@"minMoney"];
    }
    if ([de objectForKey:@"userId"]) {
        [_jsondic setObject:[de objectForKey:@"userId"] forKey:@"userId"];
        [_jsondic setObject:[de objectForKey:@"sessionid"] forKey:@"sessionid"];
        if([de objectForKey:@"newUserId"]){
            [_jsondic setObject:[de objectForKey:@"newUserId"] forKey:@"newUserId"];
        
        }
    }
    
  
    [_jsondic setObject:@1 forKey:@"model"];
    [_jsondic setObject:VERSION forKey:@"ios_version"];
    [_jsondic setObject:[de objectForKey:@"placename"] forKey:@"area"]; 
    if (_secreeblock) {
        _secreeblock(_jsondic);
    }
    

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataarray.count) {
        NSArray *arr=_dataarray[section];
       
        return arr.count;
    }
    
    return 0;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  static NSString *headid=@"heard";
   ScreenCollectionReusableView *reusallble=[_colectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headid forIndexPath:indexPath];
    NSString *text=_toparr[indexPath.section];
    reusallble.titlelable.text=text;
    reusallble.titlelable.font=[UIFont systemFontOfSize:20*KIphoneWH];
    reusallble.titlelable.textColor=[UIColor blackColor];
    
    return reusallble;
  
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_toparr.count) {
        return _toparr.count;
    }

    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTH, 45*KIphoneWH);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(WIDTH/4, 30*KIphoneWH);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上左下右
   
 return UIEdgeInsetsMake(5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH, 5*KIphoneWH);

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    ScreenCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (_dataarray.count) {
         NSArray *arr=_dataarray[indexPath.section];
        if (indexPath.section==1) {
            if (arr.count) {
                CategoryModel *model=arr[indexPath.row];
                cell.titlelabla.text=model.name;
            }
            
        }else{
       
            cell.titlelabla.text=arr[indexPath.row];}
    }
    
    
    
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (_dataarray.count) {
        
      NSArray  *arr=_dataarray[indexPath.section];
        
    switch (indexPath.section) {
        case 0:{
            
            for (int i=0; i<arr.count; i++) {
                
                ScreenCollectionViewCell *cell=(ScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
                cell.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
            }
            ScreenCollectionViewCell *cell1=(ScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
           cell1.backgroundColor=[UIColor colorWithRed:125.0/255.0 green:189.0/255.0 blue:0.0/255.0 alpha:1];
            
            [_jsondic setObject:arr[indexPath.row] forKey:@"quarter"];
        
        
        }
            break;
            
        case 1:{
            if (arr.count) {
                for (int i=0; i<arr.count; i++) {
                   
                    ScreenCollectionViewCell *cell=(ScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]];
                    cell.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
                }
                ScreenCollectionViewCell *cell1=(ScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:1]];
                 cell1.backgroundColor=[UIColor colorWithRed:125.0/255.0 green:189.0/255.0 blue:0.0/255.0 alpha:1];

                
                
                
                CategoryModel *model=arr[indexPath.row];
              [_jsondic setObject:model.id forKey:@"appCategoryId"];
            }
        }
            break;
        case 2:{
            for (int i=0; i<arr.count; i++) {
               
                ScreenCollectionViewCell *cell=(ScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:2]];
                cell.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
            }
            ScreenCollectionViewCell *cell1=(ScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:2]];
            cell1.backgroundColor=[UIColor colorWithRed:125.0/255.0 green:189.0/255.0 blue:0.0/255.0 alpha:1];

            
            
            [_jsondic setObject:arr[indexPath.row] forKey:@"year"];
            break;}
        default:
            break;
    }

}

}
@end
