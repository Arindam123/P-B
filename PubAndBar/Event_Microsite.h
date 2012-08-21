//
//  Event_Microsite.h
//  PubAndBar
//
//  Created by Apple on 08/06/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Toolbar.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
//#import "iCodeOauthViewController.h"
#import "Facebook.h"
#import <MessageUI/MessageUI.h>



@interface Event_Microsite :ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>
{
    UIButton *backButton;
    UITableView *table;
    UILabel *datelbl;
    UILabel *lbl_heading;
    NSString *Name;
    NSString *category_Str;
    NSString *Pub_ID;
    NSString *event_type;  
    NSMutableArray *arrSubMain;
    NSMutableArray *arrMain;
    AppDelegate *delegate ;
    NSMutableDictionary *header_DictionaryData;
    Toolbar *toolBar;
    UIButton *btn_Venu;
    UIImageView *img_1stLbl;
     MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    BOOL IsSelect;
    int section_value;
    NSMutableDictionary *dic;
 
    NSMutableArray *OpenHourArray;
    NSMutableArray *OpenDayArray;
    NSMutableArray *bulletPointArray;
    UIView *vw1;
    UIView *vw2;
    NSString *_ID;
     NSString *EventDay;
    NSString *eventDesc;
      

}
@property(nonatomic,retain)NSString *eventDesc;
@property(nonatomic,retain)NSString *EventDay;
@property(nonatomic,retain)NSString *_ID;
@property(nonatomic,retain) NSMutableArray *bulletPointArray;
@property(nonatomic,retain) NSMutableArray *OpenHourArray;
@property(nonatomic,retain) NSMutableArray *OpenDayArray;
@property(nonatomic,retain) NSMutableDictionary *header_DictionaryData;
@property (retain) MBProgressHUD *hud;
@property(nonatomic,retain) NSMutableDictionary *dic;
@property(nonatomic,retain) NSString *event_type; 
@property(nonatomic,retain) NSString *Pub_ID;

@property(nonatomic,retain) NSString *category_Str;
@property(nonatomic,retain) NSMutableArray *arrSubMain;
@property(nonatomic,retain) NSMutableArray *arrMain;


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
