//
//  ContactHelp.h
//  PubAndBar
//
//  Created by Apple on 06/07/12.
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

@interface ContactHelp  : ButtonAction<FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>{

    IBOutlet UIScrollView *main_vw;



    
    IBOutlet UIButton *backbutton;
    
    IBOutlet UIImageView *white_img;
    IBOutlet UIImageView *img_contact;
    
    IBOutlet UIButton *btn_frequentAsk;
    
    Toolbar *toolBar;
    MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
    
    IBOutlet UIView *vw;
    
}
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;
@property (retain, nonatomic) IBOutlet UIButton *backbutton;
@property (retain, nonatomic) IBOutlet UIImageView *white_img;
@property (retain, nonatomic) IBOutlet UIImageView *img_contact;
@property (retain, nonatomic) IBOutlet UIButton *btn_frequentAsk;
@property (retain, nonatomic) IBOutlet UIScrollView *main_vw;
@property (retain, nonatomic) IBOutlet UIView *vw;




//-(void)CreateView;
-(void)setViewFrame;
-(IBAction)ClickBack:(id)sender;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
-(IBAction)ClickFrequentAsked:(id)sender;

@end


