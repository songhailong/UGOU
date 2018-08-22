//
//  SelectColorView.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 2018/3/19.
//

#import "SelectColorView.h"
#import "Uikility.h"
#import "AttributeModel.h"
#import "UGColorCollectionViewCell.h"
@interface SelectColorView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end;
@implementation SelectColorView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
       //self.automaticallyAdjustsScrollViewInsets=YES;
        //self.automaticallyAdjustsScrollViewInsets = NO;
        self.backgroundColor=[UIColor redColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect fram=self.frame;
    
    
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
    _collectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowlayout];
    //[_collectionview add]
    _collectionview.contentInset=UIEdgeInsetsMake(0, 0, self.frame.size.width, self.frame.size.height);
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator=YES;
    //设置不能滑动
    _collectionview.scrollEnabled=NO;
    [_collectionview registerClass:[UGColorCollectionViewCell class] forCellWithReuseIdentifier:@"colorCell"];
    
    [self addSubview:_collectionview];
//    _collectionview.frame=self.frame;
//    NSLog(@"ndjcnj");
//    _collectionview.contentInset=UIEdgeInsetsMake(0, 0, fram.size.width, fram.size.height);
//
//    //_collectionview.backgroundColor=[UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
//    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
//    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowlayout.minimumInteritemSpacing=5*KIphoneWH;
////    if(IPHONEVERSION.floatValue>=10.0){
////
////        _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, WIDTH, HEIGHT-NavHeight) collectionViewLayout:flowlayout];
////
////    }else{
//    _collectionview.frame=self.frame;
//   // }
//
//    _collectionview.delegate=self;
//    _collectionview.dataSource=self;
//    _collectionview.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    //[self.view addSubview:_collectionview];
    //[_collectionview registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"qqq"];
    //[_collectionview registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //_collectionview.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //[appgoodsid removeAllObjects];
       //// hang=1;
       // [self json1];
       // [_collectionview.header endRefreshing];
   // }];
    
}
//-(NSMutableArray *)msGoodModels{
//    if (!_msGoodModels) {
//        _msGoodModels=[NSMutableArray array];
//    }
//    return _msGoodModels;
//}
-(void)setMsGoodModels:(NSArray *)msGoodModels{
    //NSLog(@"set方法");
    _msGoodModels= msGoodModels;
    [_collectionview reloadData];
}
//-(UICollectionView *)collectionview{
//    NSLog(@"JJBkjbbbckjbd初始化");
//    if (!_collectionview) {
//        
//        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
//        [flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        flowlayout.minimumInteritemSpacing=5*KIphoneWH;
//        _collectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowlayout];
//        //[_collectionview add]
//         _collectionview.contentInset=UIEdgeInsetsMake(0, 0, self.frame.size.width, self.frame.size.height);
//        _collectionview.delegate=self;
//        _collectionview.dataSource=self;
//        [_collectionview registerClass:[UGColorCollectionViewCell class] forCellWithReuseIdentifier:@"colorCell"];
//        NSLog(@"初始化");
//        [self addSubview:_collectionview];
//    }
//    return _collectionview;
//}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"---------数组个数%zd",_msGoodModels.count);
    if (_msGoodModels.count) {
        return _msGoodModels.count;
    }
    return 0;
}

//- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    UGColorCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
//    NSLog(@"数组个数%zd",_msGoodModels.count);
//    if (_msGoodModels.count) {
//        AttributeModel *model=[_msGoodModels objectAtIndex:indexPath.row];
//        if(_selectType==SelectObjctTypeColor){
//            NSLog(@"执行");
//         cell.textLable.text=model.color;
//        if (model.isOptional) {
//            cell.backgroundView.alpha=0.5;
//        }
//
//        }else if(_selectType==SelectObjctTypeSize){
//            cell.textLable.text=model.size;
//        }
//        if (model.isOptional) {
//            cell.backgroundView.alpha=0.5;
//        }
//    }
//
//
//    return cell;
//}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UGColorCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
        //NSLog(@"数组个数%zd",_msGoodModels.count);
        if (_msGoodModels.count) {
            AttributeModel *model=[_msGoodModels objectAtIndex:indexPath.row];
            cell.textLable.font=[UIFont systemFontOfSize:14*KIphoneWH];
            if (model.isSelect) {
                cell.backgroundColor=[UIColor colorWithRed:178.0/255.0 green:205.0/255.0 blue:126/255.0 alpha:1];
            }else{
                cell.backgroundColor= [UIColor colorWithRed:204/255.0 green:204/255.0 blue:205/255.0 alpha:1];
            }
            if(_selectType==SelectObjctTypeColor){
              
             cell.textLable.text=model.color;
            cell.textLable.textAlignment=NSTextAlignmentCenter;
                
            if (model.isOptional) {
                cell.maskView.alpha=0.8;
                cell.textLable.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:205/255.0 alpha:1];
            }else{
                cell.maskView.alpha=0;
                cell.textLable.textColor=[UIColor blackColor];
            }
                
    
            }else if(_selectType==SelectObjctTypeSize){
                cell.textLable.text=model.size;
                cell.textLable.textAlignment=NSTextAlignmentCenter;
                if (model.isOptional) {
                    //cell.textLable.textColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:205/255.0 alpha:1];
                    cell.maskView.alpha=0.8;
                }else{
                    
                    cell.maskView.alpha=0;
                }
            }
            
        }
    
    
        return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50*KIphoneWH, 40*KIphoneWH);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5*KIphoneWH, 0, 10*KIphoneWH);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AttributeModel *miodel=[_msGoodModels objectAtIndex:indexPath.row];
    if (!miodel.isOptional) {
//    for (int i=0; i<_msGoodModels.count; i++) {
//       AttributeModel *modele =[_msGoodModels  objectAtIndex:i];
//
////            model.isOptional=NO;
////            [_msGoodModels replaceObjectAtIndex:i withObject:model];
//
//        UGColorCollectionViewCell *cell=(UGColorCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        cell.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
//        //[_collectionview reloadData];
//    }
//    UGColorCollectionViewCell *cell1=(UGColorCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
//    cell1.backgroundColor=[UIColor colorWithRed:178.0/255.0 green:205.0/255.0 blue:126/255.0 alpha:1];
//    for (int i=0;i<_colorModelArr.count;i++) {
//        AttributeModel *model =[_colorModelArr objectAtIndex:i];
//        if (model.isOptional) {
//            model.isOptional=NO;
//            [_colorModelArr replaceObjectAtIndex:i withObject:model];
//        }
//    }
//
//    colorItem.msGoodModels=_colorModelArr;
    
         [self.delegate selectItemIndex:indexPath.row view:self];
    }
    
    
    
}
@end

