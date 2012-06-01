//
//  iCodeOauthViewController.m
//  iCodeOauth
//
//  Created by Collin Ruffenach on 9/14/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "iCodeOauthViewController.h"
#import "Tweet.h"
//#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>
//#import "CustomTextView.h"
//#import "SampleGdataAppDelegate.h"


#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 305.0f
#define CELL_CONTENT_MARGIN 23.0f
#define kOAuthConsumerKey        @"KV2mFOcoQwJ5pCWbaEYmOA"    //REPLACE With Twitter App OAuth Key  
#define kOAuthConsumerSecret    @"Zi7iN9arThdX0MhkyZqtqT9iDVs9XH2WO15QNzCAg" //REPLACE With Twitter App OAuth Secret  

@implementation iCodeOauthViewController

@synthesize twt_text;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    tweetTxtView.text=twt_text;

    button4LogOut.hidden = YES;
    tweetTxtView.delegate = self;
	//tweetTxtView.text = @"";
    tweetTxtView.layer.cornerRadius=9.0;
    tweetTxtView.layer.borderColor=[UIColor blackColor].CGColor;
    tweetTxtView.layer.borderWidth=2;
	self.title = @"T W I T T E R";
	 
   // NSLog(@"%@",tweetTxtView.text);
    
	tempArray = [[NSMutableArray alloc] init];
	

    
   /* barButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(button4LogOutPressed:)];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
*/
	/*UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonpressed:)];
    barBtn.style = UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = barBtn;
    [barBtn release];
*/
}

-(IBAction)cancelButtonpressed:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
}


-(void) viewWillDisappear:(BOOL)animated{
	
	[super viewWillDisappear:YES];
	//[_engine closeAllConnections];
}

- (void)viewDidAppear:(BOOL)animated {
	
	if(_engine) return;
	
		
	/*	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
		_engine.consumerKey = kOAuthConsumerKey; //PzkZj9g57ah2bcB58mD4Q
		_engine.consumerSecret = kOAuthConsumerSecret; //OvogWpara8xybjMUDGcLklOeZSF12xnYHLE37rel2g
		
		UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
		
	//NSLog(@"AUthorized  %d  controller  %@",_engine.isAuthorized,controller);
		
		if (controller){
			barButton.enabled = NO;
			//table.hidden = YES;
			[self presentModalViewController:controller animated: YES];
		}
		
		else {
			//tweets = [[NSMutableArray alloc] init];
			barButton.enabled = YES;
			//table.hidden = YES;
//			loadingView = [LoadingView loadingViewInView:self.view withFrame:CGRectMake(75, 160, 170, 120)];
//			loadingView.center = self.view.center;
			[self performSelector:@selector(updateTwitt)];
		}
*/
}



-(void) updateTwitt{
    
    [_engine getFollowedTimelineSinceID:1 startingAtPage:1 count:100];
	
}


#pragma mark
#pragma mark Table view data source




- (BOOL)textView:(UITextView *)textViews shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"]) {
		[tweetTxtView resignFirstResponder];
		return NO;
	}
	
	return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
	tweetTxtView.text = @"";
}




-(void) callingLogIn
{
	if (_engine){
		[_engine release];
		_engine = nil;
	}
	
    _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
	_engine.consumerKey = kOAuthConsumerKey; //PzkZj9g57ah2bcB58mD4Q
	_engine.consumerSecret = kOAuthConsumerSecret; //OvogWpara8xybjMUDGcLklOeZSF12xnYHLE37rel2g
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
	//NSLog(@"controller  %@",controller);
    [self presentModalViewController:controller animated:YES];
	//[self viewDidAppear:YES];
	
}


#pragma mark IBActions

