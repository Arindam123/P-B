//
//  RecomendedVenue.m
//  PubAndBar
//
//  Created by Apple on 05/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "RecomendedVenue.h"
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"


@implementation RecomendedVenue


@synthesize hud = _hud;
@synthesize backbutton;
@synthesize txt_VenueName;
@synthesize txt_Address;
@synthesize txt_recomndedBy;
@synthesize sendbutton;

@synthesize lbl_recommendedBy;
@synthesize lbl_Address;
@synthesize lbl_VenueName;
@synthesize scrll;
@synthesize img_header;
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
    txt_VenueName.backgroundColor=[UIColor clearColor];
    txt_Address.backgroundColor=[UIColor clearColor];
    txt_recomndedBy.backgroundColor=[UIColor clearColor];
       
    txt_VenueName.borderStyle=NO;
    txt_recomndedBy.borderStyle=NO;
    
    scrll.contentSize=CGSizeMake(254, 150);
    vw.layer.cornerRadius=7.0;
      
}


- (void)viewDidUnload
{
    [backbutton release];
    backbutton = nil;
    [self setBackbutton:nil];
    [txt_VenueName release];
    txt_VenueName = nil;
    [self setTxt_VenueName:nil];
    [txt_Address release];
    txt_Address = nil;
    [self setTxt_Address:nil];
    [txt_recomndedBy release];
    txt_recomndedBy = nil;
    [self setTxt_recomndedBy:nil];
    [sendbutton release];
    sendbutton = nil;
    [self setSendbutton:nil];
  
    [scrll release];
    scrll = nil;
    [self setScrll:nil];
    [img_header release];
    img_header = nil;
    [self setImg_header:nil];
    [self setLbl_VenueName:nil];
    [self setLbl_Address:nil];
    [self setLbl_recommendedBy:nil];
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
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    // [btn_Back setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backbutton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backbutton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    
    [sendbutton setImage:[UIImage imageNamed:@"Send_DeselectL.png"] forState:UIControlStateNormal];
    [sendbutton setImage:[UIImage imageNamed:@"Send_SelectL.png"] forState:UIControlStateHighlighted];

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
            backbutton.frame=CGRectMake(8, 90, 50, 25);
            scrll.frame=CGRectMake(10, 164, 300, 244);
            vw.frame=CGRectMake(0, 0, 300, 244);
            img_header.frame=CGRectMake(10, 130, 299, 24);
            img_To.image=[UIImage imageNamed:@"Location2.png"];
            img_Subject.image=[UIImage imageNamed:@"RectangleBox.png"];
            img_From.image=[UIImage imageNamed:@"Location2.png"];
            sendbutton.frame=CGRectMake(238, 210, 58, 27);
            
            img_To.frame=CGRectMake(90, 25, 204, 23);
            txt_VenueName.frame=CGRectMake(90, 20, 204, 31);
            
             img_Subject.frame=CGRectMake(90, 69, 204, 86);
            txt_Address.frame=CGRectMake(90, 69, 204, 86);
            
             img_From.frame=CGRectMake(90, 176, 204, 23);
            txt_recomndedBy.frame=CGRectMake(90, 173, 204, 31);
            scrll.contentSize=CGSizeMake(300, 300);
            lbl_VenueName.frame=CGRectMake(4, 20, 83, 25);
            lbl_Address.frame=CGRectMake(4, 96, 73, 22);
            lbl_recommendedBy.frame=CGRectMake(4, 175, 83, 31);
                      
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
            backbutton.frame=CGRectMake(10, 85, 50, 25);
             scrll.frame=CGRectMake(10, 130, 460, 125);
            vw.frame=CGRectMake(0, 0, 460, 250);
            img_header.frame=CGRectMake(90, 100, 300, 24);
            scrll.contentSize=CGSizeMake(460, 270);
            img_To.image=[UIImage imageNamed:@"RecomendedBox2L.png"];
            img_Subject.image=[UIImage imageNamed:@"RectangleBoxL.png"];
            img_From.image=[UIImage imageNamed:@"RecomendedBox2L.png"];
            sendbutton.frame=CGRectMake(406, 217, 45, 23);
            img_To.frame=CGRectMake(103, 16, 346, 33);
            txt_VenueName.frame=CGRectMake(103, 13, 346, 33);
            
            img_Subject.frame=CGRectMake(103, 72, 346, 86);
            txt_Address.frame=CGRectMake(103, 72, 346, 141);
            
            img_From.frame=CGRectMake(103, 174, 346, 33);
            txt_recomndedBy.frame=CGRectMake(103, 174, 346, 33);
            scrll.scrollEnabled=YES;
        }
    }
    
}
-(IBAction)ClickSend:(id)sender
{
    IsRecomended=YES;

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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }
}
else 
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
    
}
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{    
    
    
    //[scrll setContentOffset:CGPointMake(0, 120)animated:YES];
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];       
        
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
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
            
            viewFrame.origin.y -= 115;
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
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
                
                viewFrame.origin.y += 115;
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.3];
            [self.view setFrame:viewFrame];
            [UIView commitAnimations];
            
        }
        
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  /*  if (textField.tag==10) {
        [txt_VenueName resignFirstResponder];
        //[txt_Address becomeFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 50)animated:YES];
        //return YES;
    }
    else  if(textField==txt_recomndedBy) {
        
        [txt_recomndedBy resignFirstResponder];
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

    
 /*   if (textField==txt_VenueName)
        [scrll setContentOffset:CGPointMake(0, 0)animated:YES];
    else if(textField==txt_recomndedBy)
        [scrll setContentOffset:CGPointMake(0, 140)animated:YES];*/
    
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
    [nav release];}                 


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
    mailController.mailComposeDelegate = self;
    
    if (IsRecomended==YES) {
        [mailController setSubject:[NSString stringWithFormat:@"Recommend a venue"]];
        [mailController setToRecipients:[NSArray arrayWithObject:[NSString stringWithFormat:@"info@pubandbar-network.co.uk"]]];
        [mailController setMessageBody:[NSString stringWithFormat:@"Venue Name : %@ \nAddress : %@ \nRecommended by %@",txt_VenueName.text,txt_Address.text,txt_recomndedBy.text] isHTML:NO];
             
    }
    else
    {
        
       [mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
        
    }
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
    
    [backbutton release];
    [txt_VenueName release];
    [txt_Address release];
    [txt_recomndedBy release];
    [sendbutton release];
    [img_To release];
    [img_Subject release];
    [img_From release];
    [scrll release];
    [img_header release];
    [lbl_VenueName release];
    [lbl_Address release];
    [lbl_recommendedBy release];
    [super dealloc];
}
@end

