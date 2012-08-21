//
//  AmenitiesDetails.m
//  PubAndBar
//
//  Created by Subhra Da on 24/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "AmenitiesDetails.h"
#import "PubList.h"
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"

@implementation AmenitiesDetails

@synthesize table_catagory;
@synthesize lbl_heading;
@synthesize catagoryArray;
@synthesize Name;
@synthesize backButton;
@synthesize hud = _hud;

@synthesize searchRadius;

@synthesize oAuthLoginView;

int k;
UIInterfaceOrientation orientation;
AppDelegate *delegate ;
NSString *AmenityID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str1
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

#pragma  mark-
#pragma  mark- View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.eventTextLbl.text=Name;

    
    NSLog(@"RADIUS   %@",searchRadius );
    toolBar = [[Toolbar alloc]init];
   // toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    if([Name isEqualToString:@"Facilities"]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[AmenitiesInfo GetAmmenity_NameInfo:1 radius:searchRadius ] retain];            
    }
    else if([Name isEqualToString:@"Style(s)" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[AmenitiesInfo GetAmmenity_NameInfo:2 radius:searchRadius]retain]; 
        NSLog(@"ARRAy   %@",catagoryArray);
    }
    else if([Name isEqualToString:@"Features" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[AmenitiesInfo GetAmmenity_NameInfo:3 radius:searchRadius]retain]; 
    }
       [self CreateView];
    if ([catagoryArray count]==0) {
        
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
      delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    //delegate.ismore=NO;
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
     [self AddNotification];
}


-(void)AddNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInTwitter:)name:@"Twitter"  object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInGooglePlus:)name:@"GooglePlus"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInLinkedin:)name:@"Linkedin"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInFacebook:)name:@"Facebook"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInMessage:)name:@"Message"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Settings:)name:@"Settings"  object:nil];
    
}
#pragma  mark-
#pragma mark- share

