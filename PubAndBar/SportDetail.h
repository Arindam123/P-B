//
//  SportDetail.h
//  PubAndBar
//
//  Created by User7 on 08/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveSportDetailInfo.h"
#import "ResultSet.h"
#import "Toolbar.h"
#import "ServerConnection.h"
#import "FacebookController.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"

@interface SportDetail : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,ServerConnectionDelegate>{

    
    UIView *vw_header;
    UILabel *frstlbl;
    UILabel *secndlbl;
    UILabel *thrdlbl;
    UILabel *fourthlbl;
    UILabel *fifthlbl;
    UIButton *backButton;
    UITableView *table_list;
    NSMutableArray *array;
    NSString *sportID;
    NSString *sport_name;
    NSString *searchRadius;
    NSString *searchUnit;
    Toolbar *toolBar;
     MBProgressHUD *_hud;
////////////////////////JHUMA///////////////////////////////////
    UILabel *Title_lbl;
    NSString *str_title;
    UIButton *venu_btn;
    NSMutableArray *arr;
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    UIView *vw1;
    UIView *vw2;
    UIView *vw3;
    UIView *vw4;
    //UIView *vw5;
    EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
    BOOL deletedDataCall;
    NSString *deletedEventString;
    
    
    
}
@property(nonatomic,retain)NSString *str_title;
@property(nonatomic,retain)UILabel *Title_lbl;
@property(nonatomic,retain)NSMutableArray *arr;

/////////////////////////////////////////////////////////////////

@property(nonatomic,retain)UIButton *venu_btn;
@property(nonatomic,retain)UIView *vw_header;
@property(nonatomic,retain)UILabel *frstlbl;
@property(nonatomic,retain)UILabel *secndlbl;
@property(nonatomic,retain)UILabel *thrdlbl;
@property(nonatomic,retain)UILabel *fourthlbl;
@property(nonatomic,retain)UILabel *fifthlbl;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UITableView *table_list;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSString *sportID;
@property(nonatomic,retain)NSString *sport_name;

@property(nonatomic,retain)NSString *searchRadius;
@property(nonatomic,retain)NSString *searchUnit;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;

-(void)CreateView;
-(void)setViewFrame;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
- (void)dataSourceDidFinishLoadingNewData;
-(void) deletedDataCalling:(int)_callerNumber;
@end
