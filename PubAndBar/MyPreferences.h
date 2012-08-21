//
//  MyPreferences.h
//  PubAndBar
//
//  Created by User7 on 09/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>

#import "FacebookController.h"
#import "MyPreferences.h"
#import "Facebook.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "MBProgressHUD.h"
//UITableViewDelegate,UITableViewDataSource,
@interface MyPreferences : ButtonAction<UITextFieldDelegate,FacebookControllerDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate>{

    IBOutlet UIView *Vw_Settings;
    IBOutlet UIView *Vw_Preference;
    UIImageView *img1;
    IBOutlet UIView *Vw_Contact_Preferences;
    
    IBOutlet UIButton *CurrentLocation_Yes;
    IBOutlet UIButton *CurrentLocation_No;
    IBOutlet UIButton *ShowsResultIn_Mls;
    IBOutlet UIButton *ShowsResultIn_Km;
    IBOutlet UITextField *Txt_NumberOfPubs;
    IBOutlet UIButton *SaveInCache_Yes;
    IBOutlet UIButton *SaveInCache_No;
    IBOutlet UIButton *ShowResultIn_Map;
    IBOutlet UIButton *ShowResultIn_List;
    IBOutlet UIScrollView *Scrl_Settings_Preference;
    IBOutlet UIButton *Btn_Continue;
    IBOutlet UILabel *lbl1;
     IBOutlet UILabel *lbl2;
     IBOutlet UILabel *lbl3;
     IBOutlet UILabel *lbl4;
     IBOutlet UILabel *lbl5;
    
   IBOutlet UILabel *lbl10;
    IBOutlet UILabel *lbl11;
    IBOutlet UILabel *lbl12;
    IBOutlet UILabel *lbl13;
    IBOutlet UILabel *lbl14;
    IBOutlet UILabel *lbl15;
    IBOutlet UILabel *lbl16;
    IBOutlet UILabel *lbl17;
  
     IBOutlet UIButton *RecVenue;
   
    
    UITableView *table_mypreference;
    UIView *vw_socialnetwrk;
    BOOL isChecked;
    
    UIImageView *TFIn_view;
     MBProgressHUD *_hud;
    Facebook *facebook;
    OAuthLoginView *oAuthObj;
    MFMailComposeViewController * mailController;
    IBOutlet UIButton *backbutton;
    IBOutlet UIButton *btn_reviewApp;
    IBOutlet UIImageView *title_img;


    }
@property (retain, nonatomic) IBOutlet UIImageView *title_img;

//@property(nonatomic,retain)IBOutlet UIButton *backbutton;
//@property(nonatomic,retain)IBOutlet UIButton *btn_Email;
@property(nonatomic,retain)IBOutlet UIButton *btn_Phone;
@property(nonatomic,retain)IBOutlet UIButton *btn_Yourideas;
@property(nonatomic,retain)UITableView *table_mypreference;
@property(nonatomic,retain)UIButton *btn_continue;
@property(nonatomic,retain)UIView *vw_socialnetwrk;
@property(nonatomic,readwrite)BOOL isChecked;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;



//-(void)CreateView;
//-(void)setMyprefViewFrame;

-(void)ManupulateSettingsView;
-(void)ManupulatePreferenceView;
- (IBAction)SetCurrentLocation:(id)sender;
- (IBAction)SettoShowResult:(id)sender;
- (IBAction)SetToSaveHistory:(id)sender;
- (IBAction)SetPubsShowsIn:(id)sender;
- (IBAction)ContinueToApp_Click:(id)sender;
-(IBAction)ClickEmail:(id)sender;

//-(void)CreatTFIn_view;
-(IBAction)ClickReviewApp:(id)sender;
-(void)AddNotification;
-(void) wallPosting;
-(void)displayEmailComposerSheet;
-(IBAction)ClickBack:(id)sender;
@end
