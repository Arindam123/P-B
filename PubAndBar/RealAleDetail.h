//
//  RealAleDetail.h
//  PubAndBar
//
//  Created by User7 on 26/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveAleDetailInfo.h"
#import "ButtonAction.h"
#import "AppDelegate.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import "Toolbar.h"
#import "ServerConnection.h"
#import "EGORefreshTableHeaderView.h"

@interface RealAleDetail : ButtonAction<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FacebookControllerDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate,ServerConnectionDelegate>{
    
    UITableView *tableale;
    UIButton *backButton;
    //UIButton *btnsearch;
    UITextField *text_field;
    NSString *aledetails;
    NSMutableArray *detailsArray;
    UILabel *topLabel;
    UILabel *middleLable;
    UIImageView *nextImg;
    NSString * Realale_ID;
    NSString *_Name;
    NSString *searchRadius;
    NSString *searchUnit;
    
    ////////////////////////////JHUMA////////////////////////////////////////////////////////////
    UIView *vw_search;
    UILabel *Title_lbl;
    NSString *str_breweryName;
    NSString *strPostcode;
    UIImageView *img_1stLbl;
     MBProgressHUD *_hud;
    Toolbar *toolBar;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    
    NSMutableString *str;
    UILabel *lblHeader;
    NSMutableArray *searchArray;
    UILabel *searchLabel;
    CGSize expectedLabelSize;
    EGORefreshTableHeaderView *refreshHeaderView;
	BOOL _reloading;
    BOOL deletedDataCall;
    NSString *deletedEventString;
    
}
@property(assign,getter=isReloading) BOOL reloading;
@property (nonatomic,retain)NSString *strPostcode;
@property (nonatomic,retain)UILabel *Title_lbl;
@property (nonatomic,retain)UIView *vw_search;
@property (nonatomic,retain)NSString *str_breweryName;
@property(nonatomic,retain)UIImageView *img_1stLbl;

////////////////////////////////////////////////////////////////////////////////////////



@property(nonatomic,retain) UITableView *tableale;
@property(nonatomic,retain)UIButton *backButton;
//@property(nonatomic,retain)UIButton *btnsearch;
@property(nonatomic,retain)UITextField *text_field;
@property(nonatomic,retain)NSString *aledetails;
@property(nonatomic,retain) NSMutableArray *detailsArray;
@property(nonatomic,retain)UILabel *topLabel;
@property(nonatomic,retain)UILabel *middleLable;
@property(nonatomic,retain)UIImageView *nextImg;
@property(nonatomic,retain) NSString * Realale_ID;
@property(nonatomic,retain) NSString *_Name;

@property (nonatomic,retain) NSString *searchRadius;
@property (nonatomic,retain) NSString *searchUnit;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@property (nonatomic, retain) NSMutableString *str;


-(void)CreateView;
-(void)setAleViewFrame;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
- (void)dataSourceDidFinishLoadingNewData;
-(void) deletedDataCalling:(int)_callerNumber;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *) _str3 andString:(NSString *) _str8;
@end
