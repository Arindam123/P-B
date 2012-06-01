//
//  PubList.h
//  PubAndBar
//
//  Created by User7 on 02/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>
#import "SavePubListInfo.h"
#import "NearByMap.h"


@interface NearMeNow : ButtonAction<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *table_list;
    NSString *categoryStr;
    NSString *PubId;
    UISegmentedControl *seg_control;
    NSMutableArray *PubArray;
    NearByMap *obj_nearbymap;
    UIButton *venu_btn;
    
}
@property(nonatomic,retain)UITableView *table_list;
@property(nonatomic,retain) NSString *PubId;
@property(nonatomic,retain)UISegmentedControl *seg_control;
@property(nonatomic,retain) NSMutableArray *PubArray;
@property(nonatomic,retain) UIButton *venu_btn;

-(void)CreateHomeView;
-(void)setHomeViewFrame;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryStr:(NSString *) categoryString;

-(IBAction)ClickSegCntrl:(id)sender;
@end