-(IBAction)tweet:(id)sender {
	
	[tweetTxtView  resignFirstResponder];
	
	if (!barButton.enabled) {
		
		[self callingLogIn];
	}
	else{
		
		if ([tweetTxtView.text length] == 0) {
			
			UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please provide some inputs" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			//myAlert.tag = 2;
			[myAlert show];
			[myAlert release];
		}
		else{
			
			[_engine sendUpdate:[tweetTxtView text]];
			
			UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Tweet" message:@"Tweet Posted Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			myAlert.tag = 2;
			[myAlert show];
			[myAlert release];
			//table.hidden = YES;
//			loadingView = [LoadingView loadingViewInView:self.view withFrame:CGRectMake(75, 160, 170, 120)];
//			loadingView.center = self.view.center;
			callingAfterTwitt = YES;
		}
		
		
	}
	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
	
    if (alertView.tag == 2) {
		
        if (buttonIndex == 0) {
            
            [self performSelector:@selector(selectorMethod) withObject:nil afterDelay:3.0];
        }
    }
}

-(void) selectorMethod
{
    [_engine getFollowedTimelineSinceID:1 startingAtPage:1 count:100];
}


- (IBAction)button4LogOutPressed:(id)sender {
    
	//    NSHTTPCookie *cookie;
	//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	//    for (cookie in [cookieJar cookies]) {   
	//        [cookieJar deleteCookie:cookie];
	//        NSLog(@"%@", cookie);
	//    }
    
	//NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier]; 
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authData"];//removePersistentDomainForName:appDomain];
																		   //NSLog(@"AppDomain- %@",appDomain);
																		   //button4LogOut.hidden = YES;
	barButton.enabled = NO;
	[tweets removeAllObjects];
    
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Logged Out" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
//	[table beginUpdates];
//    [table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
//	[table endUpdates];

	
}

#pragma mark SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

#pragma mark SA_OAuthTwitterController Delegate

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	
	//NSLog(@"Authenticated with user %@", username);
	
	//tweets = [[NSMutableArray alloc] init];
//	loadingView = [LoadingView loadingViewInView:self.view withFrame:CGRectMake(75, 160, 170, 120)];
//	loadingView.center = self.view.center;
    [self performSelector:@selector(updateTwitt)];
	
	
    //button4LogOut.hidden = NO;
	barButton.enabled = YES;

}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	
	//NSLog(@"Authentication Failure");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	
	//NSLog(@"Authentication Canceled");
    
}

#pragma mark MGTwitterEngineDelegate Methods

- (void)requestSucceeded:(NSString *)connectionIdentifier {
	
	//NSLog(@"Request Suceeded: %@", connectionIdentifier);
    
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error{
	//NSLog(@"Request Error: %d", [error code]);
	//[loadingView performSelector:@selector(removeView)];
	if ([error code] == 401) {
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"authData"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[self callingLogIn];
	}

}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier {
	
	//NSLog(@"ID %@",connectionIdentifier);
	tweets = [[NSMutableArray alloc] init];
	
	for(NSDictionary *d in statuses) {
		Tweet *tweet = [[Tweet alloc] initWithTweetDictionary:d];			
		[tweets addObject:tweet];		
		[tweet release];
        
	}
    //NSLog(@"Tweet Count  %d",[tweets count]);
	
	
}

- (void)receivedObject:(NSDictionary *)dictionary forRequest:(NSString *)connectionIdentifier {
	
	//NSLog(@"Recieved Object: %@", dictionary);
}

- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier {
	
	//NSLog(@"Direct Messages Received: %@", messages);
}

- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier {
	
	//NSLog(@"User Info Received: %@", userInfo);
}

- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier {
	
	//NSLog(@"Misc Info Received: %@", miscInfo);
}


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 //return (interfaceOrientation == UIInterfaceOrientationPortrait);
     
     if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){ 
         twtBgVw.image=[UIImage imageNamed:@"TwitterbgP.png"];
         tweetButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"TwitterButtonL.png"]];
         return YES;  
     } else {  
          twtBgVw.image=[UIImage imageNamed:@"TwitterbgL.png"];
           tweetButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"TwitterButtonL.png"]];
         return NO;  
     } 
 }
 

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [table release];
    table = nil;
    [tweetTxtView release];
    tweetTxtView = nil;
    [button4LogOut release];
    button4LogOut = nil;
	[tweetButton release];
    tweetButton = nil;
    [twtBgVw release];
    twtBgVw = nil;
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [button4LogOut release];
    [tweetTxtView release];
    [table release];
	[tweetButton release];
    [twtBgVw release];
    [super dealloc];
}

@end
