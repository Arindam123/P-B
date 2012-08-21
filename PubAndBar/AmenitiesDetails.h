//
//  AmenitiesDetails.h
//  PubAndBar
//
//  Created by Subhra Da on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "AmenitiesInfo.h"
#import "Toolbar.h"
#import <QuartzCore/QuartzCore.h>

#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "FacebookController.h"
#import "MyPreferences.h"

@interface AmenitiesDetails : ButtonAction
<FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UITableView *table_catagory;
    UILabel *lbl_heading;
    NSMutableArray *catagoryArray;
    NSString *Name;
    UIButton *backButton;

    Toolbar *toolBar;
    NSString *searchRadius;
    
    UIButton *SearchBtn;
    NSMutableArray *AmmenitiesArray;
     MBProgressHUD *_hud;
    int r;
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    UIPickerView *pickerDistenceWheel;
    NSString * pickerValue;
}
@property (retain) MBProgressHUD *hud;
@property(nonatomic,retain) UITableView *table_catagory;
@property(nonatomic,retain)UILabel *lbl_heading;
@property(nonatomic,retain)NSMutableArray *catagoryArray;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain)UIButton *backButton;


@property(nonatomic,retain)NSString *searchRadius;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str1;

-(void)CreateView;
-(void)setCatagoryViewFrame;
-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;

@end
