//
//  My_Profile.h
//  PubAndBar
//
//  Created by Apple on 03/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>
#import "ResultSet.h"
#import "Toolbar.h"
#import "FacebookController.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import "MBProgressHUD.h"

@interface My_Profile : ButtonAction<FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,UITextFieldDelegate>{
    

    IBOutlet UIButton *btn_my_profile;
    IBOutlet UIScrollView *scrll;
    
    IBOutlet UITextField *txt_FirstName;
    IBOutlet UITextField *txt_LastName;
    IBOutlet UITextField *txt_EmailAddr;
    IBOutlet UITextField *txt_Password;
    IBOutlet UITextField *txt_Location;
    IBOutlet UITextField *txt_Facebook;
    IBOutlet UITextField *txt_GooglePlus;
    IBOutlet UITextField *txt_Twitter;
    IBOutlet UITextField *txt_linkedin;
    IBOutlet UIButton *btn_Back;
    IBOutlet UIButton *btn_Save;
    Toolbar *toolBar;
    MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
    IBOutlet UIView *vw;
    IBOutlet UIImageView *img_recomendedWhtebox;
    IBOutlet UIImageView *img_firstName;
   IBOutlet UIImageView *img_LastName;
    IBOutlet UIImageView *img_Email;
    IBOutlet UIImageView *img_Password;
    IBOutlet UIImageView *img_Location;
}
@property (retain, nonatomic) IBOutlet UIImageView *img_recomendedWhtebox;

@property (retain, nonatomic) IBOutlet UIButton *btn_my_profile;

@property (retain, nonatomic) IBOutlet UIScrollView *scrll;

@property (retain, nonatomic) IBOutlet UITextField *txt_FirstName;
@property (retain, nonatomic) IBOutlet UITextField *txt_LastName;
@property (retain, nonatomic) IBOutlet UITextField *txt_EmailAddr;
@property (retain, nonatomic) IBOutlet UITextField *txt_Password;
@property (retain, nonatomic) IBOutlet UITextField *txt_Location;
@property (retain, nonatomic) IBOutlet UITextField *txt_Facebook;
@property (retain, nonatomic) IBOutlet UITextField *txt_GooglePlus;
@property (retain, nonatomic) IBOutlet UITextField *txt_Twitter;
@property (retain, nonatomic) IBOutlet UITextField *txt_linkedin;
@property (retain, nonatomic) IBOutlet UIButton *btn_Back;
@property (retain, nonatomic) IBOutlet UIButton *btn_Save;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;

//-(void)CreateView;
-(void)setViewFrame;
-(IBAction)ClickBack:(id)sender;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
-(IBAction)ClickSave:(id)sender;


@end
