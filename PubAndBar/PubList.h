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
#import "Toolbar.h"
#import "MBProgressHUD.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import "ServerConnection.h"


@interface PubList : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,ServerConnectionDelegate>{
    
    UIView *vw_header;
    UILabel *frstlbl;
    UILabel *secndlbl;
    UILabel *thrdlbl;
    UILabel *fourthlbl;
    UILabel *fifthlbl;
    UIButton *backButton;
    UITableView *table_list;
    NSMutableArray *array;
    NSString *categoryStr;
    NSString *catID;
    NSString *beerID;
    NSString *sport_eventID;
    UISegmentedControl *seg_control;
    NearByMap *obj_nearbymap;
    NSString *eventID;
    Toolbar *toolBar;
    NSString *searchRadius;
     NSString *Pubid;
    NSString *eventName;
    NSString *str_AlePostcode;
    //--------------mb-----25/05/12/5-45-----------//
    NSMutableArray *categoryArray;

    MBProgressHUD *_hud;
    
    UILabel *Title_lbl;
    UIImageView *img_1stLbl;
    UIImageView *img_2ndLbl;
    UIImageView *img_3rdLbl;
    UIImageView *img_4thLbl;
    UIImageView *img_5thLbl;
    UIButton *list_btn;
    UIButton *map_btn;
    UIView *btn_view;
   
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    NSString *_Eventpage;
    NSMutableArray *array_EventName;
    
    NSMutableArray *openingHours4Day;
    NSMutableArray *openingHours4Hours;
    NSMutableArray *bulletPointArray;
    NSMutableArray *array_realAle;
    NSMutableArray *array_sportEvent;
    NSMutableArray *array_EventDetails;
    NSMutableDictionary *arry_pubinformation;
    BOOL IsSelect;
    
    
    
    UIImage *rowBackGround;
    UIImage *selectBackGround;
    
    UIView *vw1;
    UIView *vw2;
    UIView *vw3;
    UIView *vw4;
    UIView *vw5;
    

    
    
    //--------------------------//
    //UIButton *_venu_btn;
    NSMutableArray *_pub_list;
    BOOL shiftToNextPage;
    
    AppDelegate *delegate ;
    NSString *str_sportDesc;
     NSString *Day;
    
    NSString *eventTypeId;


}
@property(nonatomic,retain)NSString *eventTypeId;
@property(nonatomic,retain)NSString *Day;
@property(nonatomic,retain)NSMutableArray *array_EventName;
@property(nonatomic,retain)NSMutableArray *array_EventDetails;
@property(nonatomic,retain)NSString *str_sportDesc;
@property(nonatomic,retain)NSMutableArray *array_sportEvent;
@property(nonatomic,retain)UILabel *Title_lbl;
@property(nonatomic,retain)UIImageView *img_1stLbl;
@property(nonatomic,retain)UIImageView *img_2ndLbl;
@property(nonatomic,retain)UIImageView *img_3rdLbl;
@property(nonatomic,retain)UIImageView *img_4thLbl;
@property(nonatomic,retain)UIImageView *img_5thLbl;

@property(nonatomic,retain) NSMutableArray *bulletPointArray;
@property(nonatomic,retain)NSMutableArray *openingHours4Day;
@property(nonatomic,retain)NSMutableArray *openingHours4Hours;

@property(nonatomic,retain)NSString *str_AlePostcode;
@property(nonatomic,retain)NSString *eventName;
@property(nonatomic,retain)NSString *Pubid;
@property(nonatomic,retain)UIView *vw_header;
@property(nonatomic,retain)UILabel *frstlbl;
@property(nonatomic,retain)UILabel *secndlbl;
@property(nonatomic,retain)UILabel *thrdlbl;
@property(nonatomic,retain)UILabel *fourthlbl;
@property(nonatomic,retain)UILabel *fifthlbl;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UITableView *table_list;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain) NSString *catID;
@property(nonatomic,retain) NSString *beerID;
@property(nonatomic,retain)UISegmentedControl *seg_control;
@property(nonatomic,retain)NSString *sport_eventID;
@property(nonatomic,retain)NSString *eventID;
@property(nonatomic,retain) NSString *searchRadius;
@property(nonatomic,retain) NSString *categoryStr;
@property(nonatomic,retain)NSString *_Eventpage;
//-------------------------//
//@property(nonatomic,retain) UIButton *_venu_btn;
//@property(nonatomic,retain) NSMutableArray *_pub_list;


//------------------------mb-25/05/12/5-45---------------
@property(nonatomic,retain)NSMutableArray *categoryArray;

@property (retain) MBProgressHUD *hud;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryStr:(NSString *) categoryString;

//-(IBAction)ClickSegCntrl:(id)sender;
-(void)CreateView;
-(void)setViewFrame;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

//---------------------------------------------------------//

-(IBAction)MorebtnClick:(id)sender;
-(void)_callingMapview;

@end
