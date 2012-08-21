//
//  PubList.h
//  PubAndBar
//
//  Created by User7 on 02/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>
#import "SavePubListInfo.h"
#import "NearByMap.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
//******************************* amit-04/06/2012 *************************//
#import "MBProgressHUD.h"
//***************************************************************************//
#import "Toolbar.h"
#import "ServerConnection.h"

@interface NearMeNow : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,ServerConnectionDelegate>{
    
    UITableView *table_list;
    NSString *categoryStr;
    NSString *PubId;
    UISegmentedControl *seg_control;
    NSMutableArray *PubArray;
    NSMutableArray *array4NonSubPubs;
    NearByMap *obj_nearbymap;
    //UIButton *venu_btn;
    NSMutableArray *pub_list;
    NSString *str_distance;
    UIButton *backButton;
    
    //-------------mb-28-05-12--------------//
    int noOfPubs;
    int k;
    
    UIButton *list_btn;
    UIButton *map_btn;
    UIView *btn_view;
    
    NSString *_pageName;

    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
//******************************* amit-04/06/2012 *************************//
    MBProgressHUD *_hud;
//***************************************************************************//
    
    
    Toolbar *_Toolbar;
    AppDelegate *app;
    BOOL _IsSelect;
    
    BOOL shiftToNextPage;
    NSMutableArray *openingHours4Day;
    NSMutableArray *openingHours4Hours;
    NSMutableArray *bulletPointArray;

     NSMutableDictionary *header_DictionaryData;
    
    NSMutableArray *mapArray;
    int moreNonSubPubsHitCount;



}
 @property(nonatomic,retain)NSMutableDictionary *header_DictionaryData;
@property(nonatomic,retain) NSMutableArray *bulletPointArray;
@property(nonatomic,retain)NSMutableArray *openingHours4Day;
@property(nonatomic,retain)NSMutableArray *openingHours4Hours;
//@property(nonatomic,retain)UILabel *middleLbl;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)NSString *str_distance;
@property(nonatomic,retain)UITableView *table_list;
@property(nonatomic,retain) NSString *PubId;
@property(nonatomic,retain)UISegmentedControl *seg_control;
@property(nonatomic,retain) NSMutableArray *PubArray;
//@property(nonatomic,retain) UIButton *venu_btn;
@property(nonatomic,retain) NSMutableArray *pub_list;
@property(nonatomic,retain) NSString *_pageName;
//******************************* amit-04/06/2012 *************************//
@property (retain) MBProgressHUD *hud;
//***************************************************************************//

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

-(void)CreateHomeView;
-(void)setHomeViewFrame;
-(void)callingMapview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryStr:(NSString *) categoryString;

//-(IBAction)ClickSegCntrl:(id)sender;
-(IBAction)More_btnClick:(id)sender;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
