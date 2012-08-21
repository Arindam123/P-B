//
//  My_Profile.m
//  PubAndBar
//
//  Created by Apple on 03/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "My_Profile.h"
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"

@implementation My_Profile
@synthesize txt_FirstName;
@synthesize txt_LastName;
@synthesize txt_EmailAddr;
@synthesize txt_Password;
@synthesize txt_Location;
@synthesize txt_Facebook;
@synthesize txt_GooglePlus;
@synthesize txt_Twitter;
@synthesize txt_linkedin;
@synthesize btn_Back;
@synthesize btn_Save;
@synthesize hud = _hud;
@synthesize oAuthLoginView;
@synthesize img_recomendedWhtebox;
@synthesize btn_my_profile;
@synthesize scrll;


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
    
    txt_FirstName.backgroundColor=[UIColor clearColor];
    txt_LastName.backgroundColor=[UIColor clearColor];
    txt_EmailAddr.backgroundColor=[UIColor clearColor];
    txt_Password.backgroundColor=[UIColor clearColor];
    txt_Location.backgroundColor=[UIColor clearColor];
    txt_Facebook.backgroundColor=[UIColor clearColor];
    txt_Twitter.backgroundColor=[UIColor clearColor];
    txt_linkedin.backgroundColor=[UIColor clearColor];
    txt_GooglePlus.backgroundColor=[UIColor clearColor];
    txt_FirstName.borderStyle=NO;
    txt_LastName.borderStyle=NO;
    txt_EmailAddr.borderStyle=NO;
    txt_Password.borderStyle=NO;
    txt_Location.borderStyle=NO;
    txt_Facebook.borderStyle=NO;
    txt_Twitter.borderStyle=NO;
    txt_linkedin.borderStyle=NO;
    txt_GooglePlus.borderStyle=NO;
    
    txt_FirstName.placeholder=@"  First Name";
    txt_LastName.placeholder=@"  Last Name";
    txt_EmailAddr.placeholder=@"  Email Address";
    txt_Password.placeholder=@"  Password";
    txt_Location.placeholder=@"  Location";
    txt_Facebook.placeholder=@"  Facebook";
    txt_Twitter.placeholder=@"  Twitter";
    txt_linkedin.placeholder=@"  Linkedin";
    txt_GooglePlus.placeholder=@"  Google Plus";
    
   // MainVw.layer.cornerRadius=6.0;
    //MainVw.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"RecomendedWhiteBackGround.png"]];
   // scrll.contentSize=CGSizeMake(280, 300);
    scrll.scrollEnabled = NO;
    scrll.layer.cornerRadius=10.0;
    scrll.backgroundColor=[UIColor whiteColor];
    vw.backgroundColor=[UIColor clearColor];
    
    
     app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    if ([[app.Savedata valueForKey:@"SignUp_FirstName"]length]!=0) {
        
        
        NSLog(@"%@",[app.Savedata valueForKey:@"SignUp_FirstName"]);
        txt_FirstName.text=[app.Savedata valueForKey:@"SignUp_FirstName"];
        
    }
    if ([[app.Savedata valueForKey:@"SignUp_LastName"]length]!=0) {
        txt_LastName.text=[app.Savedata valueForKey:@"SignUp_LastName"];
        
    }

    if ([[app.Savedata valueForKey:@"SignUp_Email"]length]!=0) {
        txt_EmailAddr.text=[app.Savedata valueForKey:@"SignUp_Email"];
        
    }

    if ([[app.Savedata valueForKey:@"SignUp_Password"]length]!=0) {
        txt_Password.text=[app.Savedata valueForKey:@"SignUp_Password"];
        
    }

    if ([[app.Savedata valueForKey:@"SignUp_Location"]length]!=0) {
        txt_Location.text=[app.Savedata valueForKey:@"SignUp_Location"];
        
    }

   

    
    
    
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
            scrll.frame=CGRectMake(16, 118, 294, 249);
            vw.frame=CGRectMake(0, 55, 300, 245);
             scrll.scrollEnabled=YES;
            btn_my_profile.frame=CGRectMake(-4, -3, 303, 55);
            
            img_firstName.frame=CGRectMake(9,48, 138, 31);
             txt_FirstName.frame=CGRectMake(9, 47, 138, 31);
            
            
            img_LastName.frame=CGRectMake(154,47, 138, 31);
            txt_LastName.frame=CGRectMake(155, 47, 138, 31);
            
            img_Email.frame=CGRectMake(9,85, 138, 31);
             txt_EmailAddr.frame=CGRectMake(9,85, 138, 31);
            
            img_Password.frame=CGRectMake(154,85, 138, 31);
            txt_Password.frame=CGRectMake(155,85, 138, 31);
            
            img_Location.frame=CGRectMake(9,121, 283, 28);
            txt_Location.frame=CGRectMake(9,121, 283, 31);
           // img_firstName.backgroundColor=[UIColor blueColor];
           
            scrll.contentSize=CGSizeMake(293, 300);
           
            
            
            
            btn_my_profile.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"MyProfile.png"]];
            img_firstName.image=[UIImage imageNamed:@"PassWord2.png"];
            img_LastName.image=[UIImage imageNamed:@"PassWord2.png"];
            img_Email.image=[UIImage imageNamed:@"PassWord2.png"];
            img_Password.image=[UIImage imageNamed:@"PassWord2.png"];
            img_Location.image=[UIImage imageNamed:@"Location2.png"];
                       
        }
        else{
            
            if (app.ismore==YES) {
                // toolBar.frame = CGRectMake(-320, 387, 640, 48);
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                // toolBar.frame = CGRectMake(0, 387, 640, 48);
                toolBar.frame =CGRectMake(8.5, 261, 463, 53);
            }
            scrll.scrollEnabled=YES;
            //img_firstName.frame=CGRectMake(10, 70, 207, 29);
            //img_LastName.frame=CGRectMake(225, 70, 207, 29);

            scrll.frame=CGRectMake(12, 90, 456, 165);
            vw.frame=CGRectMake(0, 55, 460, 245);
            scrll.contentSize=CGSizeMake(455, 250);
            btn_my_profile.frame=CGRectMake(-4, -3, 460, 55);
            
            img_firstName.frame=CGRectMake(9,48, 215, 31);
            txt_FirstName.frame=CGRectMake(9, 47, 215, 31);
            
            
            img_LastName.frame=CGRectMake(230,47, 215, 31);
            txt_LastName.frame=CGRectMake(230, 47, 215, 31);
            
            img_Email.frame=CGRectMake(9,85, 215, 31);
            txt_EmailAddr.frame=CGRectMake(9,85, 215, 31);
            
            img_Password.frame=CGRectMake(230,85, 215, 31);
            txt_Password.frame=CGRectMake(230,85, 215, 31);
            
            img_Location.frame=CGRectMake(3,121, 446, 28);
            txt_Location.frame=CGRectMake(3,121, 446, 31);
            
            
             img_firstName.image=[UIImage imageNamed:@"RecomendedBoxL.png"];
             img_LastName.image=[UIImage imageNamed:@"RecomendedBoxL.png"];
            img_Email.image=[UIImage imageNamed:@"RecomendedBoxL.png"];
            img_Password.image=[UIImage imageNamed:@"RecomendedBoxL.png"];
            img_Location.image=[UIImage imageNamed:@"RecomendedBox2L.png"];
            
            
            btn_my_profile.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"MyProfileTwoL.png"]];
        }
    }
    
}
-(IBAction)ClickSave:(id)sender{
    
    [app.Savedata setValue:txt_FirstName.text forKey:@"FirstName"];
     [app.Savedata setValue:txt_LastName.text forKey:@"LastName"];
     [app.Savedata setValue:txt_EmailAddr.text forKey:@"EmailAddr"];
     [app.Savedata setValue:txt_Password.text forKey:@"Password"];
    [app.Savedata setValue:txt_Location.text forKey:@"location"];
    NSLog(@"%@",[app.Savedata valueForKey:@"FirstName"]);
     NSLog(@"%@",[app.Savedata valueForKey:@"EmailAddr"]);
     NSLog(@"%@",[app.Savedata valueForKey:@"location"]);
    
    
    
    [app.Savedata synchronize];

    NSLog(@"%@",[app.Savedata valueForKey:@"FirstName"]);
    NSLog(@"%@",[app.Savedata valueForKey:@"EmailAddr"]);
    NSLog(@"%@",[app.Savedata valueForKey:@"location"]);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  /*  if (textField.tag==1) {
        [txt_FirstName resignFirstResponder];
        //[txt_LastName becomeFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 0)animated:YES];
        //return YES;
    }
   
    else if (textField.tag==2) {
        [txt_LastName resignFirstResponder];
        //[txt_EmailAddr becomeFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 50)animated:YES];
        //return YES;
    }
    else if (textField.tag==3) {
        [txt_EmailAddr resignFirstResponder];
       // [txt_Password becomeFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 100)animated:YES];
        //return YES;
    }

    else if (textField.tag==4) {
        [txt_Password resignFirstResponder];
        //[txt_Location becomeFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 150)animated:YES];
        //return YES;
    }

    
    
    else {
        
       
         [txt_Location resignFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 0)animated:YES];
    }*/
    [textField resignFirstResponder];
    return YES;   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
          CGRect viewFrame = self.view.frame;
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                viewFrame.origin.y -= 140;
            }
            else{
                
                viewFrame.origin.y -= 75; 
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [self.view setFrame:viewFrame];
            [UIView commitAnimations];
            
        }
        
        
 /*   if (textField==txt_FirstName)
        [scrll setContentOffset:CGPointMake(0, 0)animated:YES];
    else if(textField.tag==2)
        [scrll setContentOffset:CGPointMake(0, 40)animated:YES];
    else if(textField.tag==3)
        [scrll setContentOffset:CGPointMake(0, 60)animated:YES];
    else if(textField.tag==4)
        [scrll setContentOffset:CGPointMake(0, 90)animated:YES];
    else 
        [scrll setContentOffset:CGPointMake(0, 120)animated:YES];*/
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text=nil;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    if (viewFrame.origin.y < 0.0) {
        
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                viewFrame.origin.y += 140;
            }
            else{
                
                viewFrame.origin.y += 75;  
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [self.view setFrame:viewFrame];
            [UIView commitAnimations];
            
        }
        
    }
}



