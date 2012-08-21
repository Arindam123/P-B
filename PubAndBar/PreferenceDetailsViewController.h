//
//  PreferenceDetailsViewController.h
//  PubAndBar
//
//  Created by MacMini Lion-1 on 21/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import "Constant.h"
#import "DistenceWheel.h"
#import "AppDelegate.h"
#import "Toolbar.h"
#import "SaveHomeInfo.h"
#import "MBProgressHUD.h"

#import "FacebookController.h"
#import "MyPreferences.h"
#import "OAuthLoginView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Facebook.h"
#import <MessageUI/MessageUI.h>
#import "ServerConnection.h"


@interface PreferenceDetailsViewController : ButtonAction
<UITableViewDataSource,UITableViewDelegate,FacebookControllerDelegate,MFMailComposeViewControllerDelegate,FBDialogDelegate,ServerConnectionDelegate>
{
    

    
    UITableView *hometable;
   // NSMutableArray *selectionArray;
    UIButton *btnSignUp;
    //UIView *line_vw;
    NSString *name;
    NSString *value;
  //  int i;
    Toolbar *toolBar;
    
    NSMutableArray *RecentArray;
    NSMutableArray *FavouritesArray;
    NSMutableArray *RecentSearchArray;

    NSMutableArray  *array;
    
    IBOutlet UIButton *RecentHistory_Btn;
    IBOutlet UIButton *Favourites_Btn;
    IBOutlet UIButton *RecentSearch_Btn;
    IBOutlet UIButton *EditOrDelet_Btn;
    
    IBOutlet UIButton *backbutton;
    
    BOOL EditOrDeletBtnClicked;
    BOOL FavouritesButtonClicked;
    
    BOOL RecentHistryButtonClicked;
    BOOL RecentSearchButtonClicked;
    
     MBProgressHUD *_hud;
    
    OAuthLoginView *oAuthObj;
    Facebook *facebook;
    AppDelegate *app;
}
@property(nonatomic,retain)UITableView *hometable;
//@property(nonatomic,retain)NSMutableArray *selectionArray;
@property(nonatomic,retain)UIButton *btnSignUp;
//@property(nonatomic,retain)UIView *line_vw;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *value;

@property(nonatomic,retain) NSMutableArray  *array;

@property(nonatomic,retain)NSMutableArray *RecentArray;
@property(nonatomic,retain)NSMutableArray *FavouritesArray;
//@property(nonatomic,readwrite)int i;
@property (retain) MBProgressHUD *hud;

@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;

-(IBAction)ClickBack:(id)sender;
-(void)CreateHomeView;
-(void)setHomeViewFrame;

- (IBAction)TapOnRecentButton:(id)sender;
- (IBAction)TapOnFavouritesButton:(id)sender;
- (IBAction)TapOnRecentSearchButton:(id)sender;
- (IBAction)TapOnEditOrDeletButton:(id)sender;

-(void)AddNotification;
-(void)displayEmailComposerSheet;
-(void)wallPosting;



@end
