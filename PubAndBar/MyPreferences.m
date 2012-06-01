//
//  MyPreferences.m
//  PubAndBar
//
//  Created by User7 on 09/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "MyPreferences.h"
#import "Global.h"
#import "Toolbar.h"
#import "AppDelegate.h"
#import "PreferenceDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CurreentLocation_Yes_Tag  1
#define CurreentLocation_No_Tag   2
#define ShowsResultIn_Mls_Tag     3
#define ShowsResultIn_Km_Tag      4
#define SaveInHistory_Yes_Tag     5
#define SaveInHistory_NO_Tag      6
#define PubsShowsIn_List_Tag      7
#define PubsShowsIn_Map_Tag       8


@implementation MyPreferences
@synthesize table_mypreference;
@synthesize btn_continue;
@synthesize vw_socialnetwrk;
@synthesize isChecked;


UILabel *topLabel_setting;
UIImageView *iconImg_setting;
UILabel *topLabel_preference;
UIImageView *iconImg_preference;
UILabel *label1;
UILabel *label2;
UILabel *label3;
UILabel *label4;
UILabel *label5;
UILabel *label6;
UILabel *label7;
UILabel *label8;
UILabel *label9;
UILabel *label10;
UILabel *label11;
UILabel *label12;
UILabel *label13;
UIButton *button1;
UIButton *button2;
UIButton *button3;
UIButton *button4;
UIButton *button5;
UIButton *button6;
UIButton *button7;
UIButton *button8;
UITextField *textfield;
UIImageView *img_star;
UIImageView *img_excla;
UIImageView *img_bowl;
UIImageView *img_pen;
UIView *vw;
UIButton *btn_contactus;
UILabel *lbl_phone;
UILabel *lbl_number;
UILabel *lbl_email;
UILabel *lbl_id;
UILabel *label14;
UILabel *label15;
UILabel *label16;
UILabel *label17;
UIView *vw;
UIButton *btn_continue;
UIView *vw_socialnetwrk;
UILabel *lbl_socialnetwrk;
UIButton *btn_twitter;
UIButton *btn_facebook;
UIButton *btn_lnkedin;



Toolbar *_toolbar;
AppDelegate *app;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.eventTextLbl.text = @"My Preferences";
    TFIn_view = [[UIImageView alloc]init];

    
    //------------------------------mb-28-05-12--------------------------//
    if (GET_DEFAUL_VALUE(CurrentLocation) == nil)
        SAVE_AS_DEFAULT(CurrentLocation, @"YES");
    
    if (GET_DEFAUL_VALUE(ShowsResultIN) == nil)
        SAVE_AS_DEFAULT(ShowsResultIN, @"MLS");
    
    if (GET_DEFAUL_VALUE(SaveCacheToSeeHistory) == nil)
        SAVE_AS_DEFAULT(SaveCacheToSeeHistory,@"YES");
    
    if (GET_DEFAUL_VALUE(PubsShowsIn) == nil)
        SAVE_AS_DEFAULT(PubsShowsIn,@"LIST");
    
    if (GET_DEFAUL_VALUE(ShowNumberOfPubs) == nil) 
        SAVE_AS_DEFAULT(ShowNumberOfPubs,@"20");
    //-------------------------------------------------------------------//
    
    [self ManupulateSettingsView];
    [self ManupulatePreferenceView];
    Scrl_Settings_Preference.frame = CGRectMake(0, 0, 320, 480);
    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _toolbar = [[Toolbar alloc] init];
    _toolbar.layer.borderWidth = 1.0f;
    _toolbar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_toolbar];
    [self CreatTFIn_view];

    
}

-(void)CreatTFIn_view{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            [TFIn_view setImage:nil];
            
            TFIn_view.image=[UIImage imageNamed:@"SmallTFINButton.png"];
        }
        else{
            [TFIn_view setImage:nil];
            TFIn_view.image=[UIImage imageNamed:@"SmallTFINButton@2x.png"]; 
        }
    }
    
    [Vw_Preference addSubview:TFIn_view];
    
}




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    
}




