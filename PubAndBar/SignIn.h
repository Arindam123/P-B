//
//  SignIn.h
//  PubAndBar
//
//  Created by Apple on 04/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "ButtonAction.h"
//#import <QuartzCore/QuartzCore.h>
//#import "ResultSet.h"
//#import "Toolbar.h"
//#import "FacebookController.h"
//#import "OAuthLoginView.h"
//#import <MessageUI/MFMailComposeViewController.h>
//#import "iCodeOauthViewController.h"
//#import "Facebook.h"
//#import "MBProgressHUD.h"

@interface SignIn: UIViewController<UITextFieldDelegate>{
    
     
  
    IBOutlet UIButton *btn_signUp;
    
    IBOutlet UIScrollView *ScrollVw;
    IBOutlet UIButton *btn_signin;
    IBOutlet UITextField *txt_Email;
    
    IBOutlet UIButton *btn_cancel;
    IBOutlet UITextField *txt_Password;
    AppDelegate *app;
    NSString *Content_jsonData;
   
}
@property (retain, nonatomic) IBOutlet UIButton *btn_signUp;


@property (retain, nonatomic) IBOutlet UIButton *btn_cancel;

@property (retain, nonatomic) IBOutlet UITextField *txt_Email;
@property (retain, nonatomic) IBOutlet UITextField *txt_Password;



@property (retain, nonatomic) IBOutlet UIButton *btn_signin;

@property (retain, nonatomic) IBOutlet UIScrollView *ScrollVw;

//-(void)CreateView;
//-(void)setViewFrame;
//-(void)AddNotification;
//-(void)displayEmailComposerSheet;
//-(void)wallPosting;
-(IBAction)ClickCancel:(id)sender;
-(void)signUp:(NSString *)_mailID password:(NSString *)_password ;
-(IBAction)ClickSignUp:(id)sender;
-(IBAction)ClickSignin:(id)sender;
-(BOOL) validateEmail: (NSString *)Email;
@end
