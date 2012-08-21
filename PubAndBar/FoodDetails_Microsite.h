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

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import <MessageUI/MessageUI.h>



@interface FoodDetails_Microsite : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>
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
    NSMutableDictionary *dic;
     MBProgressHUD *_hud;
    BOOL IsInformation;
    BOOL IsServeTime;
    BOOL IsChefDesc;
    BOOL IsSpecialOffers;
    BOOL IsFood;
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *delegate ;
    BOOL IsSelect;
    int section_value;
    UIButton *btn_Venu;
    UIImageView *img_1stLbl;
    NSMutableDictionary *header_DictionaryData;
    NSMutableArray *OpenHourArray;
    NSMutableArray *OpenDayArray;
    NSMutableArray *bulletPointArray;
    NSString *FoodID;

}
@property(nonatomic,retain)NSString *FoodID;
@property(nonatomic,retain) NSMutableArray *bulletPointArray;
@property(nonatomic,retain) NSMutableArray *OpenHourArray;
@property(nonatomic,retain) NSMutableArray *OpenDayArray;
@property(nonatomic,retain) NSMutableDictionary *header_DictionaryData;
@property(nonatomic,retain)UIImageView *img_1stLbl;
@property(nonatomic,retain)UIButton *btn_Venu;
@property (retain) MBProgressHUD *hud;
@property(nonatomic,retain) NSMutableDictionary *dic;
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

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;


-(void)setCatagoryViewFrame;
-(void)CreateView;
//-(void)PrepareArrayList:(int)Selection;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