-(IBAction)ClickBack:(id)sender{
    [btn_Back setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // app.ismore=NO;
   
   [btn_Save setImage:[UIImage imageNamed:@"SaveButton.png"] forState:UIControlStateNormal];
    [btn_Save setImage:[UIImage imageNamed:@"SaveButtonSelect.png"] forState:UIControlStateHighlighted];
    [btn_Back setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [btn_Back setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
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
    
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    [mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
    
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
    
}





- (void)viewDidUnload
{
    [txt_FirstName release];
    txt_FirstName = nil;
    [txt_LastName release];
    txt_LastName = nil;
    [txt_EmailAddr release];
    txt_EmailAddr = nil;
    [txt_Password release];
    txt_Password = nil;
    [txt_Location release];
    txt_Location = nil;
    [txt_Facebook release];
    txt_Facebook = nil;
    [txt_Twitter release];
    txt_Twitter = nil;
    [txt_linkedin release];
    txt_linkedin = nil;
    [txt_GooglePlus release];
    txt_GooglePlus = nil;
    [btn_Back release];
    btn_Back = nil;
    [btn_Save release];
    btn_Save = nil;
    [self setTxt_FirstName:nil];
    [self setTxt_LastName:nil];
    [self setTxt_EmailAddr:nil];
    [self setTxt_Password:nil];
    [self setTxt_Location:nil];
    [self setTxt_Facebook:nil];
    [self setTxt_GooglePlus:nil];
    [self setTxt_Twitter:nil];
    [self setTxt_linkedin:nil];
    [self setBtn_Back:nil];
    [self setBtn_Save:nil];
    [scrll release];
    scrll = nil;
    [self setScrll:nil];
    [btn_my_profile release];
    btn_my_profile = nil;
    [self setBtn_my_profile:nil];
    [img_recomendedWhtebox release];
    img_recomendedWhtebox = nil;
    [self setImg_recomendedWhtebox:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (void)dealloc {
    [txt_FirstName release];
    [txt_LastName release];
    [txt_EmailAddr release];
    [txt_Password release];
    [txt_Location release];
    [txt_Facebook release];
    [txt_Twitter release];
    [txt_linkedin release];
    [txt_GooglePlus release];
    [btn_Back release];
    [btn_Save release];
    [scrll release];
      [btn_my_profile release];
       [img_recomendedWhtebox release];
    [img_firstName release];
    [img_LastName release];
    [img_Email release];
    [img_Password release];
    [img_Location release];
    [vw release];
    [super dealloc];
}
@end
