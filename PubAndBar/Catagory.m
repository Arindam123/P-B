//
//  Catagory.m
//  PubAndBar
//
//  Created by User7 on 23/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Catagory.h"
#import "PubList.h"
#import "SportDetail.h"
#import "NearByMap.h"
#import <QuartzCore/QuartzCore.h>

//-------------------//
#import "AmenitiesDetails.h"
#import "iCodeOauthViewController.h"





@implementation Catagory
@synthesize table_catagory;
@synthesize lbl_heading;
@synthesize catagoryArray;
@synthesize Name;
@synthesize backButton;
@synthesize topLabel;
@synthesize nextImg;
@synthesize middlelbl;
@synthesize bottomlbl;
@synthesize endlbl;
@synthesize firstlbl;
@synthesize datelbl;
@synthesize temparray;
@synthesize eventID;
@synthesize dateString;
@synthesize searchRadius;
@synthesize searchUnit;

@synthesize  oAuthLoginView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil// withRadius:(NSString *)_str1
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
    
    NSLog(@"RADIUS   %@",searchRadius );
    
    self.eventTextLbl.text=Name;

    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    

    if([Name isEqualToString:@"Sports on TV"]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetSport_CatagoryNameInfo:searchRadius] retain];            
    }
    else if([Name isEqualToString:@"Food & Offers" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetFood_Type:searchRadius]retain]; 
        NSLog(@"catagoryArray   %@",catagoryArray);
    }
    else if([Name isEqualToString:@"Facilities" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetAmmenity_NameInfo]retain]; 
    }
    else if([Name isEqualToString:@"Regular"]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID]retain];  
    }
    else if([Name isEqualToString:@"One Off" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID]retain]; 
    }
    else if([Name isEqualToString:@"Theme Nights" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        catagoryArray = [[SaveCatagoryInfo GetEvent_DetailInfo:eventID]retain]; 
    }
    else if([Name isEqualToString:@"What's On Tonight..." ]){
        NSString *currentdate = [Constant GetCurrentDateTime];
        NSArray *arr_date_time = [currentdate componentsSeparatedByString:@" "];
        NSString *nightdaytime = [NSString stringWithFormat:@"%@235959",[arr_date_time objectAtIndex:0]];
        nightdaytime = [nightdaytime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        catagoryArray = [[NSMutableArray alloc]init];
        //catagoryArray = [[SaveCatagoryInfo GetPubDetailsInfo:dateString]retain];   
        catagoryArray = [[SaveCatagoryInfo getDateEvent:nightdaytime isfortonight:YES]retain];
        
    }
    else if([Name isEqualToString:@"What's On Next 7 Days" ]){
        catagoryArray = [[NSMutableArray alloc]init];
        //catagoryArray = [SaveCatagoryInfo GetPubDetailsInfo1]; 
        NSDate *today = [NSDate date];
        
        // All intervals taken from Google
        //NSDate *yesterday = [today dateByAddingTimeInterval: 86400.0];
        NSDate *thisWeek  = [today dateByAddingTimeInterval: 604800.0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        [dateFormat setLocale:[NSLocale currentLocale]];
        NSString *dateAftersevendays = [dateFormat stringFromDate:thisWeek];  
        dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@"-" withString:@""];
        dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@" " withString:@""];
        dateAftersevendays = [dateAftersevendays stringByReplacingOccurrencesOfString:@":" withString:@""];
        [dateFormat release];
        catagoryArray = [[SaveCatagoryInfo getDateEvent:dateAftersevendays isfortonight:NO] retain];
    }
    
    //-----------------------------------mb----------------------------//
    if ([catagoryArray count]==0) {
   
   
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No Data Found! Please Try Again......" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
       
    }
         [self CreateView];
    //----------------------------------------------------------------//
}

