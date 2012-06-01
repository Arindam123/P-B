//
//  PubDetail.h
//  PubAndBar
//
//  Created by User7 on 03/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Toolbar.h"
#import "AsyncImageView.h"



@interface PubDetail : ButtonAction<UITableViewDelegate,UITableViewDataSource>{
   
    UIButton *backButton;
    //UITableView *table;
    NSMutableArray *Array;
    NSMutableArray *arrSubMain;
    UIView *heardervw;
    AsyncImageView *image;
    UILabel *name_lbl;
    UILabel *address_lbl;
    UIImageView *favorite;
    UILabel *fablbl;
    UILabel *managerlbl;
    UILabel *emaillbl;
    UIImageView *manager;
    UIImageView *email;
    UIButton *show_map;
    UITableView *my_table;
    NSMutableArray *arrMain;
    NSMutableArray *arr;
    NSMutableArray *Array_section;
    NSString *Pub_ID;
    NSString *sporeid;
    NSString *Sport_Evnt_id;
    NSString *EventId;
    NSString *categoryStr;
    Toolbar *toolBar;
    NSMutableDictionary *headerDictionaryData;
    NSString *imageURL;


}
@property(nonatomic,retain) NSString *categoryStr;
@property(nonatomic,retain) NSString *EventId;
@property(nonatomic,retain) NSString *Sport_Evnt_id;
@property(nonatomic,retain) NSString *sporeid;
@property(nonatomic,retain) NSString *Pub_ID; 
@property(nonatomic,retain)NSMutableArray *Array_section;
@property(nonatomic,retain) NSMutableArray *arr;
@property(nonatomic,retain)NSMutableArray *arrMain;
@property(nonatomic,retain) UITableView *my_table;
//@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)NSMutableArray *Array;
@property(nonatomic,retain) NSMutableArray *arrSubMain;
@property(nonatomic,retain)UIView *heardervw;
@property(nonatomic,retain) AsyncImageView *image;
@property(nonatomic,retain) UILabel *name_lbl;
@property(nonatomic,retain) UILabel *address_lbl;
@property(nonatomic,retain) UIImageView *favorite;
@property(nonatomic,retain) UIImageView *manager;
@property(nonatomic,retain) UIImageView *email;
@property(nonatomic,retain) UIButton *show_map;
@property(nonatomic,retain)UILabel *fablbl;
@property(nonatomic,retain)UILabel *managerlbl;
@property(nonatomic,retain)UILabel *emaillbl;
@property(nonatomic,retain) NSMutableDictionary *headerDictionaryData;




-(void)CreateView;
-(void)setViewFrame;
-(void)PrepareArrayList:(int)Selection;
@end
