//
//  Catagory.h
//  PubAndBar
//
//  Created by User7 on 23/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "SaveCatagoryInfo.h"
#import "Toolbar.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "Facebook.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface Catagory : ButtonAction<UITableViewDelegate,UITableViewDataSource,FacebookControllerDelegate,FBDialogDelegate,MFMailComposeViewControllerDelegate>{
    
    UITableView *table_catagory;
    UILabel *lbl_heading;
    NSMutableArray *catagoryArray;
    NSMutableArray *temparray;
    NSString *Name;
    UIButton *backButton;
    UIImageView *nextImg;
    UILabel *topLabel;
    UILabel *middlelbl;
    UILabel *bottomlbl;
    UILabel *endlbl;
    UILabel *firstlbl;
    UILabel *datelbl;
    NSString *eventID;
    NSString *dateString;
    Toolbar *toolBar;
    NSString *searchRadius;
    NSString *searchUnit;
    
    Facebook *facebook;
    OAuthLoginView *oAuthObj;

}
@property(nonatomic,retain) UITableView *table_catagory;
@property(nonatomic,retain)UILabel *lbl_heading;
@property(nonatomic,retain)NSMutableArray *catagoryArray;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain)UIButton *backButton;
@property(nonatomic,retain)UILabel *topLabel;
@property(nonatomic,retain) UIImageView *nextImg;
@property(nonatomic,retain) UILabel *middlelbl;
@property(nonatomic,retain)UILabel *bottomlbl;
@property(nonatomic,retain)UILabel *endlbl;
@property(nonatomic,retain)UILabel *firstlbl;
@property(nonatomic,retain)UILabel *datelbl;
@property(nonatomic,retain)NSMutableArray *temparray;
@property(nonatomic,retain)NSString *eventID;
@property(nonatomic,retain)NSString *dateString;

@property(nonatomic,retain)NSString *searchRadius;
@property(nonatomic,retain)NSString *searchUnit;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;



//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str1;

-(void)CreateView;
-(void)setCatagoryViewFrame;

-(void)AddNotification;
-(void) wallPosting;
-(void)displayEmailComposerSheet;

@end
