//
//  Home.m
//  PubAndBar
//
//  Created by Alok K Goyal on 06/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Home.h"
#import "RealAle.h"
#import "TextSearch.h"
#import "FunctionRoom.h"
#import <QuartzCore/QuartzCore.h>
#import "iCodeOauthViewController.h"
#import "ServerConnection.h"
#import "DBFunctionality.h"
#import "JSON.h"


@interface Home()

-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude;

@end


@implementation Home

@synthesize hometable;
@synthesize selectionArray;
@synthesize btnSignUp;
@synthesize line_vw;
@synthesize name;
@synthesize value;
@synthesize l;
@synthesize  oAuthLoginView;
@synthesize str_RefName;
@synthesize RefNo;
@synthesize hud = _hud;
@synthesize Arr_CheckValue;

AppDelegate *delegate ;





UIImageView *pushImg;
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
    
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    RefNo=0;
    Arr_URL_Name=[[NSMutableArray alloc]initWithObjects:@"Events",@"Real Ale",@"Sports on TV",@"Facilities",@"Food & Offers",nil];
    
    Arr_CheckValue=[[NSMutableArray alloc]initWithObjects:@"Events",@"Real Ale",@"Sports on TV",@"Facilities",@"Food",nil];
    l=0;
     self.view.frame = CGRectMake(0, 0, 320, 395);
    //self.navigationController.navigationBarHidden=NO;
    [self CreateHomeView];
    selectionArray = [[NSMutableArray alloc] initWithObjects:@"Near Me Now!",@"Sports on TV",@"Events",@"Real Ale",@"Food & Offers",@"Facilities",@"Text Search",@"Function Rooms", nil];
    //selectionArray = [[SaveHomeInfo GetMain_CatagoryInfo]retain];
    
    toolBar = [[Toolbar alloc]init];
    toolBar.layer.borderWidth = 1.0f;
    //toolBar.layer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view addSubview:toolBar];
    
    self.eventTextLbl.text = name;
    if (![delegate.sharedDefaults objectForKey:@"All"]) {
        
        [self performSelector:@selector(addMBHud)];
        [self ExcuteURLWithNameRef:0];
    }
  

}

-(void)CreateHomeView{
    hometable = [[UITableView alloc]init];
    hometable.delegate = self;
    hometable.dataSource = self;
    hometable.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    hometable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    btnSignUp = [[UIButton alloc]init];

    [btnSignUp addTarget:self action:@selector(ClickSignUp:) forControlEvents:UIControlEventTouchUpInside];
    //////////////////JHUMA///////////////////////////////////
    
    [btnSignUp setTitle:@"Visitors - Sign up for Pub & Bar Alerts" forState:UIControlStateNormal];
    
    ////////////////////////////////////////////////////
    
    btnSignUp.titleLabel.font = [UIFont systemFontOfSize:10];
    
    line_vw = [[UIView alloc]init];
    line_vw.backgroundColor=[UIColor whiteColor];
    
    [self setHomeViewFrame];
    
    [self.view addSubview:btnSignUp];
    [self.view addSubview:hometable];
    [self.view addSubview:line_vw];
}

-(void)setHomeViewFrame{
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            hometable.frame = CGRectMake(0, 5, 320, 358);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(65, 363, 280, 30);
           line_vw.frame = CGRectMake(121, 383, 168, 1);
            
        }
        else{
            hometable.frame = CGRectMake(0, 14, 480, 178);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(130, 195, 420, 30);
            line_vw.frame = CGRectMake(256, 218, 168, 1);
            
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.hometable = nil;
    self.btnSignUp = nil;
    self.selectionArray = nil;
    self.line_vw = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    orientation = interfaceOrientation;

    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        toolBar.frame = CGRectMake(0, 387, 320, 48);
    }
    else{
        toolBar.frame = CGRectMake(0, 240, 480, 48);
    }
    
    return YES;
}

