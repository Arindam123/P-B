//
//  PubDetailsSubCatagory.h
//  PubAndBar
//
//  Created by Apple on 21/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Toolbar.h"

@interface FoodDetails_Microsite : ButtonAction<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *backButton;
    UITableView *table;
    UILabel *datelbl;
    UILabel *lbl_heading;
    NSString *Name;
    NSMutableArray *Array_section;
    NSMutableArray *arrMain;
    NSMutableArray *arr_FoodDetails;
    NSMutableArray *arr;
    NSString *category_Str;
    NSString *Pubid;
    Toolbar *toolBar;
    
    BOOL IsInformation;
    BOOL IsServeTime;
    BOOL IsChefDesc;
    BOOL IsSpecialOffers;
    BOOL IsFood;
    


}
@property(nonatomic,assign)BOOL IsInformation;
@property(nonatomic,assign)BOOL IsServeTime;
@property(nonatomic,assign)BOOL IsChefDesc;
@property(nonatomic,assign)BOOL IsSpecialOffers;
@property(nonatomic,assign)BOOL IsFood;
@property(nonatomic,retain) NSString *Pubid;

@property(nonatomic,retain) NSString *category_Str;
@property(nonatomic,retain) NSMutableArray *Array_section;
@property(nonatomic,retain) NSMutableArray *arrMain;
@property(nonatomic,retain) NSMutableArray *arr;
@property(nonatomic,retain) NSMutableArray *arr_FoodDetails;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain) UILabel *lbl_heading; 
@property(nonatomic,retain) UILabel *datelbl;
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)UIButton *backButton;

-(void)setCatagoryViewFrame;
-(void)CreateView;
//-(void)PrepareArrayList:(int)Selection;

@end
