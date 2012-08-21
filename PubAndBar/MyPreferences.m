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
#import "Home.h"
#import "SavePreferenceInfo.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"

#define CurreentLocation_Yes_Tag  1
#define CurreentLocation_No_Tag   2
#define ShowsResultIn_Mls_Tag     3
#define ShowsResultIn_Km_Tag      4
#define SaveInHistory_Yes_Tag     5
#define SaveInHistory_NO_Tag      6
#define PubsShowsIn_List_Tag      7
#define PubsShowsIn_Map_Tag       8


@implementation MyPreferences
@synthesize title_img;
@synthesize table_mypreference;
@synthesize btn_continue;
@synthesize vw_socialnetwrk;
@synthesize isChecked;
@synthesize oAuthLoginView;
@synthesize btn_Yourideas;
//@synthesize btn_Email;
@synthesize btn_Phone;
//@synthesize backButton;
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
UIInterfaceOrientation orientation;

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
    self.eventTextLbl.text=nil;
    self.statuslbl.text=nil;
    self.btn_licenselogin.titleLabel.text=nil;
    self.bar_vw.hidden=YES;
    TFIn_view = [[UIImageView alloc]init];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackBackGround.png"]];
    
    Vw_Settings.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackGround.png"]];
    img1=[[UIImageView alloc]init];
    img1.backgroundColor=[UIColor lightGrayColor];
    img1.alpha=0.3;
    [Vw_Settings addSubview:img1];
    
    ShowResultIn_Map.tag=8;
    ShowResultIn_List.tag=7;
   // [ShowsResultIn_Mls setBackgroundColor:[UIColor redColor]];
    //[ShowsResultIn_Km setBackgroundColor:[UIColor yellowColor]];
    //------------------------------mb-28-05-12--------------------------//
    
    //-------------------------------------------------------------------//
    
    [self ManupulateSettingsView];
    [self ManupulatePreferenceView];
   // Scrl_Settings_Preference.frame = CGRectMake(0, 0, 320, 440);
   
    
   
    _toolbar = [[Toolbar alloc] init];
    //_toolbar.layer.borderWidth = 1.0f;
    _toolbar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_toolbar];
   // [self CreatTFIn_view];

    Vw_Contact_Preferences.frame=CGRectMake(8, 435, 302, 62);
      Scrl_Settings_Preference.layer.cornerRadius=9.0;
}
/*
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

*/

