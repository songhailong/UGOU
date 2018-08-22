//
//  SaoTableView.m
//  UGouApp
//
//  Created by 靓萌服饰靓萌服饰 on 17/1/11.
//
//

#import "SaoTableView.h"
#import "Uikility.h"
#define selfWITH self.bounds.size.width
#define selfHEIGT self.bounds.size.height
@implementation SaoTableView

-(instancetype)initWithFrame:(CGRect)frame{
  self=  [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    
    }
    

    return self;
}

-(void)creatUI{

    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    [self addSubview:imageview];
    UIButton *but1=[[UIButton alloc] initWithFrame:CGRectMake(0, 5*KIphoneWH, self.bounds.size.width, (self.bounds.size.height-5*KIphoneWH))];
     but1.tag=0;
    [but1 setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *but2=[[UIButton alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height-5*KIphoneWH)/2+5*KIphoneWH,self.bounds.size.width , (self.bounds.size.height-5*KIphoneWH)/2)];
    but2.tag=1;
    
    [but2 setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:but1];
    //[self addSubview:but2];
    
    [but1 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [but2 addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *searchimageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KIphoneWH, 10*KIphoneWH, selfWITH/4-5*KIphoneWH, selfHEIGT-20*KIphoneWH)];
    searchimageview.image=[UIImage imageNamed:@"Newsearch_root"];
   
    [but1 addSubview:searchimageview];
    UIImageView *saoiamgeview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KIphoneWH, 10*KIphoneWH, selfWITH/4-10*KIphoneWH, selfHEIGT/2-25*KIphoneWH)];
    
    saoiamgeview.image=[UIImage imageNamed:@"home_qrcode"];
    
     [but2  addSubview:saoiamgeview];
    
    UILabel *searchlable=[[UILabel alloc] initWithFrame:CGRectMake(selfWITH/4+10*KIphoneWH, 10*KIphoneWH, selfWITH/4*3-10*KIphoneWH, (selfHEIGT-10*KIphoneWH)-10*KIphoneWH)];
    UILabel *saolable=[[UILabel alloc] initWithFrame:CGRectMake(selfWITH/4+10*KIphoneWH, 5*KIphoneWH, selfWITH/4*3-10*KIphoneWH, (selfHEIGT-10*KIphoneWH)/2-10*KIphoneWH)];
    searchlable.text=@"搜索";
    saolable.text=@"扫一扫";
    searchlable.textAlignment=NSTextAlignmentLeft;
    saolable.textAlignment=NSTextAlignmentLeft;
    
    searchlable.textColor=[UIColor blackColor];
    searchlable.textColor=[UIColor blackColor];
        [but1 addSubview:searchlable];
    [but2 addSubview:saolable];
    
}

-(void)buttonclick:(UIButton *)bt{
    
    
   
    if (_saosblock) {
        _saosblock(bt.tag);
    }


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
