//
//  MyPreferences.h
//  PubAndBar
//
//  Created by User7 on 09/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonAction.h"
#import <QuartzCore/QuartzCore.h>
//UITableViewDelegate,UITableViewDataSource,
@interface MyPreferences : ButtonAction<UITextFieldDelegate>{

    IBOutlet UIView *Vw_Settings;
    IBOutlet UIView *Vw_Preference;
    
    IBOutlet UIView *Vw_Contact_Preferences;
    
    IBOutlet UIButton *CurrentLocation_Yes;
    IBOutlet UIButton *CurrentLocation_No;
    IBOutlet UIButton *ShowsResultIn_Mls;
    IBOutlet UIButton *ShowsResultIn_Km;
    IBOutlet UITextField *Txt_NumberOfPubs;
    IBOutlet UIButton *SaveInCache_Yes;
    IBOutlet UIButton *SaveInCache_No;
    IBOutlet UIButton *ShowResultIn_Map;
    IBOutlet UIButton *ShowResultIn_List;
    IBOutlet UIScrollView *Scrl_Settings_Preference;
    IBOutlet UIButton *Btn_Continue;
    
    IBOutlet UIButton *MyFav_Btn;
    
    IBOutlet UIButton *MyAlert_Btn;
    
    IBOutlet UIButton *RecVenue;

    UITableView *table_mypreference;
    UIButton *btn_continue;
    UIView *vw_socialnetwrk;
    BOOL isChecked;
    
    UIImageView *TFIn_view;

    }

@property(nonatomic,retain)UITableView *table_mypreference;
@property(nonatomic,retain)UIButton *btn_continue;
@property(nonatomic,retain)UIView *vw_socialnetwrk;
@property(nonatomic,readwrite)BOOL isChecked;



//-(void)CreateView;
//-(void)setMyprefViewFrame;

-(void)ManupulateSettingsView;
-(void)ManupulatePreferenceView;
- (IBAction)SetCurrentLocation:(id)sender;
- (IBAction)SettoShowResult:(id)sender;
- (IBAction)SetToSaveHistory:(id)sender;
- (IBAction)SetPubsShowsIn:(id)sender;
- (IBAction)ContinueToApp_Click:(id)sender;
-(void)CreatTFIn_view;

@end
