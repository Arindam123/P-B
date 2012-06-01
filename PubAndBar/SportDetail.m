//
//  SportDetail.m
//  PubAndBar
//
//  Created by User7 on 08/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SportDetail.h"
#import "PubList.h"
#import "AppDelegate.h"

@implementation SportDetail
@synthesize vw_header;
@synthesize frstlbl;
@synthesize secndlbl;
@synthesize thrdlbl;
@synthesize fourthlbl;
@synthesize fifthlbl;
@synthesize backButton;
@synthesize table_list;
@synthesize array;
@synthesize sportID;
@synthesize sport_name;

@synthesize searchRadius;
@synthesize searchUnit;

//////////////////JHUMA///////////////////////////////////

@synthesize str_title;
@synthesize Title_lbl;

@synthesize oAuthLoginView;


UILabel *topLabel;
UILabel *middlelbl;
UILabel *bottomlbl;
UILabel *endlbl;
UILabel *extremelbl;
UIImage *rowBackGround;
UIImage *selectBackGround;
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
    self.eventTextLbl.text=sport_name;

    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    app.issportsEvent=YES;
    array=[[NSMutableArray alloc]init];
        
    array = [[SaveSportDetailInfo GetSport_EventInfo:sportID withRadius:searchRadius]retain];
    [self CreateView];
    
    //-----------------------------------mb----------------------------//
    if ([array count]==0) {
        
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

-(void)CreateView{
    
    table_list = [[UITableView alloc]init];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    vw_header = [[UIView alloc]init];
    
    // vw.backgroundColor = [UIColor colorWithRed:96/255 green:94/255 blue:93/255 alpha:1];
    vw_header.backgroundColor = [UIColor grayColor];
    
    
    frstlbl = [[UILabel alloc]init];
    frstlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    ////////////////////////////JHUMA/////////////////////////////////////////////////////
    
    frstlbl.text = @"EVENT";
    frstlbl.textColor = [UIColor whiteColor];
    frstlbl.font = [UIFont systemFontOfSize:10];
    frstlbl.textAlignment=UITextAlignmentCenter;
    
    secndlbl = [[UILabel alloc]init];
    secndlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    secndlbl.textColor = [UIColor whiteColor];
    secndlbl.font = [UIFont systemFontOfSize:10];
    secndlbl.text = @"DATE";
    secndlbl.textAlignment=UITextAlignmentCenter;
    
    thrdlbl = [[UILabel alloc]init];
    thrdlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    thrdlbl.textColor = [UIColor whiteColor];
    thrdlbl.font = [UIFont systemFontOfSize:10];
    thrdlbl.text = @"TIME";
    thrdlbl.textAlignment=UITextAlignmentCenter;
    
    fourthlbl = [[UILabel alloc]init];
    fourthlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fourthlbl.textColor = [UIColor whiteColor];
    fourthlbl.font = [UIFont systemFontOfSize:10];
    fourthlbl.text = @"TYPE";
    fourthlbl.textAlignment=UITextAlignmentCenter;
    
    fifthlbl = [[UILabel alloc]init];
    fifthlbl.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fifthlbl.textColor = [UIColor whiteColor];
    fifthlbl.font = [UIFont systemFontOfSize:10];
    fifthlbl.text = @"CHANNEL";
    fifthlbl.textAlignment=UITextAlignmentCenter;
    
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor = [UIColor clearColor];
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont systemFontOfSize:9];
    NSString *str=[NSString stringWithFormat:@"Pubs & Bars showing %@ on TV",str_title];
    Title_lbl.text =str;
    Title_lbl.textAlignment=UITextAlignmentCenter;
    
    
    [self setViewFrame];
    [self.view addSubview:vw_header];
    [vw_header addSubview:frstlbl];
    [vw_header addSubview:secndlbl];
    [vw_header addSubview:thrdlbl];
    [vw_header addSubview:fourthlbl];
    [vw_header addSubview:fifthlbl];
    [self.view addSubview:table_list];
    [self.view addSubview:backButton];
    [self.view addSubview:Title_lbl];
    [frstlbl release];
    [secndlbl release];
    [thrdlbl release];
    [fourthlbl release];
    [fifthlbl release];
    [backButton release];
    [vw_header release];
    [Title_lbl release];
}
/////////////////////////////////////////////////////////////////////////////

-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

////////////////////////////JHUMA///////////////////////////////////

