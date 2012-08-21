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


#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
//#import "iCodeOauthViewController.h"
#import "Facebook.h"
#import <MessageUI/MessageUI.h>
#import "AsyncImageView_New.h"


@interface PubDetail : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>{
   
    UIButton *backButton;
    //UITableView *table;
    NSMutableArray *Array;
    NSMutableArray *arrSubMain;
    UIView *heardervw;
    AsyncImageView_New *image;
    UILabel *name_lbl;
    UILabel *address_lbl;
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
    NSMutableArray *OpenHourArray;
    NSMutableArray *OpenDayArray;
    NSMutableArray *bulletPointArray;
    NSMutableArray *arr_Event_name;
    NSString *event_type;
    NSString *_ID;
    NSArray *arrSection;
   
    UIButton *fabBtn;
    UIButton *managerBtn;
    UIButton *emailBtn;
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    MBProgressHUD *_hud;
    
    UILabel *topLabel;
    UIImageView *iconImg;
    UILabel *lbl_heading;
    BOOL isGeneralExpanded;
    BOOL isPubOpeningHrsExpanded;
    BOOL isPubBulletsExpanded;
    BOOL isDescriptionExpanded;
    BOOL isregularEvent;
    BOOL isoneoffEvent;
    BOOL isthemenightEvent;
    BOOL issportsEvent;
    //BOOL issportsEvent;
    BOOL isImagesExpanded;
    BOOL isOtherDetails;
    BOOL isSportsDetails;
    BOOL isOpeningHr;
    BOOL isFoodDetail;
    
    BOOL isRegularEventExit;
    BOOL isGeneralExpandedExit;
    BOOL isPubOpeningHrsExpandedexit;
    BOOL isOtherDetailsExit;
    BOOL isPubBulletsExpandedExit;
    BOOL isDescriptionExpandedExit;
    BOOL isOneOffEventexit;
    BOOL isThemeNightExit;
    
    BOOL isSportsDetailsExit;
    BOOL issportsEventExit;
    BOOL isImagesExpandedExit;
    
    BOOL IsSelect;
    int section_value;
    NSString *current_date;
    
    NSString *str_mail;
    NSString *str_mobile;
    NSMutableDictionary *sportEventDic;
     NSString *Share_EventName;
    NSString *Day;
    UIButton *btn_map;
    NSString *latitude;
    NSString *longitude;
    NSString *BeerID;
    
    NSMutableArray *generalSectionArray;
    
    NSMutableArray *array;

}
@property(nonatomic,retain) NSString *BeerID;
@property(nonatomic,retain)NSString *Day;
@property(nonatomic,retain) NSString *Share_EventName;
@property(nonatomic,retain)NSMutableArray *arr_Event_name;
@property(nonatomic,retain)NSString *current_date;
@property(nonatomic,retain)UILabel *lbl_heading;
@property(nonatomic,retain) NSMutableDictionary *sportEventDic;
@property(nonatomic,retain) NSString *_ID;
@property(nonatomic,retain)NSString *event_type; 
@property(nonatomic,retain) NSMutableArray *bulletPointArray;
@property(nonatomic,retain) NSMutableArray *OpenHourArray;
@property(nonatomic,retain) NSMutableArray *OpenDayArray;

@property(nonatomic,retain) NSString *categoryStr;
@property(nonatomic,retain) NSString *EventId;
@property(nonatomic,retain) NSString *Sport_Evnt_id;
@property(nonatomic,retain) NSString *sporeid;
@property(nonatomic,retain) NSString *Pub_ID; 
@property(nonatomic,retain)NSMutableArray *Array_section;
@property(nonatomic,retain) NSMutableArray *arr;
@property(nonatomic,retain)NSMutableArray *arrMain;
@property(nonatomic,retain) UITableView *my_table;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)NSMutableArray *Array;
@property(nonatomic,retain) NSMutableArray *arrSubMain;
@property(nonatomic,retain)UIView *heardervw;
@property(nonatomic,retain) AsyncImageView_New *image;
@property(nonatomic,retain) UILabel *name_lbl;
@property(nonatomic,retain) UILabel *address_lbl;
@property(nonatomic,retain) UIButton *show_map;
@property(nonatomic,retain) NSMutableDictionary *headerDictionaryData;

@property(nonatomic,retain) UIButton *fabBtn;
@property(nonatomic,retain) UIButton *managerBtn;
@property(nonatomic,retain)UIButton *emailBtn;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@property (nonatomic, retain) NSString *imageURL;


-(void)CreateView;
-(void)setViewFrame;
-(void)PrepareArrayList:(int)Selection;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)displayEmailComposerSheetMailToPub;
-(void)wallPosting;
@end