- (void)ShareInTwitter:(NSNotification *)notification {
    TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    
    if([Name isEqualToString:@"Facilities"]){
     obj.textString=[NSString stringWithFormat: @"Pubs and Bars providing Facilities http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Style(s)"]){
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars providing Styles http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Features"]){
        obj.textString=[NSString stringWithFormat: @"Pubs and Bars providing Featues http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    
   
    
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
    MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc]init] ;
    NSString *textString;
    
    if([Name isEqualToString:@"Facilities"]){
        textString=[NSString stringWithFormat: @"Pubs and Bars providing Facilities http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Style(s)"]){
        textString=[NSString stringWithFormat: @"Pubs and Bars providing Styles http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Features"]){
        textString=[NSString stringWithFormat: @"Pubs and Bars providing Featues http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }

    
    
    
     [mailController setMessageBody:[NSString stringWithFormat:@"%@",textString] isHTML:NO];
    
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
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
    MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
    [obj_MyProfileSetting release];
}

- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    if([Name isEqualToString:@"Facilities"]){
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars providing Facilities http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Style(s)"]){
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars providing Styles http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Features"]){
        obj.shareText=[NSString stringWithFormat: @"Pubs and Bars providing Featues http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    

    
    
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
    
    NSString *fb_str;
    
    
    if([Name isEqualToString:@"Facilities"]){
        fb_str=[NSString stringWithFormat: @"Pubs and Bars providing Facilities http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Style(s)"]){
        fb_str=[NSString stringWithFormat: @"Pubs and Bars providing Styles http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    else if([Name isEqualToString:@"Features"]){
        fb_str=[NSString stringWithFormat: @"Pubs and Bars providing Featues http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
    }
    

    

    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = [NSString stringWithFormat:@"%@",fb_str];
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
    
    NSString *fb_str;
   
        
        fb_str=[NSString stringWithFormat: @"http://www.pubandbar-network.co.uk/viewpubs-bars.html"];
        
   
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     fb_str,@"message",
     //  @"Want to share through Greetings", @"description",
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

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setCatagoryViewFrame];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
    }
    return YES;
}


#pragma  Mark-
#pragma  Mark- AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
        [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark-
#pragma  mark-  CreateView

-(void)CreateView{
     SearchBtn=[[UIButton alloc]init];
    //SearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[SearchBtn setFrame:CGRectMake(250, 350, 70, 30)];
    [SearchBtn setBackgroundColor:[UIColor clearColor]];
    [SearchBtn addTarget:self action:@selector(GoTOPubList:) forControlEvents:UIControlEventTouchUpInside];
    [SearchBtn setImage:[UIImage imageNamed:@"SendDeselect.png"] forState:UIControlStateNormal];
    [SearchBtn setImage:[UIImage imageNamed:@"SendSelect.png"] forState:UIControlStateHighlighted];
    //SearchBtn.titleLabel.font=[UIFont boldSystemFontOfSize:13];
    SearchBtn.layer.cornerRadius=7.0;
    [self.view addSubview:SearchBtn];
    
//    table_catagory = [[UITableView alloc]init];
//   
//    
//    table_catagory.dataSource=self;
//    table_catagory.delegate=self;
//    table_catagory.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
//    table_catagory.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    pickerDistenceWheel = [[UIPickerView alloc]init];
    pickerDistenceWheel.delegate = self;
    pickerDistenceWheel.dataSource = self;
    pickerDistenceWheel.showsSelectionIndicator=YES;

    lbl_heading = [[UILabel alloc]init];
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.font = [UIFont boldSystemFontOfSize:13];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    lbl_heading.text = Name;
    lbl_heading.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];  
    
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:lbl_heading];
    //[self.view addSubview:table_catagory];
     [self.view addSubview:pickerDistenceWheel];
    //[lbl_heading release];
    [backButton release];
}



#pragma  mark-
#pragma  mark-  setCatagoryViewFrame

-(void)setCatagoryViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    //--------------------------mb-02-06-12-----------------------------------//
    else{
        if ([Constant isPotrait:self]) {
            
            //table_catagory.frame=CGRectMake(0, 130, 320, 252);
            lbl_heading.frame = CGRectMake(100, 89, 120, 30);
            backButton.frame = CGRectMake(8, 90, 50, 25);
            //[SearchBtn setFrame:CGRectMake(240, 379, 70, 30)];
            SearchBtn.frame = CGRectMake(265,379, 45, 23);
            if (delegate.ismore==YES) {
               // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
               // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            pickerDistenceWheel.frame = CGRectMake(10, 144, 300, 300);
           
                      
         
        }
        
        else{
             pickerDistenceWheel.frame = CGRectMake(80, 95, 150, 90);
            //table_catagory.frame=CGRectMake(0, 120, 480, 100);
            lbl_heading.frame = CGRectMake(180, 76, 120, 20); 
            backButton.frame = CGRectMake(20, 85, 50, 25);
            //[SearchBtn setFrame:CGRectMake(400, 225, 70, 30)];
            SearchBtn.frame = CGRectMake(350, 230, 40, 20);
            if (delegate.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(10, 261, 460, 53);
            }

         pickerDistenceWheel.frame = CGRectMake(140, 94, 200, 40);
        }
    }
    //---------------------------------------------------------------------------//
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [catagoryArray count];
}
/*
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    return [catagoryArray objectAtIndex:row];
}
*/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     //[AmmenitiesArray addObject:[NSString stringWithFormat:@"%d",[[[catagoryArray objectAtIndex:row]valueForKey:@"Ammenity_TypeID"]intValue]]];
    AmenityID = [NSString stringWithFormat:@"%d",[[[catagoryArray objectAtIndex:row]valueForKey:@"Ammenity_TypeID"]intValue]];
  /*  if(row != 0)
		Row_number = row;*/
    
}
//////////////////JHUMA///////////////////////////////////

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = [NSString stringWithFormat:@"%@",[[catagoryArray objectAtIndex:row]valueForKey:@"Facility_Name"]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [label autorelease];
    return label;
}


//#pragma  mark-
//#pragma  mark- tableview datasource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	NSLog(@"ArrayCount   %d",[catagoryArray count]);
//    NSLog(@"catagoryArray  %@",catagoryArray);
//    k=(([catagoryArray count]%3==0)?([catagoryArray count]/3):([catagoryArray count]/3+1));
//    return k;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	return 44;	
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    const NSInteger FIRST_LABEL_TAG = 1001;
//    const NSInteger SECOND_LABEL_TAG = 1002;
//    const NSInteger THIRD_LABEL_TAG = 1003;
//
//    
//    UILabel *firstLbl;
//    UILabel *secondLbl;
//    UILabel *thirdLbl;
//    UIButton *firstBtn;
//    UIButton *secondBtn;
//    UIButton *thirdBtn;
//    
//    static NSString *CellIdentifier = @"Cell";
//	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//	if (cell == nil)
//	{
//        
//        cell =
//		[[UITableViewCell alloc]
//         initWithStyle:UITableViewCellStyleDefault
//         reuseIdentifier:CellIdentifier]
//        ;
//		//---------------------------------------mb-02-06-12-------------------------------------//
//        UIView *vw = [[[UIView alloc]init]autorelease];
//        vw.frame =CGRectMake(0, 7, 320, 37);
//        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
//        [cell.contentView addSubview:vw];
//        
//		firstLbl =[[[UILabel alloc]init]autorelease];
//        firstLbl.frame =CGRectMake(5,2,90,33);
//		firstLbl.tag = FIRST_LABEL_TAG;
//		firstLbl.backgroundColor = [UIColor clearColor];
//		firstLbl.textColor = [UIColor whiteColor];
//		firstLbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
//		firstLbl.font = [UIFont boldSystemFontOfSize:13];
//        firstLbl.lineBreakMode = UILineBreakModeWordWrap;
//        firstLbl.numberOfLines = 2;
//        firstLbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        [vw addSubview:firstLbl];
//        
//        secondLbl =[[[UILabel alloc]init]autorelease];
//        secondLbl.frame =CGRectMake(110,2,90,33);
//		secondLbl.tag = SECOND_LABEL_TAG;
//		secondLbl.backgroundColor = [UIColor clearColor];
//		secondLbl.textColor = [UIColor whiteColor];
//		secondLbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
//		secondLbl.font = [UIFont boldSystemFontOfSize:13];
//        secondLbl.lineBreakMode = UILineBreakModeWordWrap;
//        secondLbl.numberOfLines = 2;
//        secondLbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        [vw addSubview:secondLbl];
//        
//        
//        thirdLbl =[[[UILabel alloc]init]autorelease];
//        thirdLbl.frame =CGRectMake(215,2,90,33);
//		thirdLbl.tag = THIRD_LABEL_TAG;
//		thirdLbl.backgroundColor = [UIColor clearColor];
//		thirdLbl.textColor = [UIColor whiteColor];
//		thirdLbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
//		thirdLbl.font = [UIFont boldSystemFontOfSize:13];
//        thirdLbl.lineBreakMode = UILineBreakModeWordWrap;
//        thirdLbl.numberOfLines = 2;
//        thirdLbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        [vw addSubview:thirdLbl];
//        
//        firstBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [firstBtn setFrame:CGRectMake(97, 13, 10, 10)];
//        [firstBtn setBackgroundColor:[UIColor whiteColor]];
//        firstBtn.selected=NO;
//        if(r<[catagoryArray count])
//            firstBtn.tag=[[[catagoryArray objectAtIndex:r]valueForKey:@"Ammenity_TypeID"]intValue];
//        else
//            firstBtn.hidden=YES;
//        [firstBtn addTarget:self action:@selector(SElectTypeOFAmmenities:) forControlEvents:UIControlEventTouchUpInside];
//        firstBtn.layer.cornerRadius=9.0;
//        firstBtn.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        [vw addSubview:firstBtn];
//        
//        
//        secondBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [secondBtn setFrame:CGRectMake(202, 13, 10, 10)];
//        secondBtn.selected=NO;
//        [secondBtn addTarget:self action:@selector(SElectTypeOFAmmenities:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [secondBtn setBackgroundColor:[UIColor whiteColor]];
//        secondBtn.layer.cornerRadius=9.0;
//        if(r+1<[catagoryArray count])
//            secondBtn.tag=[[[catagoryArray objectAtIndex:r+1]valueForKey:@"Ammenity_TypeID"]intValue];
//        else
//            secondBtn.hidden=YES;
//        secondBtn.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        [vw addSubview:secondBtn];
//        
//        
//        thirdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [thirdBtn setFrame:CGRectMake(307, 13, 10, 10)];
//        [thirdBtn setBackgroundColor:[UIColor whiteColor]];
//        thirdBtn.selected=NO;
//        [thirdBtn addTarget:self action:@selector(SElectTypeOFAmmenities:) forControlEvents:UIControlEventTouchUpInside];
//        
//        if(r+2<[catagoryArray count])
//            thirdBtn.tag=[[[catagoryArray objectAtIndex:r+2]valueForKey:@"Ammenity_TypeID"]intValue];
//        else
//            thirdBtn.hidden=YES;
//        thirdBtn.layer.cornerRadius=9.0;
//        thirdBtn.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
//        [vw addSubview:thirdBtn];
//        //------------------------------------------------------------------------------------//
//        
//        
//    }
//    else{
//        firstLbl = (UILabel *)[cell viewWithTag:FIRST_LABEL_TAG];
//        secondLbl = (UILabel *)[cell viewWithTag:SECOND_LABEL_TAG];
//        thirdLbl=(UILabel *)[cell viewWithTag:THIRD_LABEL_TAG];
//        
//        if(r+1<[catagoryArray count])
//            firstBtn=(UIButton *)[cell viewWithTag:[[[catagoryArray objectAtIndex:r]valueForKey:@"Ammenity_TypeID"]intValue]];
//         if(r+1<[catagoryArray count])
//             secondBtn=(UIButton *)[cell viewWithTag:[[[catagoryArray objectAtIndex:r+1]valueForKey:@"Ammenity_TypeID"]intValue]];
//        if(r+2<[catagoryArray count])
//            thirdBtn=(UIButton *)[cell viewWithTag:[[[catagoryArray objectAtIndex:r+2]valueForKey:@"Ammenity_TypeID"]intValue]];
//        
//        
//        
//    }
//    @try {
//        if(r<[catagoryArray count])
//        firstLbl.text=[[catagoryArray objectAtIndex:r]valueForKey:@"Facility_Name"];
//        if(r+1<[catagoryArray count])
//            secondLbl.text=[[catagoryArray objectAtIndex:r+1]valueForKey:@"Facility_Name"];
//        if(r+2<[catagoryArray count])
//            thirdLbl.text=[[catagoryArray objectAtIndex:r+2]valueForKey:@"Facility_Name"];
//        r=r+3;
//    }
//    @catch (NSException *exception) {
//        NSLog(@"%@",exception);
//    }
//    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
//    
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    return cell;
//    
//}
#pragma  mark-
#pragma  mark- button action
-(IBAction)SElectTypeOFAmmenities:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"tag %d",btn.tag);
   
    if(!btn.selected)
    {
        btn.backgroundColor=[UIColor blueColor];
        btn.selected=YES;
        [AmmenitiesArray addObject:[NSString stringWithFormat:@"%d", btn.tag]];

    }
    else
    {
        btn.selected=NO;
        btn.backgroundColor=[UIColor whiteColor];
        [AmmenitiesArray removeObject:[NSString stringWithFormat:@"%d", btn.tag]];
    }
}

