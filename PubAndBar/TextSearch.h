//
//  TextSearch.h
//  PubAndBar
//
//  Created by User7 on 26/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"

#import "Toolbar.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "NearByMap.h"
#import "ServerConnection.h"

@interface TextSearch : ButtonAction<UITextFieldDelegate,UITextViewDelegate,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,UITableViewDataSource,UITableViewDelegate,ServerConnectionDelegate>{
  
    UIButton *backButton;
    UILabel *lblheading;
    UITextField *searchbar;
    UITextView *txtvw;
    UIView *vw;
    UIView *vw_textfield;
    UITextView *resultvw;
    UIScrollView *scrvw;
    UIButton *list_btn;
    UIButton *map_btn;
    NearByMap *obj_nearbymap;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    Toolbar *toolBar;
    
    NSMutableArray *array;
    UITableView *searchTable;
    UILabel *lbl_venueName;
    UILabel *lbl_distance;
    NSMutableArray *openingHours4Day;
    NSMutableArray *openingHours4Hours;
    NSMutableArray *bulletPointArray;
    MBProgressHUD *_hud;
    AppDelegate *appDelegate;
    NSString *PUBID;
    NSMutableArray *mapArray;
     NSMutableArray *pub_list;
    NSMutableArray *array4NonSubPubs;
    int noOfPubs;
    int k;

    UISegmentedControl *segmentedControl;

}
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UILabel *lblheading;
@property(nonatomic,retain)UITextField *searchbar;
@property(nonatomic,retain)UITextView *txtvw;
@property(nonatomic,retain)UIView *vw;
@property(nonatomic,retain)UIView *vw_textfield;
@property(nonatomic,retain)UITextView *resultvw;
@property(nonatomic,retain)UIScrollView *scrvw;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;


-(void)CreateView;
-(void)setViewFrame;
-(void)callingMapview;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
