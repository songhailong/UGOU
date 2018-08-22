//
//  RetureView.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/22.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "RetureView.h"
#import "RetureCollectionViewCell.h"
#import "Uikility.h"
@implementation RetureView {

    UICollectionView *_collectionview;
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }

    return self;

}
-(void)creatUI{
    
    _collectionview=[[UICollectionView alloc] initWithFrame:self.bounds];
    //self.automaticallyAdjustsScrollViewInsets=YES;
    
    _collectionview.contentInset=UIEdgeInsetsMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    //_collectionview.backgroundColor=[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc]initWithFrame:self.bounds   collectionViewLayout:flowlayout];
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    //_collectionview.backgroundColor=[UIColor whiteColor];
    
    _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [_collectionview registerClass:[RetureCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];


    [self  addSubview:_collectionview];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_array.count<5){
    
    
        return _array.count+1;
    
    }else{
    
        return _array.count;
    
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
    if (_array.count) {
        if (_array.count<5) {
            if (_array.count==indexPath.row) {
                UIImage *image=[UIImage imageNamed:@"添加图片"];
                cell.rimageview.image=image;
            }else{
                NSData *data=_array[indexPath.row];
                UIImage *image=[UIImage imageWithData:data];
                cell.rimageview.image=image;
            }
            
            
            
        }else{
        
            
            NSData *data=_array[indexPath.row];
            UIImage *image=[UIImage imageWithData:data];
            cell.rimageview.image=image;
        
        }
        
        
        
        
        
        
    
   
        
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_returnblock) {
        
        
        if (_array.count) {
            if (_array.count<5) {
                if (_array.count==indexPath.row) {
                    //1为添加  2为删除
                    _returnblock(1,indexPath.row);
                   
                }else{
                    
                    _returnblock(2,indexPath.row);
                    
                }
                
                
                
            }else{
                
             _returnblock(2,indexPath.row);
           
                
            }
            
        }
        
        
        
    }
    

}
-(void)reloacollectionview{

    [_collectionview reloadData];

}
@end