-(IBAction)ClickBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)ClickReviewApp:(id)sender
{
   
    [Appirater userDidSignificantEvent:YES];
    //[Appirater appEnteredForeground:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [backbutton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backbutton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    
    [self AddNotification];
    
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
    [self setTitle_img:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    table_mypreference= nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        if (app.ismore==YES) {
            //toolBar.frame = CGRectMake(-320, 387, 640, 48);
            _toolbar.frame = CGRectMake(8.5, 421, 303, 53);
        }
        else{
            //toolBar.frame = CGRectMake(0, 387, 640, 48);
            _toolbar.frame = CGRectMake(8.5, 421, 303, 53);
        }
               _toolbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
        Vw_Settings.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackGround.png"]];
        
       // Scrl_Settings_Preference.scrollEnabled=NO;
        backbutton.frame=CGRectMake(8, 89, 50, 25);
        Scrl_Settings_Preference.frame=CGRectMake(10, 150, 300, 256);
        title_img.frame=CGRectMake(99, 111, 122, 24);
        btn_reviewApp.frame=CGRectMake(42, 207, 223, 34);
         btn_reviewApp.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ReviewDeselect.png"]]; 
        
         lbl1.frame=CGRectMake(7, 12, 195, 18);
         lbl2.frame=CGRectMake(7, 48, 84, 16);
         lbl3.frame=CGRectMake(7, 78, 166, 14);
         lbl4.frame=CGRectMake(7, 108, 174, 16);
         lbl5.frame=CGRectMake(7, 138, 117, 17);
        
         lbl10.frame=CGRectMake(209, 18, 21, 12);
         lbl11.frame=CGRectMake(251, 14, 14, 21);
         lbl12.frame=CGRectMake(208, 48, 22, 16);
         lbl13.frame=CGRectMake(251, 48, 16, 16);
         lbl14.frame=CGRectMake(208, 110, 21, 12);
         lbl15.frame=CGRectMake(251, 106, 14, 21);
         lbl16.frame=CGRectMake(208, 145, 21, 12);
         lbl17.frame=CGRectMake(251, 140, 20, 21);
        
        CurrentLocation_Yes.frame=CGRectMake(228, 18, 19, 13);
        CurrentLocation_No.frame=CGRectMake(273, 18, 19, 13);
        ShowsResultIn_Mls.frame=CGRectMake(228, 51, 19, 13);
        ShowsResultIn_Km.frame=CGRectMake(273, 51, 19, 13);
        Txt_NumberOfPubs.frame=CGRectMake(208, 78, 32, 15);
        SaveInCache_Yes.frame=CGRectMake(228, 110, 19, 13);
        SaveInCache_No.frame=CGRectMake(273, 110, 19, 13);
        ShowResultIn_Map.frame=CGRectMake(273, 144, 19, 13);
        ShowResultIn_List.frame=CGRectMake(228, 140, 20, 21);//(273, 144, 19, 13);
        
        img1.hidden=YES;

        Vw_Settings.frame=CGRectMake(0, 0, 300, 256);
        Scrl_Settings_Preference.scrollEnabled=YES;
        Scrl_Settings_Preference.contentSize=CGSizeMake(300, 320);
        
        
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        if (app.ismore==YES) {
            // toolBar.frame = CGRectMake(-320, 387, 640, 48);
            _toolbar.frame = CGRectMake(8.5, 261, 463, 53);
        }
        else{
            // toolBar.frame = CGRectMake(0, 387, 640, 48);
            _toolbar.frame = CGRectMake(8.5, 261, 463, 53);
        }
        img1.hidden=NO;
        img1.frame=CGRectMake(10, 38, 439, 1);

        _toolbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
         
         Vw_Settings.frame=CGRectMake(0, 0, 460, 256);
        Vw_Settings.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"WhiteBackGroundL.png"]];
         
        backbutton.frame=CGRectMake(12, 85, 50, 25);
        Scrl_Settings_Preference.frame=CGRectMake(10, 147, 460, 110);
        Scrl_Settings_Preference.contentSize=CGSizeMake(460, 320);
        Scrl_Settings_Preference.scrollEnabled=YES;
        title_img.frame=CGRectMake(169, 109, 122, 24);
        title_img.image=[UIImage imageNamed:@"MySettingL.png"];
         btn_reviewApp.frame=CGRectMake(95.5, 207, 269, 35);
        btn_reviewApp.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"ReviewDeselectL.png"]];
        
      
       // Vw_Settings.frame=CGRectMake(0, 0, 460, 256);
        lbl1.frame=CGRectMake(17, 12, 195, 18);
        lbl2.frame=CGRectMake(17, 48, 84, 16);
        lbl3.frame=CGRectMake(17, 78, 166, 14);
        lbl4.frame=CGRectMake(17, 108, 174, 16);
        lbl5.frame=CGRectMake(17, 138, 117, 17);
        
        lbl10.frame=CGRectMake(289, 18, 21, 12);
        lbl11.frame=CGRectMake(331, 14, 14, 21);
        lbl12.frame=CGRectMake(288, 48, 22, 16);
        lbl13.frame=CGRectMake(331, 48, 16, 16);
        lbl14.frame=CGRectMake(288, 110, 21, 12);
        lbl15.frame=CGRectMake(331, 106, 14, 21);
        lbl16.frame=CGRectMake(288, 145, 21, 12);
        lbl17.frame=CGRectMake(331, 140, 20, 21);
        
        CurrentLocation_Yes.frame=CGRectMake(308, 18, 19, 13);
        CurrentLocation_No.frame=CGRectMake(353, 18, 19, 13);
        ShowsResultIn_Mls.frame=CGRectMake(308, 51, 19, 13);
        ShowsResultIn_Km.frame=CGRectMake(353, 51, 19, 13);
        Txt_NumberOfPubs.frame=CGRectMake(288, 78, 32, 15);
        SaveInCache_Yes.frame=CGRectMake(308, 110, 19, 13);
        SaveInCache_No.frame=CGRectMake(353, 110, 19, 13);
        ShowResultIn_Map.frame=CGRectMake(353, 144, 19, 13);
        ShowResultIn_List.frame=CGRectMake(308, 140, 20, 21);//(353, 144, 19, 13);
        

    }
    return YES;

    
    
        

}

-(IBAction)ClickToCall:(id)sender{
    
    
    NSString *PhoneNo=@"01212885485";
    
   
    NSLog(@"%@",PhoneNo);
        
    NSString *telephno=[NSString stringWithFormat:@"tel://%@",PhoneNo];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telephno]]; 
       
        
    
}

