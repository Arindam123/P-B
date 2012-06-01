//
//  RealAle.h
//  PubAndBar
//
//  Created by User7 on 25/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "SaveRealAleInfo.h"
#import "AppDelegate.h"
#import "Toolbar.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "iCodeOauthViewController.h"
#import "Facebook.h"
#import "Toolbar.h"

@interface RealAle : ButtonAction<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FacebookControllerDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate>{
    
    UITableView *table_realale;
    NSMutableArray *aleArray;
    UIButton *backButton;
    UIButton *btnsearch;
    UITextField *text_field;
    UILabel *topLabel;
    UIImageView *nextImg;
    NSString *ale_name;
    NSString *realale;
    int vari;
    NSString *searchRadius;
    NSString *searchUnit;
    Toolbar *toolBar;
    
    ////////////////////////////JHUMA////////////////////////////////////////////////////////////
    
    UILabel *Title_lbl;
    UIView *vw_search;
    UIImageView *img_1stLbl;
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    
    
}
@property (nonatomic,retain)UIView *vw_search;
@property (nonatomic,retain)UILabel *Title_lbl;
@property(nonatomic,retain)UIImageView *img_1stLbl;


////////////////////////////////////////////////////////////////////////////////////////



@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

@property (nonatomic,retain) UITableView *table_realale;
@property (nonatomic,retain) NSMutableArray *aleArray;
@property (nonatomic,retain) UIButton *backButton;
@property (nonatomic,retain) UIButton *btnsearch;
@property (nonatomic,retain) UITextField *text_field;
@property (nonatomic,retain) UILabel *topLabel;
@property (nonatomic,retain) UIImageView *nextImg;
@property (nonatomic,retain) NSString *ale_name;
@property (nonatomic,retain) NSString *realale;
@property (nonatomic,readwrite) int vari;
@property (nonatomic,retain) NSString *searchRadius;
@property (nonatomic,retain) NSString *searchUnit;




-(void)CreateView;
-(void)setAleViewFrame;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str4;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
