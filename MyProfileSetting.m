//
//  MyProfileSetting.m
//  PubAndBar
//
//  Created by Apple on 03/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "MyProfileSetting.h"
#import "AppDelegate.h"
#import "My_Profile.h"
#import "RecomendedVenue.h"
#import "YourIdeas.h"
#import "ContactHelp.h"
#import "PreferenceDetailsViewController.h"
#import "MyPreferences.h"
#import "MyProfileSetting.h"
#import "Home.h"
#import "SignIn.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"


@implementation MyProfileSetting
@synthesize My_table;
@synthesize btn_signin;
@synthesize img_button;
@synthesize oAuthLoginView;

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
    
    toolBar = [[Toolbar alloc]init];
    [self.view addSubview:toolBar];
    
    section_array=[[NSMutableArray alloc]initWithObjects:@"My Profile",@"My Favorites",@"My Settings",@"Recommend a Venue",@"Your Ideas for Version 1.1",@"My Alert",@"Contact & Help", nil];
  // My_table.backgroundColor=[UIColor clearColor];
    //My_table.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
   // My_table.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"RecomendedWhiteBackGround.png"]];
    My_table.layer.cornerRadius=7.0;
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate];


}


- (void)viewDidUnload
{
    [img_button release];
    img_button = nil;
    [btn_signin release];
    btn_signin = nil;
    [My_table release];
    My_table = nil;
     [super viewDidUnload];
   
   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*
-(IBAction)ClickBack:(id)sender{
    [btn_Back setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}
*/
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // app.ismore=NO;
    
   // [btn_Back setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
   [self setViewFrame];
    
    [self AddNotification];
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
            
          
            if (app.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                //toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            btn_signin.frame=CGRectMake(6, 93, 309, 72);
             img_button.frame=CGRectMake(10, 84, 300, 72);
            My_table.frame=CGRectMake(10, 153, 299, 260);
            btn_signin.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBar.png"]];
                       
        }
            else{
            
            if (app.ismore==YES) {
                // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
                btn_signin.frame=CGRectMake(8.5, 84, 460, 61);
                img_button.frame=CGRectMake(10, 84, 300, 61);
                My_table.frame=CGRectMake(10, 136, 458, 118);
                btn_signin.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBarTwoL.png"]];
        
               }
    }
    
}

-(IBAction)ClickSignup:(id)sender{
    
    SignIn *obj_SignIn=[[SignIn alloc]initWithNibName:[Constant GetNibName:@"SignIn"] bundle:[NSBundle mainBundle]];
    [self presentModalViewController:obj_SignIn animated:YES];
    [obj_SignIn  release];
    
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
#pragma mark
#pragma mark Social Network Functions

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
    [obj release];
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


- (void)Settings:(NSNotification *)notification {
    MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
    [obj_MyProfileSetting release];
}


- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
    
}


- (void)ShareInFacebook:(NSNotification *)notification {
    
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}





#pragma mark - EmailComposer Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


-(void)displayEmailComposerSheet
{
    MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc]init] ;
    [mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"Pub & bar Network"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}


#pragma mark
#pragma mark LinkedIN Delegates


-(void) loginViewDidFinish:(NSNotification*)notification
{
    // [oAuthLoginView release];
    // oAuthLoginView = nil;
    [oAuthLoginView testApiForPostingMessage:nil];
}


#pragma mark
#pragma mark Facebook Delegates

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
    [My_table reloadData];
    
}