-(IBAction)ClickEmail:(id)sender{
    
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
                      
                [self displayEmailComposerSheet];
          
        }
        else 
        {        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
            
        }
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }

    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 
    [self SetCustomNavBarFrame];
    //[self CreatTFIn_view];

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
    [title_img release];
    [lbl1 release];
    [lbl2 release];
    [lbl3 release];
    [lbl4 release];
    
    [lbl10 release];
    [lbl11 release];
    [lbl12 release];
    [lbl13 release];
    [lbl14 release];
    [lbl15 release];
    [lbl16 release];
    [lbl17 release];
    [super dealloc];

}


#pragma  mark-
#pragma  mark- toolbar 
-(void)AddNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInTwitter:)name:@"Twitter"  object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInGooglePlus:)name:@"GooglePlus"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInLinkedin:)name:@"Linkedin"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInFacebook:)name:@"Facebook"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInMessage:)name:@"Message"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Settings:)name:@"Settings"  object:nil];
    
}

- (void)ShareInTwitter:(NSNotification *)notification {
    TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    
    obj.textString = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}            



- (void)ShareInGooglePlus:(NSNotification *)notification {
    GooglePlusViewController *obj = [[GooglePlusViewController alloc] initWithNibName:@"GooglePlusViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [obj release];;
}


- (void)ShareInMessage:(NSNotification *)notification {
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
            [self displayEmailComposerSheet];
        }
        else 
        {        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
            
        }
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }
    
}
-(void)displayEmailComposerSheet
{
     mailController = [[MFMailComposeViewController alloc]init] ;
    
    [mailController setToRecipients:[NSArray arrayWithObject:@"info@pubandbar.network.co.uk"]];
    
   [mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"Pub & bar Network"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

#pragma mark EmailComposer Delegate-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)Settings:(NSNotification *)notification {
    /*MyPreferences *obj_mypreferences=[[MyPreferences alloc]initWithNibName:[Constant GetNibName:@"MyPreferences"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_mypreferences animated:YES];
    [obj_mypreferences release];*/
}


- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
    
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [oAuthLoginView release];
    oAuthLoginView = nil;
}

- (void)ShareInFacebook:(NSNotification *)notification {
    
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}

-(void) FBLoginDone:(id)objectDictionay
{
    [self wallPosting];
}
-(void) wallPosting
{
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     //@"Want to share through Greetings", @"description",
     @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8",@"message",
     @"https://m.facebook.com/apps/Greetings/", @"link",
     //@"http://fbrell.com/f8.jpg", @"picture",
     nil];  
    [[FacebookController sharedInstance].facebook dialog:@"feed"
                                               andParams:params
                                             andDelegate:self];    
    
}

-(void) fbDidLogin
{
    //NSLog(@"TOKEn  fbDidLogin %@",[facebook accessToken]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self wallPosting];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    // barButton.enabled = YES;
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error{
	
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Error Occurred!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
	
	if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
		//NSLog(@"URL  %@",url);			//alert user of successful post
		
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Message Posted Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		myAlert.tag = 6;
		[myAlert show];
		[myAlert release];
        
    }
    
}

- (void)dialogDidNotCompleteWithUrl:(NSURL *)url{
	
	//NSLog(@"URL  %@",url);
    
}

-(void) dialogDidComplete:(FBDialog *)dialog{
    
    
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	//NSLog(@"did not login");
}

