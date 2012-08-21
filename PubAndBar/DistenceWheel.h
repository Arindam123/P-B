//
//  DistenceWheel.h
//  PubAndBar
//
//  Created by Alok K Goyal on 09/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "Toolbar.h"
#import "AppDelegate.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "Facebook.h"
//#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>



@interface DistenceWheel : ButtonAction <UIPickerViewDelegate,UIPickerViewDataSource,FacebookControllerDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate>{
    UILabel *lblSetmaxDistnc;
    UIPickerView *pickerDistenceWheel;
    UIButton *btnNearesttoMe;
    UIButton *btnSend;
    UIImageView *btnSendImg;
    UIImageView *btnNearesttoMeImg;
    NSMutableArray *distenceArray;
    UIButton *backButton;
    UIView *vw_line;
    UILabel *lbl_or;
    NSString *_name;
    NSString *_name1;
    NSString *ale_ID;
    MBProgressHUD *_hud;
    Toolbar *toolBar;
    AppDelegate *appDelegate;
    NSString * pickerValue;
    
    Facebook *facebook;
    OAuthLoginView *oAuthObj;


    
}
@property (nonatomic, retain) UILabel *lblSetmaxDistnc;
@property (nonatomic, retain) UIPickerView *pickerDistenceWheel;
@property (nonatomic, retain) UIButton *btnNearesttoMe;
@property (nonatomic, retain) UIButton *btnSend;
@property (nonatomic, retain) NSMutableArray *distenceArray;
@property (nonatomic,retain) UILabel *lbl_or;
@property (nonatomic,retain) UIView *vw_line;
@property (nonatomic,retain) UIButton *backButton;
@property (nonatomic,retain) NSString *_name;
@property (nonatomic,retain) NSString *_name1;
@property (nonatomic,retain) NSString *ale_ID;
@property (retain) MBProgressHUD *hud;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;




-(void)CreateView;
-(void)setCreateViewFrame;
-(void)PopulateSportsData;

-(void)AddNotification;
-(void) wallPosting;
-(void)displayEmailComposerSheet;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str andString:(NSString *)_str5;

//CREATE TABLE "Preference_Favourites" ("Favourites" INTEGER PRIMARY KEY NOT NULL  )
//CREATE TABLE "Preference_RecentHistory" ("RecentHistory" INTEGER PRIMARY KEY NOT NULL  )
@end
