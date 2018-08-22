//
//  RetureCollectionViewCell.m
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/7/22.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import "RetureCollectionViewCell.h"

@implementation RetureCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
       
        [self creatUI];
    }


    return self;

}

-(void)creatUI{
    _rimageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    
    [self.contentView addSubview:_rimageview];

}

@end
