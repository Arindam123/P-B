//
//  EventCatagory.h
//  PubAndBar
//
//  Created by User7 on 24/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "SaveEventCatagoryInfo.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import "AppDelegate.h"
#import "Toolbar.h"
#import "ServerConnection.h"
#import "URLRequestString.h"
#import "EGORefreshTableHeaderView.h"

@interface EventCatagory : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,ServerConnectionDelegate>{
    
     UITableView *table_eventcatagory;
    UILabel *lbl_heading;
    NSArray *eventArray;
    UIButton *backButton;
    UILabel  *lbl_bottom;
    UIButton *btn_bottom;
    UIView *view_line;
    NSString *title;
    UILabel *topLabel;
    UIImageView *nextImg;
     MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    Toolbar *toolBar;
    NSString *strPagename;
    UIView *vw1;
    UIButton *reccomonendVenueBtn;
    AppDelegate *delegate ;
    NSString *str_RefName;
    
    EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
    BOOL deletedDataCall;
    NSString *deletedEventString;

}
@property(assign,getter=isReloading) BOOL reloading;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UITableView *table_eventcatagory;
@property(nonatomic,retain)NSArray *eventArray;
@property(nonatomic,retain)UILabel *lbl_heading;
@property(nonatomic,retain)UILabel  *lbl_bottom;
@property(nonatomic,retain) UIButton *btn_bottom;
@property(nonatomic,retain)UIView *view_line;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)UILabel *topLabel;
@property(nonatomic,retain) UIImageView *nextImg;
@property(nonatomic,retain) NSString *strPagename;


@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;


-(void)CreateView;
-(void)setEventCatagoryViewFrame;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *) _str2;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
-(void)dataSourceDidFinishLoadingNewData;
-(void) DataCalling4deleted:(int)_callerNumber;
@end
