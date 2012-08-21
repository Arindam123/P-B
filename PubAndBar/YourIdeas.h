//
//  YourIdeas.h
//  PubAndBar
//
//  Created by Apple on 05/07/12.
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

@interface YourIdeas : ButtonAction<FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,UITextViewDelegate>{
    
    IBOutlet UIImageView *header_img;
    
    
    IBOutlet UIButton *backbutton;
    Toolbar *toolBar;
    MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
    
    IBOutlet UIImageView *main_vw;

    IBOutlet UIButton *btn_send;
    
    IBOutlet UILabel *footer_lbl;
    
    IBOutlet UIScrollView *scrll;
    IBOutlet UITextView *txt_vw;
    BOOL IsyourIdea;
}

@property (retain, nonatomic) IBOutlet UITextView *txt_vw;

@property (retain, nonatomic) IBOutlet UILabel *footer_lbl;
@property (retain, nonatomic) IBOutlet UIScrollView *scrll;


@property (retain, nonatomic) IBOutlet UIButton *btn_send;

@property (retain, nonatomic) IBOutlet UIImageView *main_vw;

@property (retain, nonatomic) IBOutlet UIImageView *header_img;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;




//-(void)CreateView;
-(void)setViewFrame;
-(IBAction)ClickBack:(id)sender;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
//-(IBAction)ClickSend:(id)sender;

@end



