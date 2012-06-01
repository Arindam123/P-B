//
//  TextSearch.m
//  PubAndBar
//
//  Created by User7 on 26/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "TextSearch.h"

@implementation TextSearch
@synthesize backButton;
@synthesize lblheading;
@synthesize searchbar;
@synthesize txtvw;
@synthesize vw;
@synthesize vw_textfield;
@synthesize resultvw;
@synthesize scrvw;
@synthesize oAuthLoginView;


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
    self.eventTextLbl.text=[NSString stringWithFormat:@"Search"];

    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    [self CreateView];
}

-(void)CreateView{
    
    scrvw = [[UIScrollView alloc]init];
    [scrvw setShowsVerticalScrollIndicator:NO];
    scrvw.contentSize = CGSizeMake(320, 280);

    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    lblheading = [[UILabel alloc]init];
    lblheading.text = @"SEARCH";
    lblheading.backgroundColor = [UIColor clearColor];
    lblheading.textColor = [UIColor whiteColor];
    lblheading.font = [UIFont systemFontOfSize:15];
    
    vw_textfield = [[UIView alloc]init];
    vw_textfield.backgroundColor = [UIColor whiteColor];
    vw_textfield.layer.cornerRadius = 6.0f;
    
    searchbar = [[UITextField alloc]init];
    searchbar.frame = CGRectMake(73, 7, 180, 18);
    searchbar.placeholder = @"Enter Event or Keyword";
    searchbar.font = [UIFont systemFontOfSize:14];
    searchbar.delegate = self;
    
    resultvw = [[UITextView alloc]init];
    resultvw.backgroundColor = [UIColor clearColor];
    resultvw.text = @"RESULTS SHOULD APPEAR HERE";
    resultvw.delegate = self;
    resultvw.textColor = [UIColor whiteColor];
    resultvw.layer.borderWidth = 1.0f;
    resultvw.font = [UIFont systemFontOfSize:8];
    resultvw.layer.borderColor = [[UIColor colorWithRed:30.2/255.0 green:56.5/255.0 blue:99.6/255.0 alpha:1]CGColor];
    
    vw = [[UIView alloc]init];
    vw.backgroundColor = [UIColor  colorWithRed:57.6/255.0 green:64.7/255.0 blue:86.3/255.0 alpha:1.0];
    
    
    [self setViewFrame];
    [self.view addSubview:backButton];
    [self.view addSubview:lblheading];
    [self.view addSubview:vw];
    [self.view addSubview:vw_textfield];
    [vw_textfield addSubview:searchbar];
    [scrvw addSubview:resultvw];
    [self.view addSubview:scrvw];
    [lblheading release];
    [vw release];
    [searchbar release];
    [resultvw release];
    [vw_textfield release];
    [scrvw release];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    //Terminate editing
    [searchbar resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            lblheading.frame = CGRectMake(125, 9, 150, 30);
            backButton.frame = CGRectMake(10, 16, 50, 20);
            vw.frame = CGRectMake(0, 47, 320, 9);
            vw_textfield.frame = CGRectMake(27, 66, 280, 29);
            resultvw.frame = CGRectMake(27, 2, 280, 260);
            scrvw.frame = CGRectMake(0, 100, 320, 270);
            
                    }
        
        else{
            
            backButton.frame = CGRectMake(20, 15, 50, 20);
            lblheading.frame = CGRectMake(210, 9, 150, 30);
            vw.frame = CGRectMake(0, 47, 480, 9);
            vw_textfield.frame = CGRectMake(25, 64, 438, 29);
            resultvw.frame = CGRectMake(27, 2, 438, 190);
            scrvw.frame = CGRectMake(0, 104, 480, 200);
        }
    }

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

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self AddNotification];

    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setViewFrame];
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
    obj_twt.twt_text=[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v  This will do the job of informing the recipient of the message about the app so they download it."];//
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


-(void)dealloc{
    
    //[btn_bottom release];
    [toolBar release];
    [backButton release];
    [txtvw release];
    [super dealloc];
    
    
}


@end
