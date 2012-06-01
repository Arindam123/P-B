//
//  RealAle_Microsite.h
//  PubAndBar
//
//  Created by Apple on 22/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Toolbar.h"

@interface RealAle_Microsite :ButtonAction<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *backButton;
    UITableView *table;
    UILabel *datelbl;
    UILabel *lbl_heading;
    NSString *Name;
    NSString *category_Str;
    NSString *Pubid;
    NSMutableArray *arrRealAlyInfo;
    NSMutableArray *arrBeerInfo;
    
    NSMutableArray *arrSubMain;
    NSMutableArray *arrMain;
    NSMutableArray *arrMode;
     NSMutableDictionary *header_DictionaryData;
     Toolbar *toolBar;
     UIButton *btn_Venu;
    UIImageView *img_1stLbl;

    
}
@property(nonatomic,retain)UIImageView *img_1stLbl;
@property(nonatomic,retain)UIButton *btn_Venu;
@property(nonatomic,retain) NSMutableDictionary *header_DictionaryData;
@property(nonatomic,retain) NSMutableArray *arrMode;
@property(nonatomic,retain) NSMutableArray *arrBeerInfo;
@property(nonatomic,retain) NSMutableArray *arrRealAlyInfo;
@property(nonatomic,retain) NSMutableArray *arrSubMain;
@property(nonatomic,retain) NSMutableArray *arrMain;
@property(nonatomic,retain) NSString *Pubid;
@property(nonatomic,retain) NSString *category_Str;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain) UILabel *lbl_heading; 
@property(nonatomic,retain) UILabel *datelbl;
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)UIButton *backButton;

-(void)setCatagoryViewFrame;
-(void)CreateView;
-(void)PrepareArrayList:(int)Selection:(BOOL)Mode;

@end
