//
//  RecomendedVenue.h
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

@interface RecomendedVenue : ButtonAction<FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,UITextFieldDelegate,UITextViewDelegate>{
    
    
    IBOutlet UIImageView *img_header;
  
    IBOutlet UIScrollView *scrll;
       IBOutlet UIButton *backbutton;
    Toolbar *toolBar;
    MBProgressHUD *_hud;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
   
    IBOutlet UITextView *txt_Address;
    IBOutlet UITextField *txt_VenueName;
    
    IBOutlet UITextField *txt_recomndedBy;
    IBOutlet UIView *vw;
    IBOutlet UIButton *sendbutton;
    BOOL IsRecomended;
    IBOutlet UIImageView *img_To;
    IBOutlet UIImageView *img_Subject;
    IBOutlet UIImageView *img_From;
    IBOutlet UILabel *lbl_VenueName;
    IBOutlet UILabel *lbl_Address;
    IBOutlet UILabel *lbl_recommendedBy;
}

@property (retain, nonatomic) IBOutlet UILabel *lbl_recommendedBy;

@property (retain, nonatomic) IBOutlet UILabel *lbl_Address;

@property (retain, nonatomic) IBOutlet UILabel *lbl_VenueName;

@property (retain, nonatomic) IBOutlet UIScrollView *scrll;
@property (retain, nonatomic) IBOutlet UIImageView *img_header;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain) MBProgressHUD *hud;
@property (retain, nonatomic) IBOutlet UIButton *backbutton;
@property (retain, nonatomic)  UITextField *txt_VenueName;
@property (retain, nonatomic)  UITextView *txt_Address;
@property (retain, nonatomic)  UITextField *txt_recomndedBy;
@property (retain, nonatomic)  UIButton *sendbutton;



//-(void)CreateView;
-(void)setViewFrame;
-(IBAction)ClickBack:(id)sender;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
-(IBAction)ClickSend:(id)sender;

@end


