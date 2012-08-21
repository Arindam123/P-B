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
#import "MBProgressHUD.h"
#import "FacebookController.h"
#import "OAuthLoginView.h"
#import "Facebook.h"
#import <MessageUI/MessageUI.h>

@interface RealAle_Microsite :ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>
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
    NSMutableArray *OpenHourArray;
    NSMutableArray *OpenDayArray;
     NSMutableArray *bulletPointArray;
    NSString *aleID;
     MBProgressHUD *_hud;
    NSString *EventID;
  
    OAuthLoginView *oAuthObj;
    
    Facebook *facebook;
    
    NSMutableDictionary *dic;
   
    UIView *vw1;
     UIView *vw2;
    UIView *vw3;
     UIView *vw4;
     UIView *vw5;
     UIView *vw6;
     UIView *vw7;
     UIView *vw8;
     UIView *vw9;
     UIView *vw10;
     UIView *vw11;
     UIView *vw12;
     UIView *vw13;
     UIView *vw14;
    BOOL IsSelect;
    
    int section_value;
    
    BOOL IsFirstTime;
    NSString *share_eventName;
    NSString *BeerID;
   
    
}
@property(nonatomic,retain)NSString *BeerID;
@property(nonatomic,retain) NSString *share_eventName;
@property(nonatomic,retain)NSString *EventID;
@property (retain) MBProgressHUD *hud;
@property(nonatomic,retain) NSMutableDictionary *dic;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property(nonatomic,retain) NSString *aleID;
@property(nonatomic,retain) NSMutableArray *bulletPointArray;
@property(nonatomic,retain) NSMutableArray *OpenHourArray;
@property(nonatomic,retain) NSMutableArray *OpenDayArray;

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
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
