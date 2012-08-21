//
//  Sport_Microsite.h
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
#import "Facebook.h"
#import <MessageUI/MessageUI.h>



@interface Sport_Microsite :ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>
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
    NSString *sport_ID;
    
    NSMutableArray *OpenHourArray;
    NSMutableArray *OpenDayArray;
    NSMutableArray *bulletPointArray;
    UIView *vw1;
    UIView *vw2;
    NSString *Sport_Evnt_id;
    NSString *sporeid;
    NSMutableDictionary *sportEventDic;
    
    
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

    
}
@property(nonatomic,retain)NSString *sport_ID;

@property(nonatomic,retain)NSMutableDictionary *sportEventDic;
@property(nonatomic,retain) NSString *Sport_Evnt_id;
@property(nonatomic,retain) NSString *sporeid;
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