- (void)viewDidUnload
{
    [Vw_Settings release];
    Vw_Settings = nil;
    [Vw_Preference release];
    Vw_Preference = nil;
    [Vw_Contact_Preferences release];
    Vw_Contact_Preferences = nil;
    [CurrentLocation_Yes release];
    CurrentLocation_Yes = nil;
    [CurrentLocation_No release];
    CurrentLocation_No = nil;
    [ShowsResultIn_Mls release];
    ShowsResultIn_Mls = nil;
    [ShowsResultIn_Km release];
    ShowsResultIn_Km = nil;
    [Txt_NumberOfPubs release];
    Txt_NumberOfPubs = nil;
    [SaveInCache_Yes release];
    SaveInCache_Yes = nil;
    [SaveInCache_No release];
    SaveInCache_No = nil;
    [ShowResultIn_Map release];
    ShowResultIn_Map = nil;
    [ShowResultIn_List release];
    ShowResultIn_List = nil;
    [Scrl_Settings_Preference release];
    Scrl_Settings_Preference = nil;
    [Btn_Continue release];
    Btn_Continue = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    table_mypreference= nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //(interfaceOrientation == UIInterfaceOrientationPortrait);
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        Scrl_Settings_Preference.scrollEnabled = YES;
        _toolbar.frame = CGRectMake(0, 387, 320, 48);
        Scrl_Settings_Preference.contentSize = CGSizeMake(320, 532);
        TFIn_view.frame=CGRectMake(215,6,77,37);

    }
    else{
        _toolbar.frame = CGRectMake(0, 239, 480, 48);
        Scrl_Settings_Preference.scrollEnabled = YES;
        Scrl_Settings_Preference.contentSize = CGSizeMake(420, 460);
        TFIn_view.frame=CGRectMake(315,6,135,40);

    }
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 
    [self SetCustomNavBarFrame];
    [self CreatTFIn_view];

}

-(void)dealloc{
    [Vw_Settings release];
    [Vw_Preference release];
    [Vw_Contact_Preferences release];
    [CurrentLocation_Yes release];
    [CurrentLocation_No release];
    [ShowsResultIn_Mls release];
    [ShowsResultIn_Km release];
    [Txt_NumberOfPubs release];
    [SaveInCache_Yes release];
    [SaveInCache_No release];
    [ShowResultIn_Map release];
    [ShowResultIn_List release];
    [Scrl_Settings_Preference release];
    [Btn_Continue release];
    [TFIn_view release];
    [table_mypreference release];
    [super dealloc];

}

