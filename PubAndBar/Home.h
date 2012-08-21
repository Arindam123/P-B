//
//  Home.h
//  PubAndBar
//
//  Created by Alok K Goyal on 06/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Constant.h"
#import "DistenceWheel.h"
#import "AppDelegate.h"
#import "Toolbar.h"
#import "SaveHomeInfo.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "Facebook.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "MBProgressHUD.h"
#import "ServerConnection.h"
#import "ASIHTTPRequest.h"

@class EGORefreshTableHeaderView;


@interface Home : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate,MBProgressHUDDelegate,ServerConnectionDelegate>{
    
    UITableView *hometable;
    NSMutableArray *selectionArray;
    UIButton *btnSignUp;
    UIView *line_vw;
    NSString *name;
    NSString *value;
    int l;
    Toolbar *toolBar;
    
    Facebook *facebook;
    OAuthLoginView *oAuthObj;
    
    NSString *str_RefName;
    int RefNo;
    NSMutableArray *Arr_URL_Name;
    MBProgressHUD *_hud;
    NSMutableArray *Arr_CheckValue;
    
    NSTimer *timer;
    NSDate *startDate;
    NSString *timeString;
    
    BOOL deletedDataCall;
    NSString *deletedEventString;
    
    EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;

}
@property(nonatomic,retain)UITableView *hometable;
@property(nonatomic,retain)NSMutableArray *selectionArray;
@property(nonatomic,retain)UIButton *btnSignUp;
@property(nonatomic,retain)UIView *line_vw;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *value;
@property(nonatomic,readwrite)int l;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;
@property (nonatomic, readwrite) int RefNo;
@property (nonatomic, retain) NSString *str_RefName;
@property (nonatomic, retain) NSMutableArray *Arr_CheckValue;

@property(assign,getter=isReloading) BOOL reloading;



-(void)CreateHomeView;
-(void)setHomeViewFrame;

-(void)AddNotification;
-(void) wallPosting;
-(void)displayEmailComposerSheet;
-(void)JSONStartWithName:(NSString*)_RefName;
-(void)ExcuteURLWithNameRef:(int)_RefNumber;
-(BOOL)isValueCointainInDB:(NSString*)_str_Name;




@end
