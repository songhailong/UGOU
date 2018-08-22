//
//  VipOrCartTableViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰靓萌服饰 on 16/10/28.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "VipOrCartTableViewCell.h"
#import "CartTableViewCell.h"
#import "CartModel.h"
#import "Uikility.h"
#import "UIImageView+WebCache.h"
#import "Uikility.h"

@implementation VipOrCartTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self creatUI];
    }

    return self;

}
-(void)creatUI{
    
    
    
    
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1160) style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.bounces=NO;
    [_tableview registerClass:[CartTableViewCell class] forCellReuseIdentifier:@"newcell"];
    if (_tableview.editing==NO) {
        _tableview.editing=YES;
    }
    _tableview.allowsMultipleSelectionDuringEditing=YES;
    [self.contentView addSubview:_tableview];
    


}
-(void)reloadtabview:(NSArray *)array isEidingAll:(BOOL)isEidingAll{
    _dataarray=array;
    //_tableview.frame=CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
   
   CGFloat tableH=[Uikility calculateCellHeight:array];
    
    
    if (isEidingAll) {
        _tableview.editing=NO;
        _tableview.allowsSelectionDuringEditing=NO;
    }else{
       _tableview.editing=YES;
        
        _tableview.allowsSelectionDuringEditing=YES;
    
    }
    
   
    _tableview.allowsMultipleSelectionDuringEditing=YES;
    _tableview.frame=CGRectMake(0, 0, WIDTH, tableH+1);
   
    
    [_tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_dataarray.count){
       return _dataarray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr=[_dataarray objectAtIndex:section];
    if(arr.count){
    
        return arr.count;
    }
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100*KIphoneWH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartTableViewCell  * cell=[tableView dequeueReusableCellWithIdentifier:@"newcell" forIndexPath:indexPath];
    
    if (_dataarray.count) {
        
        NSArray * array=[_dataarray objectAtIndex:indexPath.section];
        
        
        CartModel *model=[array objectAtIndex:indexPath.row];
        
        [cell.imview  sd_setImageWithURL:[Uikility URLWithString:model.logopicUrl]placeholderImage:[UIImage imageNamed:@"uuu"]];
       cell.imlabel.text=model.goodsName;
        cell.qtlabel.text=model.attribute;
        if(model.editing==YES){
            
            [_tableview selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
        void (^cellblock)(NSString *strid)=^(NSString *strid){
        
         [self.delegate removecellindex:model.cardgoodid indexPath:indexPath cellTag:_celltag];
        
        };
        
        
        cell.block=cellblock;
        
        
        if(model.vipFlag){
            CGFloat vipprice=model.vipPrice.floatValue;
            cell.jglabel.text=[NSString stringWithFormat:@"%.1f",vipprice];
            CGFloat s1=model.goodsPrice.floatValue;
            if (s1>vipprice) {
                
                cell.lplabel.text=[NSString stringWithFormat:@"%.1f",s1];
                cell.lplabel.alpha=1;
                
            }

        
        }else{
            CGFloat s1=model.goodsPrice.floatValue;
            CGFloat price=model.promotionPrice.floatValue;
           cell.jglabel.text=[NSString stringWithFormat:@"%.1f",price];
            if (s1>price) {
              cell.lplabel.text=[NSString stringWithFormat:@"%.1f",s1];
                cell.lplabel.alpha=1;
                
            }

        }
        NSInteger g=model.quantity;
        
        if (g) {
        }else{
            g=1;
        }
        cell.gslabel.text=[NSString stringWithFormat:@"x%zd",g];
    }else{
        
        
    }

    

    return cell;

}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_dataarray.count==0) {
        return nil;
    }else{
        NSArray *array=[_dataarray objectAtIndex:section];
        if (array.count) {
            
            UIView *    headview1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50*KIphoneWH)];
            headview1.backgroundColor=[UIColor whiteColor];
            UIButton * b1=[[UIButton alloc]init];
            b1.frame=CGRectMake(2*KIphoneWH, 12*KIphoneWH, 25*KIphoneWH, 25*KIphoneWH);
            b1.tag=section;
            [b1 setImage:[UIImage imageNamed:@"选择圆圈-选中"] forState:UIControlStateSelected];
            [b1 setImage:[UIImage imageNamed:@"选择圆圈-未选中"] forState:UIControlStateNormal];
            [headview1 addSubview:b1];
            [b1 addTarget:self action:@selector(pushsection:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            CartModel *model=[array objectAtIndex:0];
           NSURL*im=[Uikility URLWithString:model.logopic];
            UIImageView *imv1=[[UIImageView alloc]initWithFrame:CGRectMake(30*KIphoneWH, 10*KIphoneWH, 30*KIphoneWH, 30*KIphoneWH)];
            [imv1 sd_setImageWithURL:im placeholderImage:[UIImage imageNamed:@"uuu"]];
            [headview1 addSubview:imv1];
            UILabel *b=[[UILabel alloc]initWithFrame:CGRectMake(60*KIphoneWH, 5*KIphoneWH, 80*KIphoneWH, 40*KIphoneWH)];
            b.font=[UIFont systemFontOfSize:16*KIphoneWH];
            b.tag=section;
            [headview1 addSubview:b];
            b.text=[NSString stringWithFormat:@"%@>",model.brandName];
            NSString *brandstr=[NSString stringWithFormat:@"%@",model.brandid];
            NSArray *arr=[_discountDic objectForKey:brandstr];
            if (arr) {
                
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(140*KIphoneWH, 5*KIphoneWH, WIDTH-210*KIphoneWH, 40*KIphoneWH)];
                [headview1 addSubview:lable];
                NSMutableString *labletext=[[NSMutableString alloc] init];
                for (NSDictionary *discount in arr) {
                    NSNumber *countnm=[discount objectForKey:@"count"];
                    NSNumber *moneynm=[discount objectForKey:@"money"];
                    NSInteger inte=moneynm.integerValue;
                    NSString *str=[NSString stringWithFormat:@" 满%@件减%zd",countnm,inte];
                    [labletext appendString:str];
                    
                }
                lable.text=labletext;
                lable.textColor=[UIColor colorWithRed:230/255.0 green:98/255.0 blue:130/255.0 alpha:1];
                lable.font=[UIFont systemFontOfSize:15*KIphoneWH];
                
            }else{
                
                
                
            }

            
            
            
            UIImageView *ims=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-70*KIphoneWH, 0, 2*KIphoneWH, 50*KIphoneWH )];
            [headview1 addSubview:ims];
            
            
            
            
            
            
    
            ims.image=[UIImage imageNamed:@"编辑旁竖线"];
            
            UIButton *  leftbut1=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-70*KIphoneWH, 5*KIphoneWH, 60*KIphoneWH, 40*KIphoneWH)];
            [leftbut1 setTitle:@"编辑" forState:UIControlStateNormal];
            [leftbut1 setTitleColor:[UIColor colorWithRed:143/255.0 green:195/255.0 blue:31/255.0 alpha:1]forState:UIControlStateNormal];
            leftbut1.tag=section;
            void(^artBlock)(NSString *text)=^(NSString *text){
                [leftbut1 setTitle:text forState:UIControlStateNormal];
                if ([text isEqualToString:@"完成"]) {
                    leftbut1.selected=YES;
                }else{
                    leftbut1.selected=NO;
                    
                }
            };
            _block=artBlock;
            [leftbut1 addTarget:self action:@selector(butpushtop:) forControlEvents:UIControlEventTouchUpInside];
            [headview1 addSubview:leftbut1];
            return headview1;
        }else{
            return nil;
        }
    }



}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*KIphoneWH;

}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array=  _dataarray[indexPath.section];
    CartModel *model=array[indexPath.row];
   
    [self.delegate removecellindex:model.cardgoodid indexPath:indexPath cellTag:_celltag];
    
    
   
}
#pragma mark 组 头视图按钮监听方法
-(void)pushsection:(UIButton *)b{
    if (b.selected==NO) {
        if (_dataarray.count) {
            NSArray *array=_dataarray[b.tag];
            for (int i=0; i<array.count; i++) {
                NSIndexPath *indexpath=[NSIndexPath indexPathForItem:i inSection:b.tag];
                [_tableview selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionTop];
            }
            
            
            
            [self.delegate heardViewSelectSection:b.tag cellTag:_celltag IsSelect:YES];
            
            b.selected=YES;
        }else{
            b.selected=YES;
            return;
        }
    }else{
        if (_dataarray.count) {
            NSArray *array=_dataarray[b.tag];
            for (int i=0; i<array.count; i++) {
                NSIndexPath *indexpath=[NSIndexPath indexPathForItem:i inSection:b.tag];
                [_tableview deselectRowAtIndexPath:indexpath animated:YES];
            }
            [self.delegate heardViewSelectSection:b.tag cellTag:_celltag IsSelect:NO];
            b.selected=NO;
        }else{
            b.selected=NO;
            return ;
        }
    }

    

    

}
#pragma mark-----点击编辑
-(void)butpushtop:(UIButton *)btn{
//  
//    if (btn.selected==NO) {
//        _tableview.allowsMultipleSelectionDuringEditing=NO;
//        _tableview.editing=NO;
//        [btn setTitle:@"完成" forState:UIControlStateNormal];
//        btn.selected=YES;
//        //[_tableview reloadData];
//    }else{
//        _tableview.allowsMultipleSelectionDuringEditing=YES;
//        _tableview.editing=YES;
//        [btn setTitle:@"编辑" forState:UIControlStateNormal];
//        [_tableview reloadData];
//        btn.selected=NO;
//    }


}
#pragma mark---点中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * selectedRows=[_tableview indexPathsForSelectedRows];
    NSArray *sortarray=[selectedRows sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *selectgoos=[[NSMutableArray alloc] init];
    for (NSInteger i =0;i<sortarray.count;i++) {
        NSIndexPath *indexpaths=sortarray[i];
        if (_dataarray.count) {
            NSArray *marry=_dataarray[indexpaths.section];
            CartModel*model=marry[indexpaths.row];
            [selectgoos addObject:model];
        }
    }
    

 
[self.delegate selectCellindexarr:selectgoos indexPath:indexPath cellTag:_celltag IsSelect:NO];
 


}
#pragma mark-----编辑模式下cell取消的代理
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * selectedRows=[_tableview indexPathsForSelectedRows];
    NSArray *sortarray=[selectedRows sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *selectgoos=[[NSMutableArray alloc] init];
    for (NSInteger i =0;i<sortarray.count;i++) {
        NSIndexPath *indexpaths=sortarray[i];
        if (_dataarray.count) {
            NSArray *marry=_dataarray[indexpaths.section];
            CartModel*model=marry[indexpaths.row];
            [selectgoos addObject:model];
        }
    }

    [self.delegate selectCellindexarr:selectgoos indexPath:indexPath cellTag:_celltag IsSelect:NO];


}
+(void)IseditorAll:(BOOL)IseditorAll{
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