- (void) fbDidLogout {
	// Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
}                        


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Twitter" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GooglePlus" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Linkedin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Facebook" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Message" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Settings" object:nil];
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
                [CurrentLocation_Yes setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
                [CurrentLocation_No setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(CurrentLocation) isEqualToString:@"NO"]) {
                [CurrentLocation_Yes setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
                [CurrentLocation_No setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
            } 
        }
        if (GET_DEFAUL_VALUE(ShowsResultIN) != nil) {
            if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"Miles"]) {
                [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
                
                [ShowsResultIn_Km setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"]) {
                [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
                [ShowsResultIn_Km setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
                
            }
        }
        if (GET_DEFAUL_VALUE(SaveCacheToSeeHistory) != nil) {
            if ([GET_DEFAUL_VALUE(SaveCacheToSeeHistory) isEqualToString:@"YES"]) {
                [SaveInCache_Yes setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];              
                [SaveInCache_No setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(SaveCacheToSeeHistory) isEqualToString:@"NO"]) {
                [SaveInCache_Yes setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
                [SaveInCache_No setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
                
            }
        }
        if (GET_DEFAUL_VALUE(PubsShowsIn) != nil) {
            if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
                [ShowResultIn_List setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];              
                
                [ShowResultIn_Map setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
            }
            else if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"MAP"]) {
                [ShowResultIn_List setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
                [ShowResultIn_Map setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
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
       // Vw_Contact_Preferences.layer.borderWidth = 2.0f;
       // Vw_Contact_Preferences.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
        app.IscurrentLocation=YES;
        [CurrentLocation_Yes setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
        [CurrentLocation_No setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
        
    }
    else if(btn.tag == CurreentLocation_No_Tag){
        SAVE_AS_DEFAULT(CurrentLocation, @"NO");
        app.IscurrentLocation=NO;
        [CurrentLocation_Yes setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
        [CurrentLocation_No setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SettoShowResult:(id)sender {
    UIButton *btn = (UIButton*)sender;
    
     NSLog(@"tag  %d",btn.tag);
    if (btn.tag == ShowsResultIn_Mls_Tag) {
        SAVE_AS_DEFAULT(ShowsResultIN, @"Miles");
        [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
        [ShowsResultIn_Km setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
        
    }
    else if(btn.tag == ShowsResultIn_Km_Tag){
        SAVE_AS_DEFAULT(ShowsResultIN, @"KM");
        [ShowsResultIn_Mls setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];      
        [ShowsResultIn_Km setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
        
    }
}

- (IBAction)SetToSaveHistory:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == SaveInHistory_Yes_Tag) {
        SAVE_AS_DEFAULT(SaveCacheToSeeHistory,@"YES");
        [SaveInCache_Yes setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];              
        [SaveInCache_No setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
    }
    else if(btn.tag == SaveInHistory_NO_Tag){
        SAVE_AS_DEFAULT(SaveCacheToSeeHistory,@"NO");
        [SaveInCache_Yes setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
        [SaveInCache_No setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SetPubsShowsIn:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSLog(@"tag  %d",btn.tag);
    if (btn.tag == PubsShowsIn_List_Tag) {
        SAVE_AS_DEFAULT(PubsShowsIn,@"LIST");
        [ShowResultIn_List setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];              
        
        [ShowResultIn_Map setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
    }
    else if(btn.tag == PubsShowsIn_Map_Tag){
        SAVE_AS_DEFAULT(PubsShowsIn,@"MAP");
        [ShowResultIn_List setImage:[UIImage imageNamed:@"RadioDeselect.png"] forState: UIControlStateNormal];
        [ShowResultIn_Map setImage:[UIImage imageNamed:@"RadioSelect.png"] forState: UIControlStateNormal];
        
    }
}

- (IBAction)ContinueToApp_Click:(id)sender {
    //app.ismore=NO;
  NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    int def=[[sharedDefaults valueForKey:@"ApplicationRunning"]intValue];
    if (def!=1) {
        
        
     Home *viewController_home = [[[Home alloc] initWithNibName:[Constant GetNibName:@"Home"] bundle:nil] autorelease];
        [self.navigationController pushViewController:viewController_home animated:YES];
    }
    else
    {
       [self.navigationController popViewControllerAnimated:YES];
    }

    
    
    
}

- (IBAction)TapOnRecVenuesBtn:(id)sender {
}

- (IBAction)TapOnMyAlertyBtn:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/Visitor/"]]];
}

-(IBAction)Click_YourIdeas:(id)sender{
    
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
            [self displayEmailComposerSheet];
        }
        else 
        {        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
            
        }
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }

}

- (IBAction)TapOnMyFavBtn:(id)sender {
    
    PreferenceDetailsViewController *obj_MyFav=[[PreferenceDetailsViewController alloc]initWithNibName:[Constant GetNibName:@"PreferenceDetailsViewController"] bundle:nil];
    
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    arr=[[SavePreferenceInfo GetFavourites_DetailsInfo]retain];
    
    if ([arr count]==0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"You have not added any favourites." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else{
        [self.navigationController pushViewController:obj_MyFav animated:YES];
        [obj_MyFav release];
    }
    
}


#pragma mark -


#pragma mark TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%d",[textField.text intValue]);
    NSInteger theInteger = [textField.text intValue];
    BOOL MatchFound;
    for (int i = 1; i < 51; i++) {
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
        UIAlertView *alrt_lessthan = [[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"You can enter maximum 50." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alrt_lessthan show];
        [alrt_lessthan release];
    }
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"%d",[textField.text intValue]);
    NSInteger theInteger = [textField.text intValue];
    BOOL MatchFound;
    for (int i = 1; i < 51; i++) {
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
        UIAlertView *alrt_lessthan = [[UIAlertView alloc]initWithTitle:@"Pubandbar" message:@"You can enter maximum 50." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alrt_lessthan show];
        [alrt_lessthan release];
    }
    [textField resignFirstResponder];
    return YES;
}




@end
