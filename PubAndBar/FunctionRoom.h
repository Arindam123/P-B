//
//  FunctionRoom.h
//  PubAndBar
//
//  Created by User7 on 30/04/12.
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


@interface FunctionRoom : ButtonAction<UITextViewDelegate,UITextFieldDelegate,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>{
    
    UIButton *backButton;
    UILabel *lbl_heading;
    UIScrollView *scrw;
    UILabel *lbl_content;
    UILabel *lbl_1st;
    UILabel *lbl_2nd;
    UILabel *lbl_3rd;
    UILabel *lbl_4th;
    UILabel *lbl_5th;
    UILabel *lbl_6th;
    UILabel *lbl_7th;
    UILabel *lbl_8th;
    UILabel *lbl_9th;
    UILabel *lbl_10th;
    UITextField *txt_1st;
    UITextField *txt_2nd;
    UITextField *txt_3rd;
    UITextField *txt_4th;
    UITextField *txt_5th;
    UITextField *txt_6th;
    UITextField *txt_7th;
    UITextField *txt_8th;
    UITextField *txt_9th;
    UITextView *txt_view;
    UIButton *btn_submit;
    UILabel *req1;
    UILabel *req2;
    UILabel *req3;
    UILabel *req4;
    UILabel *req5;
    UILabel *req6;
    UILabel *req7;
    UILabel *req8;
    UILabel *req9;
     MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    NSString *pageName;
     
}

@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UILabel *lbl_heading;
@property(nonatomic,retain)UIScrollView *scrw;
@property(nonatomic,retain)UILabel *lbl_content;
@property(nonatomic,retain)UILabel *lbl_1st;
@property(nonatomic,retain)UILabel *lbl_2nd;
@property(nonatomic,retain)UILabel *lbl_3rd;
@property(nonatomic,retain)UILabel *lbl_4th;
@property(nonatomic,retain)UILabel *lbl_5th;
@property(nonatomic,retain)UILabel *lbl_6th;
@property(nonatomic,retain)UILabel *lbl_7th;
@property(nonatomic,retain)UILabel *lbl_8th;
@property(nonatomic,retain)UILabel *lbl_9th;
@property(nonatomic,retain)UILabel *lbl_10th;
@property(nonatomic,retain)UITextField *txt_1st;
@property(nonatomic,retain)UITextField *txt_2nd;
@property(nonatomic,retain)UITextField *txt_3rd;
@property(nonatomic,retain)UITextField *txt_4th;
@property(nonatomic,retain)UITextField *txt_5th;
@property(nonatomic,retain)UITextField *txt_6th;
@property(nonatomic,retain)UITextField *txt_7th;
@property(nonatomic,retain)UITextField *txt_8th;
@property(nonatomic,retain)UITextField *txt_9th;
@property(nonatomic,retain)UITextView *txt_view;
@property(nonatomic,retain)UIButton *btn_submit;
@property(nonatomic,retain)NSString *pageName;


@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

-(void)CreateView;
-(void)setViewFrame;
-(IBAction)Click_submitbtn:(id)sender;
-(BOOL) validateEmail: (NSString *)Email;

-(void)formSubmit:(NSString *)location numberOfpeople:(NSString *)noOfpeople purposeOfEvent:(NSString *)event Date:(NSString *)date Require:(NSString *)require OtherRequirements:(NSString *)otherRequirements Name:(NSString *)name Emailaddress:(NSString *)email ConfirmEmail:(NSString *)con_email PhoneNumber:(NSString *)ph_number;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;


@end
