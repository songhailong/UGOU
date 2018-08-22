//
//  DiscountCalculation.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 16/11/16.
//
//

#import "DiscountCalculation.h"
#import "Uikility.h"
#import "CartModel.h"
#import "DiscountModel.h"
@implementation DiscountCalculation


+(id)fullDiscountCalculationOrderData:(NSMutableArray *)modelArr VipData:(NSMutableArray *)VipArr OrderDiscountDic:(NSDictionary *)OrderDiscountDic VIPDiscountDic:(NSDictionary *)VIPDiscountDic pageFlag:(NSInteger)flag{
    NSMutableArray *discountIdarr=[[NSMutableArray alloc] init];
   
    // 满几件折扣
    //数组按品牌分类
    
    
        //遍历按品牌分类后的数组
        for (int i=0; i<modelArr.count; i++) {
            NSArray *arr=modelArr[i];
            CartModel *thmodel=arr[0];
            
            NSString *idstr=[NSString stringWithFormat:@"%@",thmodel.brandid];
            NSArray *discountarr=[OrderDiscountDic objectForKey:idstr];
            
            if (discountarr.count>0) {
                NSMutableArray *disarr=[[NSMutableArray alloc] init];
                for (NSDictionary * dic in discountarr) {
                    DiscountModel *dismodel=[DiscountModel initWithdictomodel:dic];
                    dismodel.brandId=[[dic objectForKey:@"appbrandId"] objectForKey:@"id"];
                    dismodel.vipFlag=NO;
                    [disarr addObject:dismodel];
                    // [disarr addObject:[DiscountModel initWithdictomodel:dic]];
                }
                //满件折扣 从小大大排列
                NSArray *distwoarr=[Uikility mintomaxarr:disarr];
                NSInteger sss=1000;
                NSInteger count=0;
                for (CartModel *cartmodel  in arr ) {
                    count=count+cartmodel.quantity;
                }
                
                
                
                for (int h=0; h<distwoarr.count; h++) {
                    DiscountModel *dismodel=distwoarr[h];
                    if (count>=dismodel.count.intValue) {
                        sss=h;
                                           }
                }
                    if (sss<999) {
                                    //拿到要折扣的模型
                    DiscountModel  *disendmodel=distwoarr[sss];
                                   
                    [discountIdarr addObject:disendmodel];
                }
            }
        }
        
        for (int i=0; i<VipArr.count; i++) {
            NSArray *arr=VipArr[i];
            CartModel *thmodel=arr[0];
            
            NSString *idstr=[NSString stringWithFormat:@"%zd",thmodel.brandid.integerValue];
            
            NSArray *discountarr=[VIPDiscountDic objectForKey:idstr];
            
        if (discountarr.count>0) {
                NSMutableArray *disarr=[[NSMutableArray alloc] init];
                for (NSDictionary * dic in discountarr) {
                    DiscountModel *dismodel=[DiscountModel initWithdictomodel:dic];
                    dismodel.brandId=[[dic objectForKey:@"appbrandId"] objectForKey:@"id"];
                    dismodel.vipFlag=YES;
                    [disarr addObject:dismodel];
                    // [disarr addObject:[DiscountModel initWithdictomodel:dic]];
                }
                //满件折扣 从小大大排列
                NSArray *distwoarr=[Uikility mintomaxarr:disarr];
                NSInteger sss=1000;
            //总有多少件
                 NSInteger count=0;
            for (CartModel *cartmodel  in arr ) {
                count=count+cartmodel.quantity;
            }
            

                for (int h=0; h<distwoarr.count; h++) {
                    DiscountModel *dismodel=distwoarr[h];
                    if (count>=dismodel.count.intValue) {
                        sss=h;
                        
                    }
                }
                if (sss<999) {
                    //拿到要折扣的模型
                    DiscountModel  *disendmodel=distwoarr[sss];
                    
                    [discountIdarr addObject:disendmodel];
                }
            }
        }

        
        
        
        
    
    
    return discountIdarr;



}
+(id)fullCountZheKouOrderArray:(NSMutableArray *)oredrerArr VipArr:(NSMutableArray *)VipArr orderZhekouDic:(NSDictionary *)orderZheKouDic vipZheKouDic:(NSDictionary *)vipZheKouDic money:(NSArray *)money{
   
    
    NSMutableArray *zhekouIdarr=[[NSMutableArray alloc] init];
    
    CGFloat  ZKPrice=0;
    //普通用户折扣
    for (NSArray *orderGoods in oredrerArr) {
        CartModel *carModel=orderGoods[0];
        NSString *idstr=[NSString stringWithFormat:@"%@",carModel.brandid];
        NSArray *discountarr=[orderZheKouDic objectForKey:idstr];
        if(discountarr.count>0){
            NSMutableArray *disarr=[[NSMutableArray alloc] init];
            for (NSDictionary * dic in discountarr) {
                DiscountModel *dismodel=[DiscountModel initWithdictomodel:dic];
                dismodel.brandId=[[dic objectForKey:@"appbrandId"] objectForKey:@"id"];
                dismodel.vipFlag=NO;
                [disarr addObject:dismodel];
            }
            NSArray *distwoarr=[Uikility mintomaxarr:disarr];
            NSInteger sss=1000;
            //商品个数
            NSInteger count=0;
            
            for (CartModel *cartmodel  in orderGoods ) {
                count=count+cartmodel.quantity;
            }
            

            for (int h=0; h<distwoarr.count; h++) {
                DiscountModel *dismodel=distwoarr[h];
                if (count>=dismodel.count.intValue) {
                    sss=h;
                }
            }
   
            if (sss<999) {
               DiscountModel  *disendmodel=distwoarr[sss];
                //每个多少钱
                [zhekouIdarr addObject:disendmodel];
                CGFloat baranAll=[Uikility calculateAllPriceGoods:orderGoods];
               
                for (DiscountModel * disModel in money) {
                    //该品牌是否有满减
                    
                    if ([disendmodel.brandId isEqualToNumber:disModel.brandId]) {
                        if (disModel.vipFlag==NO) {
                            //该品牌先满件在打折
                            baranAll=baranAll-disModel.money.integerValue;
                        }
                     }
                }
                
            ZKPrice =ZKPrice+baranAll*(10-disendmodel.discount.floatValue)*0.1;
            
            
            }
//

        }
    }
    
    //vip用户折扣
    
    for (NSArray *VipGoods in VipArr) {
        CartModel *carModel=VipGoods[0];
        NSString *idstr=[NSString stringWithFormat:@"%@",carModel.brandid];
        NSArray *discountarr=[vipZheKouDic objectForKey:idstr];
        if(discountarr.count>0){
            NSMutableArray *vipdisarr=[[NSMutableArray alloc] init];
            for (NSDictionary * dic in discountarr) {
                DiscountModel *dismodel=[DiscountModel initWithdictomodel:dic];
                dismodel.brandId=[[dic objectForKey:@"appbrandId"] objectForKey:@"id"];
                dismodel.vipFlag=NO;
                [vipdisarr addObject:dismodel];
            }
            NSArray *distwoarr=[Uikility mintomaxarr:vipdisarr];
            NSInteger sss=1000;
            NSInteger count=0;
            
            for (CartModel *cartmodel  in VipGoods ) {
                count=count+cartmodel.quantity;
            }

            for (int h=0; h<distwoarr.count; h++) {
                DiscountModel *dismodel=distwoarr[h];
                if (count>=dismodel.count.intValue) {
                    sss=h;
                }
            }
            
            if (sss<999) {
                DiscountModel  *disendmodel=distwoarr[sss];
                CGFloat baranAll=[Uikility calculateAllPriceGoods:VipGoods];
                [zhekouIdarr addObject:disendmodel];
                
                
                for (DiscountModel * disModel in money) {
                    //该品牌是否有满减
                    
                    if ([disendmodel.brandId isEqualToNumber:disModel.brandId]) {
                        if (disModel.vipFlag==YES) {
                            //该品牌先满件在打折
                            baranAll=baranAll-disModel.money.integerValue;
                        }
                    }
                }
                
                ZKPrice =ZKPrice+baranAll*(10-disendmodel.discount.floatValue)*0.1;
                
                
                
                
            }
            //
            
        }
    }
    NSString *price=[NSString stringWithFormat:@"%f",ZKPrice];
    
    ZheKouModel *zhekouModel=[[ZheKouModel alloc] init];
    zhekouModel.ZKPrice=price;
    zhekouModel.ZKDisCounts=zhekouIdarr;
    
    
    return zhekouModel;
}
@end