#pragma mark Design_Settings
-(void)ManupulateSettingsView{
    @try {
        Vw_Settings.layer.cornerRadius = 8;
        
        
        if (GET_DEFAUL_VALUE(ShowNumberOfPubs) != nil) {
            Txt_NumberOfPubs.text = GET_DEFAUL_VALUE(ShowNumberOfPubs);
        }
        if (GET_DEFAUL_VALUE(CurrentLocation) != nil) {
            if ([GET_DEFAUL_VALUE(CurrentLocation) isEqualToString:@"YES"]) {
                [CurrentLocation_Yes setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
                [CurrentLocation_No setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(CurrentLocation) isEqualToString:@"NO"]) {
                [CurrentLocation_Yes setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
                [CurrentLocation_No setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
            } 
        }
        if (GET_DEFAUL_VALUE(ShowsResultIN) != nil) {
            if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"MLS"]) {
                [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
                
                [ShowsResultIn_Km setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"]) {
                [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
                [ShowsResultIn_Km setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
                
            }
        }
        if (GET_DEFAUL_VALUE(SaveCacheToSeeHistory) != nil) {
            if ([GET_DEFAUL_VALUE(SaveCacheToSeeHistory) isEqualToString:@"YES"]) {
                [SaveInCache_Yes setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];              
                [SaveInCache_No setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(SaveCacheToSeeHistory) isEqualToString:@"NO"]) {
                [SaveInCache_Yes setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
                [SaveInCache_No setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
                
            }
        }
        if (GET_DEFAUL_VALUE(PubsShowsIn) != nil) {
            if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
                [ShowResultIn_List setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];              
                
                [ShowResultIn_Map setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"MAP"]) {
                [ShowResultIn_List setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
                [ShowResultIn_Map setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

#pragma mark Design_Preferences
-(void)ManupulatePreferenceView{
    @try {
        //Main View
        Vw_Preference.layer.cornerRadius = 8;
        
        //Contacts View
        Vw_Contact_Preferences.layer.borderWidth = 2.0f;
        Vw_Contact_Preferences.layer.borderColor = [UIColor lightGrayColor].CGColor;
        Vw_Contact_Preferences.layer.cornerRadius = 6.0;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}
#pragma mark -


#pragma mark Button Action
#pragma mark Settings
- (IBAction)SetCurrentLocation:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == CurreentLocation_Yes_Tag) {
        SAVE_AS_DEFAULT(CurrentLocation, @"YES");
        [CurrentLocation_Yes setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
        [CurrentLocation_No setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
        
    }
    else if(btn.tag == CurreentLocation_No_Tag){
        SAVE_AS_DEFAULT(CurrentLocation, @"NO");
        [CurrentLocation_Yes setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
        [CurrentLocation_No setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SettoShowResult:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == ShowsResultIn_Mls_Tag) {
        SAVE_AS_DEFAULT(ShowsResultIN, @"MLS");
        [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
        [ShowsResultIn_Km setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
        
    }
    else if(btn.tag == ShowsResultIn_Km_Tag){
        SAVE_AS_DEFAULT(ShowsResultIN, @"KM");
        [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];      
        [ShowsResultIn_Km setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
        
    }
}

- (IBAction)SetToSaveHistory:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == SaveInHistory_Yes_Tag) {
        SAVE_AS_DEFAULT(SaveCacheToSeeHistory,@"YES");
        [SaveInCache_Yes setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];              
        [SaveInCache_No setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
    }
    else if(btn.tag == SaveInHistory_NO_Tag){
        SAVE_AS_DEFAULT(SaveCacheToSeeHistory,@"NO");
        [SaveInCache_Yes setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
        [SaveInCache_No setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SetPubsShowsIn:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == PubsShowsIn_List_Tag) {
        SAVE_AS_DEFAULT(PubsShowsIn,@"LIST");
        [ShowResultIn_List setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];              
        
        [ShowResultIn_Map setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
    }
    else if(btn.tag == PubsShowsIn_Map_Tag){
        SAVE_AS_DEFAULT(PubsShowsIn,@"MAP");
        [ShowResultIn_List setImage:[UIImage imageNamed:@"Box2Deselect.png"] forState: UIControlStateNormal];
        [ShowResultIn_Map setImage:[UIImage imageNamed:@"Box2Select.png"] forState: UIControlStateNormal];
        
    }
}

- (IBAction)ContinueToApp_Click:(id)sender {
    // push into home
}

- (IBAction)TapOnRecVenuesBtn:(id)sender {
}

- (IBAction)TapOnMyAlertyBtn:(id)sender {
}

- (IBAction)TapOnMyFavBtn:(id)sender {
    
    PreferenceDetailsViewController *obj_MyFav=[[PreferenceDetailsViewController alloc]initWithNibName:[Constant GetNibName:@"PreferenceDetailsViewController"] bundle:nil];
    [self.navigationController pushViewController:obj_MyFav animated:YES];
    [obj_MyFav release];
}


#pragma mark -


#pragma mark TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%d",[textField.text intValue]);
    NSInteger theInteger = [textField.text intValue];
    BOOL MatchFound;
    for (int i = 1; i < 21; i++) {
        if (i == theInteger) {
            MatchFound = YES;
            break;
        }
        else
            MatchFound = NO;
    }
    
    if (MatchFound) {
        SAVE_AS_DEFAULT(ShowNumberOfPubs,textField.text);
    }
    else{
        Txt_NumberOfPubs.text = GET_DEFAUL_VALUE(ShowNumberOfPubs);
        UIAlertView *alrt_lessthan = [[UIAlertView alloc]initWithTitle:@"Pubandbar" message:@"You can enter maximum 20." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alrt_lessthan show];
        [alrt_lessthan release];
    }
    [textField resignFirstResponder];
    return YES;
}







@end