-(void)setViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            vw_header.frame = CGRectMake(0, 38, 320, 40);
            frstlbl.frame = CGRectMake(0, 0, 102, 40);
            
            secndlbl.frame = CGRectMake(103, 0, 44, 40);
            
            thrdlbl.frame = CGRectMake(148, 0, 44, 40);
            
            fourthlbl.frame = CGRectMake(193, 0, 64, 40);
            
            fifthlbl.frame = CGRectMake(258, 0, 62, 40);
            
            backButton.frame = CGRectMake(10, 15, 50, 20);
            Title_lbl.frame=CGRectMake(80, 15, 170, 20);
            table_list.frame = CGRectMake(0, 78, 320, 270);
            table_list.scrollEnabled = NO;
        }
        
        else{
            
            frstlbl.frame = CGRectMake(0, 0, 151, 40);
            secndlbl.frame = CGRectMake(152, 0, 69, 40);
            
            thrdlbl.frame = CGRectMake(222, 0, 66, 40);
            
            fourthlbl.frame = CGRectMake(289, 0, 81, 40);
            
            fifthlbl.frame = CGRectMake(371, 0, 109, 40);
            backButton.frame = CGRectMake(20, 15, 50, 20);
            Title_lbl.frame=CGRectMake(110, 15, 190, 20);
            table_list.frame = CGRectMake(2, 79, 480, 300);
            vw_header.frame = CGRectMake(0, 38, 480, 42);
            table_list.scrollEnabled = YES;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
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
    iCodeOauthViewController *obj_twt=[[iCodeOauthViewController alloc]initWithNibName:nil bundle:nil];
    obj_twt.twt_text=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v  This will do the job of informing the recipient of the message about the app so they download it."]
    ;// @"http://tinyurl.com/89u8erm = (media text) #Pubs and Bars showing %@ http://tinyurl.com/bncphw2 Possibly use existing text for these pages?",sport_name];
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
    [self setViewFrame];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return 5;//[eventArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger MIDDLE_LABEL_TAG = 1002;
    const NSInteger BOTTOM_LABEL_TAG = 1003;
    const NSInteger END_LABEL_TAG = 1004;
    const NSInteger EXTREME_LABEL_TAG = 1005;
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
        
        
        
        topLabel =
		[[[UILabel alloc]init]autorelease];
        topLabel.frame =
        CGRectMake(0, 0, 100, 50);
        
		[cell.contentView addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
        topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:9];
        topLabel.layer.borderWidth= .5;
        topLabel.layer.borderColor = [[UIColor grayColor]CGColor];
        topLabel.textAlignment = UITextAlignmentCenter;
        topLabel.numberOfLines=3;
        topLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(102, 0, 45, 50)]autorelease];
        middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        middlelbl.tag = MIDDLE_LABEL_TAG;
        middlelbl.backgroundColor = [UIColor clearColor];
        middlelbl.textColor = [UIColor whiteColor];
        middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        middlelbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:middlelbl];
        middlelbl.layer.borderWidth= .5;
        middlelbl.layer.borderColor = [[UIColor grayColor]CGColor];
        middlelbl.textAlignment = UITextAlignmentCenter;
        
        
        bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(147, 0, 45, 50)]autorelease];
        bottomlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        bottomlbl.tag = BOTTOM_LABEL_TAG;
        bottomlbl.backgroundColor = [UIColor clearColor];
        bottomlbl.textColor = [UIColor whiteColor];
        bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        bottomlbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:bottomlbl];
        bottomlbl.layer.borderWidth= .5;
        bottomlbl.layer.borderColor = [[UIColor grayColor]CGColor];
        bottomlbl.textAlignment = UITextAlignmentCenter;
        
        
        endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(192, 0, 55, 50)]autorelease];
        endlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        endlbl.tag = END_LABEL_TAG;
        endlbl.backgroundColor = [UIColor clearColor];
        endlbl.textColor = [UIColor whiteColor];
        endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        endlbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:endlbl];
        endlbl.layer.borderWidth= .5;
        endlbl.layer.borderColor = [[UIColor grayColor]CGColor];
        endlbl.textAlignment = UITextAlignmentCenter;
        
        extremelbl =[[[UILabel alloc]initWithFrame:CGRectMake(257, 0, 74, 50)]autorelease];
        extremelbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        extremelbl.tag = EXTREME_LABEL_TAG;
        extremelbl.backgroundColor = [UIColor clearColor];
        extremelbl.textColor = [UIColor whiteColor];
        extremelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        extremelbl.font = [UIFont boldSystemFontOfSize:9];
        [cell.contentView addSubview:extremelbl];
        extremelbl.layer.borderWidth= .5;
        extremelbl.layer.borderColor = [[UIColor grayColor]CGColor];
        extremelbl.textAlignment = UITextAlignmentCenter;
        
    }
    
    
    else{
        topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
        middlelbl = (UILabel *)[cell viewWithTag:MIDDLE_LABEL_TAG];
        bottomlbl = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
        endlbl = (UILabel *)[cell viewWithTag:END_LABEL_TAG];
        extremelbl = (UILabel *)[cell viewWithTag:EXTREME_LABEL_TAG];
    }
    @try {
        topLabel.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Sport_EventName" ];
        middlelbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Sport_Date" ];
        bottomlbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Time" ];
        endlbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Type" ];
        extremelbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Channel" ];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    UIImageView *backgroundImageView = [[[UIImageView alloc] init] autorelease];
    if(indexPath.row==0){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        cell.backgroundView = backgroundImageView;
        
    }
    else if(indexPath.row==1){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1]];
        cell.backgroundView = backgroundImageView;
    }
    else if(indexPath.row==2){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        cell.backgroundView = backgroundImageView;
        
    }
    else if(indexPath.row==3){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1]];
        cell.backgroundView = backgroundImageView;
    }
    else if(indexPath.row==4){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        cell.backgroundView = backgroundImageView;
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:sport_name];
    obj.searchRadius = searchRadius;
    obj.catID = [[array objectAtIndex:indexPath.row] valueForKey:@"Sport_ID"];
    obj.sport_eventID = [[array objectAtIndex:indexPath.row] valueForKey:@"Sport_EventID"];
    obj.Pubid=[[array objectAtIndex:indexPath.row] valueForKey:@"PubID"];
    
    ////////////////////////////JHUMA///////////////////////////////////
    
    obj.eventName=[[array objectAtIndex:indexPath.row]valueForKey:@"Sport_EventName"];

    [self.navigationController pushViewController:obj animated:YES];
   // [obj release];

    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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


-(void)dealloc{
    [table_list release];
    [searchRadius release];
    [toolBar release];
    [super dealloc];
}

@end