#pragma  Mark-
#pragma  Mark- AlertView Delegate
//--------------------------mb----------------------------------//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
         [self.navigationController popViewControllerAnimated:YES];
}
//------------------------------------------------------------//
-(void)CreateView{
    
   
    
    table_catagory = [[UITableView alloc]init];
    //table_catagory.frame=CGRectMake(0, 44, 320, 315);
    //table_catagory.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
    table_catagory.delegate=self;
    table_catagory.dataSource=self;
    table_catagory.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_catagory.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    datelbl = [[UILabel alloc]init];
    datelbl.textColor = [UIColor whiteColor];
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.font = [UIFont boldSystemFontOfSize:9];
    
    lbl_heading = [[UILabel alloc]init];
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.font = [UIFont boldSystemFontOfSize:10];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    if([Name isEqualToString: @"Sports on TV" ]){
    lbl_heading.text = @"Choose a Sport";
     lbl_heading.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];   
    }
    else if([Name isEqualToString:@"Food & Offers" ]){
    lbl_heading.text = @"Choose a Food";
    lbl_heading.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];    
    }
    //------------------------mb-25/05/12/5-45---------------------//
    else if([Name isEqualToString:@"Facilities" ]){
        lbl_heading.text = @"Amenities";
        lbl_heading.backgroundColor = [UIColor clearColor];
    }
    //----------------------------------------------//

    else if([Name isEqualToString:@"Regular"]){
        lbl_heading.text = @"Choose a Regular Event";
        lbl_heading.backgroundColor = [UIColor clearColor];
    }
    
    else if([Name isEqualToString:@"One Off" ]){
        lbl_heading.text = @"Choose a One off Event";
        lbl_heading.backgroundColor = [UIColor clearColor];
    }
    
    else if([Name isEqualToString:@"Theme Nights" ]){
        lbl_heading.text = @"Choose a Theme Night";
        lbl_heading.backgroundColor = [UIColor clearColor];
    }
    else if([Name isEqualToString:@"What's On Tonight..." ]){
         lbl_heading.text = @"What's On Tonight";
        lbl_heading.textColor = [UIColor greenColor];
        lbl_heading.backgroundColor = [UIColor clearColor];
        NSDate *date = [NSDate date]; 
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterLongStyle]; 
        [df setTimeStyle:NSDateFormatterNoStyle];  
        
        NSString *tempdateString = [df stringFromDate:date]; 
        NSLog(@"%@",tempdateString);
        datelbl.text = tempdateString;
        [df release];
                  }
    else if([Name isEqualToString:@"What's On Next 7 Days" ]){
        lbl_heading.text = @"What's On Next 7 Days";
        lbl_heading.textColor = [UIColor greenColor];
        lbl_heading.backgroundColor = [UIColor clearColor];
        NSDate *date = [NSDate date];         
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterLongStyle]; 
        [df setTimeStyle:NSDateFormatterNoStyle];         
        NSString *tempdateString = [df stringFromDate:date]; 
        NSLog(@"%@",tempdateString);
        datelbl.text = tempdateString;
        [df release];
    }
    
    [self setCatagoryViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:datelbl];
    [self.view addSubview:lbl_heading];
    [self.view addSubview:table_catagory];
    [lbl_heading release];
    [backButton release];
    [datelbl release];
}