-(IBAction)ClickSignUp:(id)sender{
    NSLog(@"ClickSignUp");
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    [hometable reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [selectionArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger ICON_IMG_TAG = 1002;
    const NSInteger PUSH_IMAGE_TAG = 1003;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
    const NSInteger NEARMENOW_VIEW_TAG = 1005;
    const NSInteger FUNCTIONROOM_VIEW_TAG = 1006;


	UILabel *topLabel;
    UIImageView *iconImg;
    UIView *vw;
    UILabel *nearmeNowLabel;
    UILabel *functionRoomLabel;
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[[UITableViewCell alloc]
		  initWithStyle:UITableViewCellStyleDefault
		  reuseIdentifier:CellIdentifier] autorelease]
		 ;
		vw = [[[UIView alloc]init] autorelease];
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.tag = MAINVIEW_VIEW_TAG;
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  

        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        
		topLabel =
		[[UILabel alloc]initWithFrame:
		  CGRectMake(100,0,170,37)]
		 ;
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:16];
        [vw addSubview:topLabel];

        
        if ([indexPath row] == 0) {
            
            nearmeNowLabel =
            [[[UILabel alloc]initWithFrame:
              CGRectMake(29,7,71,15)] autorelease];
            ;
            
            nearmeNowLabel.tag = NEARMENOW_VIEW_TAG;
            nearmeNowLabel.backgroundColor = [UIColor blueColor];
            nearmeNowLabel.textColor = [UIColor whiteColor];
            nearmeNowLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            nearmeNowLabel.font = [UIFont systemFontOfSize:16];
            [vw addSubview:nearmeNowLabel];
            
        }
        
        
        if ([indexPath row] == 7) {
            functionRoomLabel =
            [[[UILabel alloc]initWithFrame:
              CGRectMake(100,27,100,10)] autorelease];
            ;
            
            functionRoomLabel.tag = FUNCTIONROOM_VIEW_TAG;
            functionRoomLabel.backgroundColor = [UIColor redColor];
            functionRoomLabel.textColor = [UIColor whiteColor];
            functionRoomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            functionRoomLabel.font = [UIFont systemFontOfSize:11];
            
            [vw addSubview:functionRoomLabel];
            
        }
        
		
        
        iconImg = [[[UIImageView alloc]initWithFrame:CGRectMake(13, 7, 22, 22)]autorelease];
        iconImg.tag = ICON_IMG_TAG;
        //iconImg.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if (orientation == UIInterfaceOrientationPortrait || orientation ==UIInterfaceOrientationPortraitUpsideDown) {
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrow.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"Runner.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"Note.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlass.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIcon.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlass.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIcon.png"];
            }
            
        }
        else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==UIInterfaceOrientationLandscapeRight) {
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrowL.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"RunnerL.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"NoteL.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlassL.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIconL.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlassL.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIconL.png"];
            }
            
        }
        
        
        [vw addSubview:iconImg];
        
        pushImg = [[[UIImageView alloc]initWithFrame:CGRectMake(280, 15, 10, 10)]autorelease];
        pushImg.tag = PUSH_IMAGE_TAG;
        pushImg.image=[UIImage imageNamed:@"right_iPhone"];
        pushImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        [vw addSubview:pushImg];
        
        [cell.contentView addSubview:vw];

        
    }
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		iconImg = (UIImageView *)[cell viewWithTag:ICON_IMG_TAG];
        pushImg=(UIImageView*)[cell viewWithTag:PUSH_IMAGE_TAG];
        vw = (UIView *)[cell viewWithTag:MAINVIEW_VIEW_TAG];
        if ([indexPath row] == 0) {
            
            nearmeNowLabel = (UILabel *)[cell viewWithTag:NEARMENOW_VIEW_TAG];

        }
        if ([indexPath row] == 7) {
            
            functionRoomLabel = (UILabel *)[cell viewWithTag:FUNCTIONROOM_VIEW_TAG];

        }


       
        
        if (orientation == UIInterfaceOrientationPortrait || orientation ==UIInterfaceOrientationPortraitUpsideDown){
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrow.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"Runner.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"Note.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlass.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIcon.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlass.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIcon.png"];
            }
            
        }
        else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==UIInterfaceOrientationLandscapeRight) {
            [iconImg setFrame:CGRectMake(13, 7, 19, 26)];
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrowL.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"RunnerL.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"NoteL.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlassL.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIconL.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlassL.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIconL.png"];
            }
            
        }
        
	}
    @try {
        topLabel.text = [selectionArray objectAtIndex:indexPath.row];
        NSLog(@"ROW first  %d",[indexPath row]);
        if ([indexPath row] == 0) {
            NSLog(@"ROW  %d",[indexPath row]);

            nearmeNowLabel.text = @".........................";

        }
        if ([indexPath row] == 7) {
            
            functionRoomLabel.text = @"Find me one now!";
            
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    name = [[NSString alloc]init];
    name = [selectionArray objectAtIndex:indexPath.row];
    if(indexPath.row==3){
       /* RealAle *obj_ele= [[RealAle alloc]initWithNibName:[Constant GetNibName:@"RealAle"] bundle:[NSBundle mainBundle] withString:name];
        obj_ele.realale=name;
        [self.navigationController pushViewController:obj_ele animated:YES];
        [obj_ele release];*/
        DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
        Obj._name=name;
        [self.navigationController pushViewController:Obj animated:YES];
        [Obj release];
    }
    else if(indexPath.row==6){
        TextSearch *obj_text = [[TextSearch alloc]initWithNibName:[Constant GetNibName:@"TextSearch"] bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj_text animated:YES];
        [obj_text release];

    }
    else if(indexPath.row==7){
        FunctionRoom *obj_functionroom = [[FunctionRoom alloc]initWithNibName:[Constant GetNibName:@"FunctionRoom"] bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj_functionroom animated:YES];
        [obj_functionroom release];

    }
    else{
        DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
        Obj._name=name;
        [self.navigationController pushViewController:Obj animated:YES];
        [Obj release];

    }
    
}

-(void)JSONStartWithName:(NSString*)_RefName;
{
    
    if([_RefName isEqualToString:@"Events"])
    {
        
        if (![delegate.sharedDefaults objectForKey:@"Events"])
        {
            self.str_RefName =[NSString stringWithFormat:@"Events"];
            
            //   [self performSelector:@selector(addMBHud)];
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 geteventsData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        
        
    }
    else if([_RefName isEqualToString:@"Real Ale"])
    {
        
        self.str_RefName =[NSString stringWithFormat:@"Real Ale"];
        
        if (![delegate.sharedDefaults objectForKey:@"Real Ale"]) {
            
            // [self performSelector:@selector(addMBHud)];
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 getRealAleData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        
    }
    
    else if([_RefName isEqualToString:@"Sports on TV"])
    {
        self.str_RefName =[NSString stringWithFormat:@"Sports on TV"];
        /*Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
         obj_catagory.Name = _name;
         obj_catagory.searchRadius = pickerValue;
         [self.navigationController pushViewController:obj_catagory animated:YES];
         [obj_catagory release];*/
        
        if (![delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
            
            //  [self performSelector:@selector(addMBHud)];
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 getSportsData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
    }
    
    
    else if([_RefName isEqualToString:@"Facilities"])
    {
        
        self.str_RefName =[NSString stringWithFormat:@"Facilities"];
        //---------------------------mb 5-45 -----------------------------//
        
        if (![delegate.sharedDefaults objectForKey:@"Facilities"]) {
            
            //   [self performSelector:@selector(addMBHud)];
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 getEventsData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
    }
    
    else if([_RefName isEqualToString:@"Food & Offers"])
    { 
        
        self.str_RefName =[NSString stringWithFormat:@"Food & Offers"];
        if (![delegate.sharedDefaults objectForKey:@"Food"])
        {
            
            // [self performSelector:@selector(addMBHud)];
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 getFoodandOffersData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        
    }
    
}



-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    NSLog(@"RESPONSE  %@",data_Response);
    NSLog(@"%@",self.str_RefName );
    
    //NSLog(@"pickervalue 11 %@",pickerValue);
    if ([self.str_RefName isEqualToString:@"Events"]) 
    {
        NSDictionary *json = [data_Response JSONValue];
        NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
        NSLog(@"%d",[Arr_events count]);
        for (int i = 0; i < [Arr_events count]; i++) {
            NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
            NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
            NSLog(@"%@",Str_Event);
            NSString *EventTypeID;
            
            if ([Str_Event isEqualToString:@"RegularEvent"])
                EventTypeID = @"1";
            else if([Str_Event isEqualToString:@"OneOffEvent"])
                EventTypeID = @"2";
            else if([Str_Event isEqualToString:@"ThemeNight"])
                EventTypeID = @"3";
            
            NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
            NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
            for (int j = 0; j < [Arr_EventDetails count]; j++) {
                int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                NSLog(@"%d",EventId);
                NSLog(@"%@",Str_EventName);
                
                NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                NSLog(@"%d",[Arr_PubInfo count]);
                
                for (int k = 0; k < [Arr_PubInfo count]; k++) {
                    NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                    NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                    int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                    CLLocationDistance _distance = 0.0;
                    
                    
                    if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil) 
                        _distance =  [self calculateDistance:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                        //_distance = [Constant GetDistanceFromPub: longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"]];
                    NSLog(@"%f",_distance);
                    //_distance = 2;
                    //[[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance];
                    NSLog(@"%@",[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]);
                    [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance/1000 creationdate:[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]];
                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:_distance/1000 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Date"]];
                    
                }
            }
        }
        [delegate.sharedDefaults setObject:@"1" forKey:@"Events"];
        //  [self performSelector:@selector(dismissHUD:)];
    }
    
    else if([self.str_RefName  isEqualToString:@"Food & Offers"])
    {
        //SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
        NSMutableArray *foodAndOfferArray = [[[json valueForKey:@"Details"] valueForKey:@"Food & Offers Details"] retain];
        //[parser release];
        
        //-----------------------------mb-----------------------------//
        if ([foodAndOfferArray count]!=0)
        {
            //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
            for (int i = 0; i<[foodAndOfferArray count]; i++)
            {
                
                [[DBFunctionality sharedInstance] InsertValue_Food_Type:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] withName:[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food and Offers Type"]];
                
                NSMutableArray *pubInfoArray = [[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Pub Information"] retain];
                
                for (int j = 0; j<[pubInfoArray count]; j++)
                {
                    
                    //NSLog(@"%@",currentPoint);
                    //NSLog(@"Lat  %f   Long  %f",currentPoint.coordinate.latitude,currentPoint.coordinate.longitude);
                    //appDelegate.currentPoint.coordinate.latitude
                    //appDelegate.currentPoint.coordinate.longitude
                    
                    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] doubleValue]];
                    
                    
                    [[DBFunctionality sharedInstance] InsertValue_Food_Detail:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withFoodID:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] pubDistance:distance/1000];
                    
                    
                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:j] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
                }
                NSLog(@"pubInfoArray   %@",pubInfoArray);
                [pubInfoArray release];
            }
            [foodAndOfferArray release];
            //   [self performSelector:@selector(dismissHUD:)];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Food and Offers" message:@"NO Data Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        [delegate.sharedDefaults setObject:@"1" forKey:@"Food"];   
    }
    
    
    else if([self.str_RefName isEqualToString:@"Real Ale"])
    {
        //SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
        NSMutableArray *realAleArray = [[[json valueForKey:@"Details"] valueForKey:@"Brewery Details"] retain];
        //[parser release];
        
        if ([realAleArray count] !=0) {
            for (int i = 0; i<[realAleArray count]; i++) {
                
                
                
                NSMutableArray *beerDetailsArray = [[[realAleArray objectAtIndex:i] valueForKey:@"Beer Details"] retain];
                
                for (int j = 0; j<[beerDetailsArray count]; j++) {
                    
                    
                    NSMutableArray *pubDetailsArray = [[[beerDetailsArray objectAtIndex:j] valueForKey:@"Pub Information"] retain];
                    
                    
                    for (int k = 0; k< [pubDetailsArray count]; k++) {
                        
                        
                        double distance = [self calculateDistance:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                        
                        [[DBFunctionality sharedInstance] InsertValue_RealAle_Type:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withName:[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Name"] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] pubDistance:distance/1000];
                        
                        [[DBFunctionality sharedInstance] InsertValue_Beer_Detail:[[[beerDetailsArray objectAtIndex:j] valueForKey:@"Beer ID"] intValue] withBreweryID:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withBeerName:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Ale Name"] withBeerCategory:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Category"] pubDistance:distance/1000];
                        
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
                    }
                    [pubDetailsArray release];
                }
                
                [beerDetailsArray release];
            }
            
            [realAleArray release];
            
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"RealAle" message:@"NO Data Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        [delegate.sharedDefaults setObject:@"1" forKey:@"Real Ale"];
        
    }
    
    //----------------------mb-25/05/12/5-45p.m.------------------------//
    else if([self.str_RefName  isEqualToString:@"Facilities"])
    {
        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
        NSMutableArray *AmenitiesArray = [[[json valueForKey:@"Details"] valueForKey:@"Amenities Details"] retain];
        for (int i = 0; i<[AmenitiesArray count]; i++) {
            
            [[DBFunctionality sharedInstance] InsertValue_Amenities_Type:i+1 withName:[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]];
            
            NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Facility Details"] retain];
            NSLog(@"facilityDetailsArray  %d",[facilityDetailsArray count]);
            
            for (int j = 0; j<[facilityDetailsArray count]; j++) {
                
                NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                
                for (int k=0; k<[pubInfoArray count]; k++) {
                    
                    
                    
                    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                    
                    
                    
                    [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:distance/1000 ];
                    
                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
                }
                
                [pubInfoArray release];
            }
            [facilityDetailsArray release];
        }
        [AmenitiesArray release];
        
        //[self performSelector:@selector(dismissHUD:)];
        [delegate.sharedDefaults setObject:@"1" forKey:@"Facilities"]; 
        
    }
    //-----------------------------5-45------------------------//
    
    //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
    
    else if([self.str_RefName  isEqualToString:@"Sports on TV"])
    {
        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
        NSMutableArray *sportsArray = [[[json valueForKey:@"Details"] valueForKey:@"Sports Details"] retain];
        
        for (int i = 0; i<[sportsArray count]; i++) {
            
            [[DBFunctionality sharedInstance] InsertValue_Sports_Type:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] withName:[[sportsArray objectAtIndex:i] valueForKey:@"Category Name"]];
            
            NSMutableArray *sportDetailsArray = [[[sportsArray objectAtIndex:i] valueForKey:@"event"] retain];
            NSLog(@"facilityDetailsArray  %d",[sportDetailsArray count]);
            
            for (int j = 0; j<[sportDetailsArray count]; j++) {
                
                NSMutableArray *pubInfoArray=[[[sportDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                
                if ([pubInfoArray count] == 35) {
                    
                    NSLog(@"Problem");
                }
                
                for (int k=0; k<[pubInfoArray count]; k++) {
                    
                    
                    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                    
                    
                    [[DBFunctionality sharedInstance] InsertValue_Sports_Detail:[[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventID"] intValue] sport_TypeID:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] event_Name:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventName"] event_Description:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventDescription"] event_Date:[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"] event_Channel:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Channel"] reservation:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Reservation"] sound:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Sound"] hd:[[sportDetailsArray objectAtIndex:j] valueForKey:@"HD"] threeD:[[sportDetailsArray objectAtIndex:j] valueForKey:@"threeD"] screen:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Screen"] PubID:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withPubDistance:distance/1000 event_Time:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Time"] event_Type:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Type"]];
                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
                }
                
                [pubInfoArray release];
            }
            [sportDetailsArray release];
        }
        [sportsArray release];
        
        //[self performSelector:@selector(dismissHUD:)];
        [delegate.sharedDefaults setObject:@"1" forKey:@"Sports on TV"];  
        
    }
    self.RefNo+=1;
    [self ExcuteURLWithNameRef:self.RefNo]; 
}

-(void)afterFailourConnection:(id)msg
{
    [self ExcuteURLWithNameRef:self.RefNo]; 
    
    
}

-(void)ExcuteURLWithNameRef:(int)_RefNumber
{
    
    
    if(_RefNumber<5)
    {
        NSLog(@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]);
        NSLog(@"%@",[Arr_CheckValue  objectAtIndex:_RefNumber]);
        
        
        if([self isValueCointainInDB:[NSString stringWithFormat:@"%@",[Arr_CheckValue  objectAtIndex:_RefNumber]]])
            
        {
            self.RefNo+=1;
            [self ExcuteURLWithNameRef:self.RefNo];
        }
        else
            
        {
            
            [self JSONStartWithName:[NSString stringWithFormat:@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]]];
        }  
        
    }
    else
    {
        
        [Arr_URL_Name release];
        [Arr_CheckValue release];
        [self performSelector:@selector(dismissHUD:)];
        [delegate.sharedDefaults setObject:@"Completed" forKey:@"All"];
        
    } 
    
}

-(BOOL)isValueCointainInDB:(NSString*)_str_Name
{
    BOOL isBDPresent;
    
    if ([delegate.sharedDefaults objectForKey:_str_Name])
        isBDPresent=YES;
    else
        isBDPresent=NO;    
    
    return isBDPresent;
    
}


#pragma mark-
#pragma mark-addMBHud
-(void) addMBHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = @"Please wait.";
    _hud.detailsLabelText = @"Downloading data for first time.";
    
}
#pragma mark Dismiss Hud

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
    
}
-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude
{
    NSString *latitude = @"51.5001524";
    NSString *longitude = @"-0.1262362";
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[latitude doubleValue]  longitude:[longitude doubleValue]];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
    
    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    [location1 release];
    [location2 release];
    
    return distance;
}


-(void)dealloc{
    [hometable release];
    [btnSignUp release];
    [selectionArray release];
    [line_vw release];
    [toolBar release];
    [super dealloc];

}
@end
