//
//  RealAle.m
//  PubAndBar
//
//  Created by User7 on 25/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "RealAle.h"
#import "DistenceWheel.h"
#import <QuartzCore/QuartzCore.h>
#import "RealAleDetail.h"


@implementation RealAle
@synthesize table_realale;
@synthesize aleArray;
@synthesize backButton;
@synthesize btnsearch;
@synthesize text_field;
@synthesize topLabel;
@synthesize nextImg;
@synthesize ale_name;
@synthesize realale;
@synthesize vari;
@synthesize searchRadius;
@synthesize searchUnit;

///////////////////////////////////////// JHUMA///////////////////////
@synthesize Title_lbl;
@synthesize vw_search;
@synthesize img_1stLbl;

@synthesize oAuthLoginView;




AppDelegate *app;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withString:(NSString *)_str4
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
    
    self.eventTextLbl.text=realale;

    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    app =(AppDelegate*) [[UIApplication sharedApplication]delegate];

    aleArray = [[NSMutableArray alloc]init];
    aleArray = [[SaveRealAleInfo GetAleInfo:searchRadius]retain]; 
    
    //-----------------------------------mb----------------------------//
    if ([aleArray count]==0) {
   
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
    
    table_realale = [[UITableView alloc]init];
    table_realale.delegate=self;
    table_realale.dataSource=self;
    table_realale.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_realale.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    text_field = [[UITextField alloc]init];
    text_field.delegate=self;
    text_field.backgroundColor=[UIColor whiteColor];
    
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    btnsearch = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnsearch setTitle:@"< Search by Ale Name" forState:UIControlStateNormal];
    [btnsearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnsearch.backgroundColor = [UIColor clearColor];
    btnsearch.titleLabel.font=[UIFont boldSystemFontOfSize:8];
    
    ////////////////////////////JHUMA////////////////////////////////////////////////////////////
    
    vw_search=[[UIView alloc]init];
    vw_search.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    
    
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor =[UIColor clearColor];    
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont systemFontOfSize:10];
    Title_lbl.text =@"Search by Brewery Below";
    Title_lbl.textAlignment=UITextAlignmentLeft;
    
    img_1stLbl=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow2.png"]];

    

    
    [self setAleViewFrame];
    [self.view addSubview:vw_search];
    [self.view addSubview:Title_lbl];
    [self.view addSubview:backButton];
    [self.view addSubview:table_realale];
    [self.view addSubview:btnsearch];
    [self.view addSubview:text_field];
    [self.view addSubview:img_1stLbl];

    
    [backButton release];
    [vw_search release];
    [Title_lbl release];
    [img_1stLbl release];
    //[btnsearch release];
}

-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    //Terminate editing
    [text_field resignFirstResponder];
    return YES;
}
-(void)setAleViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            table_realale.frame=CGRectMake(0, 94, 320, 250);
            table_realale.scrollEnabled = YES;
            backButton.frame = CGRectMake(10, 18, 50, 20);
            text_field.frame = CGRectMake(100, 19, 125, 18);
            btnsearch.frame = CGRectMake(225, 12, 100, 30);
            vw_search.frame=CGRectMake(0, 50, 320, 7);
            Title_lbl.frame=CGRectMake(2, 64, 200, 24);
            img_1stLbl.frame=CGRectMake(123, 74, 8, 8);

        }
        
        else{
            table_realale.frame=CGRectMake(0, 90, 480, 142);
            table_realale.scrollEnabled = YES;
            backButton.frame = CGRectMake(20, 15, 50, 20);
            text_field.frame = CGRectMake(190, 19, 125, 18);
            btnsearch.frame = CGRectMake(345, 12, 100, 30);
            vw_search.frame=CGRectMake(0, 46, 480, 7);
            Title_lbl.frame=CGRectMake(2, 62, 200, 20);
            img_1stLbl.frame=CGRectMake(120, 71, 8, 8);

        }
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setAleViewFrame];
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
    [self setAleViewFrame];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.table_realale = nil;
    self.aleArray = nil;
    self.text_field = nil;
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
	
    return [aleArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger NEXT_IMG_TAG = 1005;
    
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

		
		topLabel =[[[UILabel alloc]initWithFrame:CGRectMake(20,2,170,37)]autorelease];
        
		[vw addSubview:topLabel];
		
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:13];
        
        
        nextImg = [[[UIImageView alloc]initWithFrame:CGRectMake(282, 18, 9, 12)]autorelease];
        nextImg.tag = NEXT_IMG_TAG;
        nextImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        nextImg.image=[UIImage imageNamed:@"right_iPhone"];
        [vw addSubview:nextImg];
    }
    else{
        topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		nextImg = (UIImageView *)[cell viewWithTag:NEXT_IMG_TAG];
    }
    @try {
        topLabel.text = [[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_Name"];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ale_name = [[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_Name"];
    
    RealAleDetail *obj = [[RealAleDetail alloc]initWithNibName:[Constant GetNibName:@"RealAleDetail"] bundle:[NSBundle mainBundle]];
    obj.Realale_ID =    [[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_ID"];
    obj._Name = realale;
    obj.searchRadius = searchRadius;
    
    ////////////////////////////JHUMA////////////////////////////////////////////////////////////
    
    obj.str_breweryName=[[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_Name"];
    obj.strPostcode=[[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_Postcode"];

    [self.navigationController pushViewController:obj animated:YES];
    [obj release];

    
    /*DistenceWheel *obj_distancewheel = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
    obj_distancewheel._name=realale;
    obj_distancewheel._name1=ale_name ;
    obj_distancewheel.ale_ID = [[aleArray objectAtIndex:indexPath.row] valueForKey:@"Ale_ID"];
    [self.navigationController pushViewController:obj_distancewheel animated:YES];
    [obj_distancewheel release];*/
    
}



-(void)dealloc{
    [table_realale release];
    [aleArray release];
    [text_field release];
    [toolBar release];
    [searchRadius release];
    [searchUnit release];
    [super dealloc];

}
@end