-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCatagoryViewFrame{
    
    
    if ([Constant isiPad]) {
        ;
    }
    
    else{
        if ([Constant isPotrait:self]) {
            
            table_catagory.frame=CGRectMake(0, 44, 320, 272);
            lbl_heading.frame = CGRectMake(100, 10, 125, 27);
             backButton.frame = CGRectMake(10, 15, 50, 20);
            datelbl.frame = CGRectMake(230, 10, 125, 27);
        }
        
        else{
            table_catagory.frame=CGRectMake(0, 45, 480, 150);
            lbl_heading.frame = CGRectMake(200, 14, 125, 27); 
             backButton.frame = CGRectMake(20, 15, 50, 20);
            datelbl.frame = CGRectMake(365, 14, 125, 27);
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
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
- (void)ShareInTwitter:(NSNotification *)notification {
    iCodeOauthViewController *obj_twt=[[iCodeOauthViewController alloc]initWithNibName:nil bundle:nil];
    obj_twt.twt_text=@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v  This will do the job of informing the recipient of the message about the app so they download it.";
    [self.navigationController pushViewController:obj_twt animated:YES];
    [obj_twt release];
}                 


- (void)ShareInGooglePlus:(NSNotification *)notification {
    ;
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
    
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"The Big Fish Experience"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

#pragma mark EmailComposer Delegate-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)Settings:(NSNotification *)notification {
    MyPreferences *obj_mypreferences=[[MyPreferences alloc]initWithNibName:[Constant GetNibName:@"MyPreferences"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_mypreferences animated:YES];
    [obj_mypreferences release];
}


- (void)ShareInLinkedin:(NSNotification *)notification {
    oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loginViewDidFinish:) 
                                                 name:@"loginViewDidFinish" 
                                               object:oAuthLoginView];
    
    
    [self presentModalViewController:oAuthLoginView animated:YES];
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [oAuthLoginView release];
    oAuthLoginView = nil;
}

- (void)ShareInFacebook:(NSNotification *)notification {
    [[FacebookController sharedInstance] setFbDelegate:self];
    [[FacebookController sharedInstance] initialize];
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
     @"Want to share through Greetings", @"description",
     @"https://m.facebook.com/apps/Greetings/", @"link",
     //@"http://fbrell.com/f8.jpg", @"picture",
     nil];  
    [[FacebookController sharedInstance].facebook dialog:@"feed"
                                               andParams:params
                                             andDelegate:self];    
    // barButton.enabled = YES;
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
	
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Error Occurred!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
	
	if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
		//NSLog(@"URL  %@",url);			//alert user of successful post
		
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Message Posted Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.table_catagory=nil;
    self.catagoryArray = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        toolBar.frame = CGRectMake(0, 387, 320, 48);
    }
    else{
        toolBar.frame = CGRectMake(0, 240, 480, 48);
    }
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*if(Name==@"What's On Tonight..."){
        return 7;
    }
    else if(Name==@"What's On Next 7 Days"){
        return 7;
    }
    else{
    return [catagoryArray count];
    }*/
    
    return [catagoryArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger MIDDLE_LABEL_TAG = 1002;
    const NSInteger BOTTOM_LABEL_TAG = 1003;
    const NSInteger END_LABEL_TAG = 1004;
    const NSInteger NEXT_IMG_TAG = 1005;
    const NSInteger FIRST_LABEL_TAG = 1006;
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
		
        UIView *vw = [[[UIView alloc]init]autorelease];
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
        
		topLabel =[[[UILabel alloc]init]autorelease];
        topLabel.frame =
        CGRectMake(20,2,170,37);
        
		[vw addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:13];
        topLabel.lineBreakMode = UILineBreakModeWordWrap;
        topLabel.numberOfLines = 2;
        
        nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(292, 18, 9, 12)]autorelease];
        nextImg.tag = NEXT_IMG_TAG;
        nextImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        nextImg.image=[UIImage imageNamed:@"right_iPhone"];
        [vw addSubview:nextImg];
        
        if([Name isEqualToString:@"What's On Tonight..." ]){
            
            topLabel.frame =CGRectMake(20, 2, 70, 40);
            topLabel.font = [UIFont boldSystemFontOfSize:9];
            
            middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(150, 7, 80, 20)]autorelease]
            ;
            middlelbl.tag = MIDDLE_LABEL_TAG;
            middlelbl.backgroundColor = [UIColor clearColor];
            middlelbl.textColor = [UIColor blueColor];
            middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middlelbl.font = [UIFont boldSystemFontOfSize:7];
             [vw addSubview:middlelbl];
            
            bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(150, 15, 80, 20)]autorelease];
            bottomlbl.tag = BOTTOM_LABEL_TAG;
            bottomlbl.backgroundColor = [UIColor clearColor];
            bottomlbl.textColor = [UIColor whiteColor];
            bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            bottomlbl.font = [UIFont boldSystemFontOfSize:7];
            [vw addSubview:bottomlbl];
            
            endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(285, 4, 100, 40)]autorelease];
            endlbl.tag = END_LABEL_TAG;
            endlbl.backgroundColor = [UIColor clearColor];
            endlbl.textColor = [UIColor whiteColor];
            endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            endlbl.font = [UIFont boldSystemFontOfSize:7];
            [vw addSubview:endlbl];
           }
        
        if([Name isEqualToString:@"What's On Next 7 Days" ]){
            firstlbl = [[[UILabel alloc]initWithFrame:CGRectMake(15, 2, 50, 40)]autorelease];
            firstlbl.tag = FIRST_LABEL_TAG;
            firstlbl.font = [UIFont boldSystemFontOfSize:12];
            firstlbl.backgroundColor = [UIColor clearColor];
            firstlbl.textColor = [UIColor whiteColor];
            firstlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            [vw addSubview:firstlbl];
            
            topLabel.frame = CGRectMake(70, 5, 40, 40);
            topLabel.font = [UIFont boldSystemFontOfSize:7];
            topLabel.lineBreakMode = UILineBreakModeWordWrap;
            topLabel.numberOfLines = 2;
            
            middlelbl = [[[UILabel alloc]init]autorelease];
            middlelbl.frame = CGRectMake(150, 7, 80, 20);
            middlelbl.backgroundColor = [UIColor clearColor];
            middlelbl.textColor = [UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1];
            middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middlelbl.font = [UIFont boldSystemFontOfSize:7];
            [vw addSubview:middlelbl];
            
            bottomlbl = [[[UILabel alloc]init]autorelease];
            bottomlbl.frame=CGRectMake(150, 15, 80, 20);
            bottomlbl.backgroundColor = [UIColor clearColor];
            bottomlbl.textColor = [UIColor whiteColor];
        bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            bottomlbl.font = [UIFont boldSystemFontOfSize:7];
            [vw addSubview:bottomlbl];
            
            endlbl = [[[UILabel alloc]init]autorelease];
            endlbl.frame=CGRectMake(285, 4, 100, 40);
            endlbl.backgroundColor = [UIColor clearColor];
            endlbl.textColor = [UIColor whiteColor];
            endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            endlbl.font = [UIFont boldSystemFontOfSize:7];
            [vw addSubview:endlbl];
        }
    }
    else{
        firstlbl = (UILabel *)[cell viewWithTag:FIRST_LABEL_TAG];
        topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
        middlelbl = (UILabel *)[cell viewWithTag:MIDDLE_LABEL_TAG];
        bottomlbl = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
        endlbl = (UILabel *)[cell viewWithTag:END_LABEL_TAG];
		nextImg = (UIImageView *)[cell viewWithTag:NEXT_IMG_TAG];
        
        
    }
    @try {
        if([Name isEqualToString:@"Sports on TV"]){
       topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Sport_Name"];
            NSLog(@"ID  %@",[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Sport_ID"]);
        
        }
        else if([Name isEqualToString:@"Food & Offers" ]){
         topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Food_Name"];
        }
       else if([Name isEqualToString:@"What's On Tonight..." ]){
//            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Name" ];
//            middlelbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
//            bottomlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubCity" ];
//           endlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance" ];
           topLabel.backgroundColor = [UIColor clearColor];
           topLabel.frame = CGRectMake(10, 0, 250, 40);
           topLabel.font = [UIFont boldSystemFontOfSize:13];
           topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"];
        }
        else if([Name isEqualToString:@"What's On Next 7 Days" ]){
//            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Name" ];
//            middlelbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubName" ];
//            bottomlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubCity" ];
//            endlbl.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance" ];
            topLabel.backgroundColor = [UIColor clearColor];
            topLabel.frame = CGRectMake(10, 0, 250, 40);
            topLabel.font = [UIFont boldSystemFontOfSize:13];
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"];
        }
        //-------------------mb--25/05/12/5-45----------------------//
        else if([Name isEqualToString:@"Facilities" ])
        {
            NSLog(@"catagoryArray   %@",catagoryArray);
            topLabel.text = [[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Ammenity_Type" ];
        }
        //-----------------------------------------//
        else
        {
        topLabel.text = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_Name"]; 
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if([Name isEqualToString:@"Sports on TV"]){
    
        SportDetail *obj_sportdetail = [[SportDetail alloc]initWithNibName:[Constant GetNibName:@"SportDetail"] bundle:[NSBundle mainBundle]];  
        obj_sportdetail.searchRadius = searchRadius;
         obj_sportdetail.sportID = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Sport_ID"];
        obj_sportdetail.sport_name=Name;
         obj_sportdetail.str_title=[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Sport_Name"];
        [self.navigationController pushViewController:obj_sportdetail animated:YES];
        [obj_sportdetail release];
    }
    else if ([Name isEqualToString:@"Food & Offers"]) {
            
            PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
            obj.catID = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Food_ID"];
            obj.searchRadius = searchRadius;
        obj.eventName=[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Food_Name"];
        

            [self.navigationController pushViewController:obj animated:YES];
            [obj release];
    }
    else if ([Name isEqualToString:@"Regular"] || [Name isEqualToString:@"One Off" ] || [Name isEqualToString:@"Theme Nights" ] || [Name isEqualToString:@"What's On Next 7 Days" ] || [Name isEqualToString:@"What's On Tonight..." ]) {
        
        PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:Name];
        obj.categoryStr=Name;
        obj.catID = eventID;//[[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_ID"];
        obj.sport_eventID = [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_ID"];
        obj.eventID= [[catagoryArray objectAtIndex:indexPath.row] valueForKey:@"Event_ID"];
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
    }
    //-------------mb------25/05/12/5-45---------------------//
    else if([Name isEqualToString:@"Facilities"])
    {
        NSLog(@"catagoryArray   %@",[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Ammenity_Type" ]);
        AmenitiesDetails  *obj_aminitiesDtls=[[AmenitiesDetails alloc]initWithNibName:[Constant GetNibName:@"AmenitiesDetails"] bundle:[NSBundle mainBundle] withString:[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Ammenity_Type" ]];
        obj_aminitiesDtls.Name=[[catagoryArray objectAtIndex:indexPath.row]valueForKey:@"Ammenity_Type" ];
        obj_aminitiesDtls.searchRadius=searchRadius;
        //obj_aminitiesDtls.Name=Name;
        [self.navigationController pushViewController:obj_aminitiesDtls animated:YES];
        [obj_aminitiesDtls release];
    }
    //-----------------------------------// 
        
    

}
-(void)dealloc{
    [table_catagory release];
    [catagoryArray release];
    [searchRadius release];
    [searchUnit release];
    [toolBar release];
    [super dealloc];

}

@end
