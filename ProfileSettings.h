//
//  ProfileSettings.h
//  PubAndBar
//
//  Created by Apple on 03/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//


#import <UIKit/UIKit.h>
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

@interface ProfileSettings : ButtonAction<FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,UITextFieldDelegate,UITextViewDelegate>{
    
    
    
    IBOutlet UIScrollView *scrll;
    IBOutlet UIButton *backbutton;
    Toolbar *toolBar;
    MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
    IBOutlet UIView *img_whiteBox;
    
    IBOutlet UITextView *txt_Address;
    IBOutlet UITextField *txt_VenueName;
    
    IBOutlet UITextField *txt_recomndedBy;
    
    IBOutlet UIButton *sendbutton;
    BOOL IsRecomended;
    IBOutlet UIImageView *img_title;
    IBOutlet UITextView *txt;
   
}


@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;
@property (retain, nonatomic) IBOutlet UIButton *backbutton;



//-(void)CreateView;
-(void)setViewFrame;
-(IBAction)ClickBack:(id)sender;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
//-(IBAction)ClickSend:(id)sender;

@end