#pragma mark
#pragma mark TableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [section_array count]+1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
//    if(indexPath.row==0){
//        
//        return 36;
//    }
//    else
    return 34;	
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger ICON_IMG_TAG = 1002;
    const NSInteger BUTTON_IMG_TAG = 1003;
     
    
	UILabel *topLabel;
    UIImageView *iconImg;
    UIButton *btn_continue;

    	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	//if (cell == nil)
	{
        
        cell =[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor redColor];
      
		if (indexPath.row==7) {
            
            btn_continue=[[[UIButton alloc]initWithFrame:CGRectMake(190, 0, 95, 25)] autorelease];
            btn_continue.tag=BUTTON_IMG_TAG;
            [btn_continue setTitle:@"Continue to App.." forState:UIControlStateNormal];
            [btn_continue setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            //btn_continue.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            btn_continue.titleLabel.textAlignment=UITextAlignmentCenter;
            btn_continue.titleLabel.font=[UIFont systemFontOfSize:11];
            [btn_continue addTarget:self action:@selector(ClickToApp:) forControlEvents:UIControlEventTouchUpInside];
            // btn_continue.titleLabel.font=[];;
            btn_continue.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:btn_continue];
        }
        else{ 
           topLabel =[[[UILabel alloc]initWithFrame:CGRectMake(63,3,170,20)] autorelease];
            
            topLabel.lineBreakMode = UILineBreakModeWordWrap;
            topLabel.numberOfLines = 2;
            topLabel.tag = TOP_LABEL_TAG;
            topLabel.backgroundColor = [UIColor clearColor];
            topLabel.textColor = [UIColor colorWithRed:90.0/255.0 green:113.0/255.0 blue:156.0/255.0 alpha:1];
            topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            topLabel.font = [UIFont boldSystemFontOfSize:13];
            [cell.contentView addSubview:topLabel];
                
            iconImg = [[[UIImageView alloc]initWithFrame:CGRectMake(23, 2, 22, 22)] autorelease];
            iconImg.tag = ICON_IMG_TAG;
            [cell.contentView addSubview:iconImg];
            
            
            if (orientation == UIInterfaceOrientationPortrait || orientation ==UIInterfaceOrientationPortraitUpsideDown)
                {
                    if(indexPath.row==0){
                        iconImg.image=[UIImage imageNamed:@"Icon1.png"];
                    }
                    else if(indexPath.row==1){
                        iconImg.image=[UIImage imageNamed:@"Icon2.png"];
                    }
                    else if(indexPath.row==2){
                        iconImg.image=[UIImage imageNamed:@"Settingsicon.png"];
                    }
                    else if(indexPath.row==3){
                        iconImg.image=[UIImage imageNamed:@"icon3.png"];
                    }
                    else if(indexPath.row==4){
                        iconImg.image=[UIImage imageNamed:@"TextIcon.png"];
                    }
                    else if(indexPath.row==6){
                        iconImg.image=[UIImage imageNamed:@"Icon4.png"];
                    }
                    else if(indexPath.row==5){
                        iconImg.image=[UIImage imageNamed:@"Alert.png"];
                    }

                               
                }
                
            else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==UIInterfaceOrientationLandscapeRight)
                {
                    if(indexPath.row==0){
                        iconImg.image=[UIImage imageNamed:@"Icon1.png"];
                    }
                    else if(indexPath.row==1){
                        iconImg.image=[UIImage imageNamed:@"Icon2.png"];
                    }
                    else if(indexPath.row==2){
                        iconImg.image=[UIImage imageNamed:@"Settingsicon.png"];
                    }
                    else if(indexPath.row==3){
                        iconImg.image=[UIImage imageNamed:@"icon3.png"];
                    }
                    else if(indexPath.row==4){
                        iconImg.image=[UIImage imageNamed:@"TextIcon.png"];
                    }
                    else if(indexPath.row==6){
                        iconImg.image=[UIImage imageNamed:@"Icon4.png"];
                    }
                    else if(indexPath.row==5){
                        iconImg.image=[UIImage imageNamed:@"Alert.png"];
                    }
                               
                }
        
        }         
    }
    {
        
        topLabel = (UILabel *)[cell.contentView viewWithTag:TOP_LABEL_TAG];
        iconImg = (UIImageView *)[cell.contentView viewWithTag:ICON_IMG_TAG];
        btn_continue = (UIButton *)[cell.contentView viewWithTag:BUTTON_IMG_TAG];
        

    }
    if (indexPath.row != 7) {
        
        topLabel.text = [section_array objectAtIndex:indexPath.row];

    }
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            if (indexPath.row == 7)
                btn_continue.frame=CGRectMake(190, 0, 95, 25);
            if (indexPath.row!=7) {
                cell.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BoxCell.png"]];
            }
        }
        else{
            if (indexPath.row == 7)
                btn_continue.frame=CGRectMake(310, 0, 95, 25);
            
            if (indexPath.row!=7) {
                cell.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BoxCellL.png"]]; 
            }
            
        }
    }

    /*if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            btn_continue.frame=CGRectMake(190, 0, 95, 25);
           
            if (indexPath.row!=7) {
                cell.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BoxCell.png"]];
            }
        }
        else{
             btn_continue.frame=CGRectMake(310, 0, 95, 25);
            
            if (indexPath.row!=7) {
                cell.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BoxCellL.png"]]; 
            }
            
        }
    }*/
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vw=[[UIView alloc]initWithFrame:CGRectMake(10, 150, 300, 5)];
        
    return [vw autorelease];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSLog(@"indexPath.row  %d",indexPath.row);
    
    
    if([app.SaveSignIn valueForKey:@"success"])
    {
        
        
        if (indexPath.row==0) {
            
            My_Profile *obj_My_Profile=[[My_Profile alloc]initWithNibName:[Constant GetNibName:@"My_Profile"] bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:obj_My_Profile animated:YES];
            [obj_My_Profile release];
            
            }
        else if (indexPath.row==1) {
            
           PreferenceDetailsViewController *obj_PreferenceDetailsViewController=[[PreferenceDetailsViewController alloc]initWithNibName:[Constant GetNibName:@"PreferenceDetailsViewController"] bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:obj_PreferenceDetailsViewController animated:YES];
            [obj_PreferenceDetailsViewController release];
            }
         else if (indexPath.row==2) {
            
             
             MyPreferences *obj_MyPreferences=[[MyPreferences alloc]initWithNibName:[Constant GetNibName:@"MyPreferences"] bundle:[NSBundle mainBundle]];
             [self.navigationController pushViewController:obj_MyPreferences animated:YES];
             [obj_MyPreferences release];
            }
         else if (indexPath.row==3) {
             
             RecomendedVenue *obj_RecomendedVenue=[[RecomendedVenue alloc]initWithNibName:[Constant GetNibName:@"RecomendedVenue"] bundle:[NSBundle mainBundle]];
             [self.navigationController pushViewController:obj_RecomendedVenue animated:YES];
             [obj_RecomendedVenue release];
            }
        
         else if (indexPath.row==4) {
             YourIdeas *obj_YourIdeas=[[YourIdeas alloc]initWithNibName:[Constant GetNibName:@"YourIdeas"] bundle:[NSBundle mainBundle]];
             [self.navigationController pushViewController:obj_YourIdeas animated:YES];
             [obj_YourIdeas release];
           }
         else if (indexPath.row==6) {
             ContactHelp *obj_ContactHelp=[[ContactHelp alloc]initWithNibName:[Constant GetNibName:@"ContactHelp"] bundle:[NSBundle mainBundle]];
             [self.navigationController pushViewController:obj_ContactHelp animated:YES];
             [obj_ContactHelp release];
            
           }

          else if (indexPath.row==5) {
              
              UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Would you like to proceed?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
              alert1.tag=100;
              [alert1 show];
              [alert1 release];
         
          }
          else if (indexPath.row==7) {
              
              
              
          }
    
    }
    
    else{
        
        if (indexPath.row==6) {
            
            NSLog(@"Hii");
            ContactHelp *obj = [[[ContactHelp alloc]initWithNibName:[Constant GetNibName:@"ContactHelp"] bundle:[NSBundle mainBundle]] autorelease];
            [self.navigationController pushViewController:obj animated:YES];
            //[obj release];
            
        }
        else if (indexPath.row==7) {
            
            
            
        }
        
        else if (indexPath.row==1) {
            
            PreferenceDetailsViewController *obj_PreferenceDetailsViewController=[[PreferenceDetailsViewController alloc]initWithNibName:[Constant GetNibName:@"PreferenceDetailsViewController"] bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:obj_PreferenceDetailsViewController animated:YES];
            [obj_PreferenceDetailsViewController release];
        }

        else{

        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Please Sign in or Sign Up to access " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert1 show];
        [alert1 release];
        }
        
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==100){
        
        if (buttonIndex==0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/Visitor/addVisitor.php"]]];
        }
        
    }
    
    
}
-(IBAction)ClickToApp:(id)sender{
    
   [self.navigationController popViewControllerAnimated:YES];

    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
        [My_table reloadData];
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
        
        [My_table reloadData];
    }
    return YES;
}

- (void)dealloc {
    [My_table release];
    [img_button release];
    [btn_signin release];
    [section_array release];
    [toolBar release];
    [super dealloc];
}
@end
