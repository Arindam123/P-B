//
//  TextSearch.h
//  PubAndBar
//
//  Created by User7 on 26/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "iCodeOauthViewController.h"
#import "Facebook.h"

#import "Toolbar.h"

@interface TextSearch : ButtonAction<UITextFieldDelegate,UITextViewDelegate,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate>{
  
    UIButton *backButton;
    UILabel *lblheading;
    UITextField *searchbar;
    UITextView *txtvw;
    UIView *vw;
    UIView *vw_textfield;
    UITextView *resultvw;
    UIScrollView *scrvw;
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    Toolbar *toolBar;

}
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UILabel *lblheading;
@property(nonatomic,retain)UITextField *searchbar;
@property(nonatomic,retain)UITextView *txtvw;
@property(nonatomic,retain)UIView *vw;
@property(nonatomic,retain)UIView *vw_textfield;
@property(nonatomic,retain)UITextView *resultvw;
@property(nonatomic,retain)UIScrollView *scrvw;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;


-(void)CreateView;
-(void)setViewFrame;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
