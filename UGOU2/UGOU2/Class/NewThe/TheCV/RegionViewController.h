//
//  RegionViewController.h
//  UgouAppios
//
//  Created by 靓萌服饰 on 16/8/8.
//  Copyright © 2016年 靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlaceselectDelegate<NSObject>
-(void)selectpalecereload:(NSNumber *)paleceid placename:(NSString *)placename;
@end
@interface RegionViewController : UIViewController
@property(nonatomic,assign)id<PlaceselectDelegate>placedelegate;
@end
