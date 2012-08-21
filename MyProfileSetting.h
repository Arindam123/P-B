//
//  MyProfileSetting.h
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

@interface MyProfileSetting : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>{
    
  
    IBOutlet UITableView *My_table;
    Toolbar *toolBar;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
    NSMutableArray *section_array;
    
    IBOutlet UIImageView *img_button;
    IBOutlet UIButton *btn_signin;
}

@property (retain, nonatomic) IBOutlet UIButton *btn_signin;


@property (retain, nonatomic) IBOutlet UIImageView *img_button;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@property (retain, nonatomic) IBOutlet UITableView *My_table;

//-(void)CreateView;
-(void)setViewFrame;
-(IBAction)ClickBack:(id)sender;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;
-(IBAction)ClickSignup:(id)sender;

@end