-(IBAction)GoTOPubList:(id)sender
{
    AmmenitiesArray =[[NSMutableArray alloc]init];

    [AmmenitiesArray addObject:[NSString stringWithFormat:@"%@",[[catagoryArray objectAtIndex:[pickerDistenceWheel selectedRowInComponent:0]]valueForKey:@"Ammenity_TypeID"]]];
    
    
    
    
    NSLog(@"AmmenitiesArray  %@",AmmenitiesArray);
    
    PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
    obj.searchRadius = searchRadius;
    obj.categoryArray=AmmenitiesArray;
    obj.eventID=[NSString stringWithFormat:@"%@",[[catagoryArray objectAtIndex:[pickerDistenceWheel selectedRowInComponent:0]]valueForKey:@"Ammenity_TypeID"]];
    
    obj.eventName=[NSString stringWithFormat:@"%@",[[catagoryArray objectAtIndex:[pickerDistenceWheel selectedRowInComponent:0]]valueForKey:@"Facility_Name"]];
    
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];
    [AmmenitiesArray release];

}

-(IBAction)ClickBack:(id)sender{
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark -
#pragma  mark - Memory Cleanup

-(void)dealloc{
    //[table_catagory release];
    [catagoryArray release];
   // [toolBar release];
    [searchRadius release];
    [pickerDistenceWheel release];
    [SearchBtn release];
    [Name release];
    [super dealloc];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //self.table_catagory=nil;
    self.catagoryArray = nil;
}

@end
