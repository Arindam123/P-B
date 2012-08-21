//
//  LinkedINViewController.m
//  PubAndBar
//
//  Created by MacMini10 on 16/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "LinkedINViewController.h"
#import "OAuthLoginView.h"
#import <QuartzCore/QuartzCore.h>
#import "InternetValidation.h"

/*
public static final String APP_NAME = "Bond";
public static final String CONSUMER_KEY = "uhdt7rowvm1v";
public static final String CONSUMER_SECRET = "bXgEWobCHvzH0yTy";
public static final String OAUTH_CALLBACK_SCHEME = "x-oauthflow-linkedin";
public static final String OAUTH_CALLBACK_HOST = "calback";
public static final String OAUTH_CALLBACK_URL = OAUTH_CALLBACK_SCHEME
+ "://" + OAUTH_CALLBACK_HOST;*/

#define KApiKey4LinkedIn @"uhdt7rowvm1v"
#define KApiSecret4LinkedIn @"bXgEWobCHvzH0yTy"


@implementation LinkedINViewController


@synthesize  oAuthLoginView,consumer,accessToken,shareText;

BOOL isLoggedIN = NO;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    bgImageView.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor darkTextColor];
    
    shareButton.layer.cornerRadius = 5.0;
    
    textView.returnKeyType = UIReturnKeyDone;
    textView.layer.cornerRadius = 5.0;
    textView.text = shareText;
    textView.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonpressed:)];
    barBtn.style = UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = barBtn;
    [barBtn release];
    
    textView.text = shareText;
    
    [self performSelector:@selector(callingLinkedIN) withObject:nil afterDelay:0.8];
    
    // Do any additional setup after loading the view from its nib.
    
    
    
   /* */
    
}


-(void) makeAceesToken
{
    consumer = [[OAConsumer alloc] initWithKey:KApiKey4LinkedIn
                                        secret:KApiSecret4LinkedIn
                                         realm:@"http://api.linkedin.com/"];
    
    self.accessToken = [[OAToken alloc] initWithHTTPResponseBody:[defaults objectForKey:@"authData4LinkedIN"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) callingLinkedIN
{
    oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loginViewDidFinish:) 
                                                 name:@"loginViewDidFinish" 
                                               object:oAuthLoginView];
    
    [self presentModalViewController:oAuthLoginView animated:YES];
    
}



#pragma mark - Button Action


-(void) cancelButtonpressed:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)shareButtonAction:(id)sender 
{
 
    if ([InternetValidation checkNetworkStatus]) {
        /*NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~/shares"];
         //http://api.linkedin.com/v1/people/~/shares
         
         OAMutableURLRequest *request =
         [[OAMutableURLRequest alloc] initWithURL:url
         consumer:consumer
         token:self.accessToken
         callback:nil
         signatureProvider:nil];
         
         
         
         [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
         [request setValue:@"xml" forHTTPHeaderField:@"x-li-format"];
         
         NSString *strCreateNewDiscussion=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
         "<share>"
         "<comment>%@</comment>"
         "<content>"
         " <title>Survey: Social networks top hiring tool - San Francisco Business Times</title>"
         "<submitted-url>http://sanfrancisco.bizjournals.com/sanfrancisco/stories/2010/06/28/daily34.html</submitted-url>"
         "<submitted-image-url>http://images.bizjournals.com/travel/cityscapes/thumbs/sm_sanfrancisco.jpg</submitted-image-url>"
         "</content>"
         "<visibility>"
         "<code>anyone</code>"
         "</visibility>"
         "</share>",textView.text];
         
         NSLog(@"%@",strCreateNewDiscussion);
         [request setHTTPBodyWithString:strCreateNewDiscussion];
         [request setHTTPMethod:@"POST"];
         
         OADataFetcher *fetcher = [[OADataFetcher alloc] init];
         [fetcher fetchDataWithRequest:request
         delegate:self
         didFinishSelector:@selector(postUpdateApiCallResult:didFinish:)
         didFailSelector:@selector(postUpdateApiCallResult:didFail:)];    
         [request release];*/
        
        if (isLoggedIN) {
            
            NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~/shares"];
            OAMutableURLRequest *request = 
            [[OAMutableURLRequest alloc] initWithURL:url
                                            consumer:oAuthLoginView.consumer
                                               token:oAuthLoginView.accessToken
                                            callback:nil
                                   signatureProvider:nil];
            
            
            NSDictionary *update = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [[NSDictionary alloc] 
                                     initWithObjectsAndKeys:
                                     @"anyone",@"code",nil], @"visibility", 
                                    textView.text, @"comment", nil];
            
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            NSString *updateString = [update JSONString];
            
            [request setHTTPBodyWithString:updateString];
            [request setHTTPMethod:@"POST"];
            NSLog(@"LinkedIn Post:%@",updateString);
            
            OADataFetcher *fetcher = [[OADataFetcher alloc] init];
            [fetcher fetchDataWithRequest:request
                                 delegate:self
                        didFinishSelector:@selector(postUpdateApiCallResult:didFinish:)
                          didFailSelector:@selector(postUpdateApiCallResult:didFail:)];    
            [request release];
        }
        else
        {
            UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Error!" message:@"Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 20;
            [alert  show];
            [alert  release];
        }
        
        
        
    }
    else
    {
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }
    
}


#pragma mark - textView Delegates

- (BOOL)textView:(UITextView *)textViews shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
		return NO;
	}
	
	return YES;
}


#pragma mark
#pragma mark LinkedIN Delegates


- (void) storeCachedLinkedInOAuthData: (NSString *) data forUsername: (NSString *) username
{
    NSLog(@"AUthDAta  %@",data);
    
    //NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData4LinkedIN"];
	[defaults synchronize];
    [self performSelector:@selector(makeAceesToken)];

}


-(void) loginViewDidFinish:(NSNotification*)notification
{
    
    /*[oAuthLoginView release];
     oAuthLoginView = nil;*/
    
    
    NSDictionary *obj = [notification userInfo];
    NSLog(@"loginViewDidFinish  %@",obj);
    if (obj != NULL) {
        
        isLoggedIN = YES;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
}


- (void)postUpdateApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data 
{
    // The next thing we want to do is call the network updates
    // [self networkApiCall];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Finish  %@",str);
    if (str.length == 0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Successfully posted..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}

- (void)postUpdateApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error 
{
    NSLog(@"error %@",[error description]);
}


#pragma mark - Memory CleanUp

- (void)viewDidUnload
{
    [bgImageView release];
    bgImageView = nil;
    [textView release];
    textView = nil;
    [shareButton release];
    shareButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [bgImageView release];
    [textView release];
    [shareButton release];
    [shareText release];
    [consumer release];
    [accessToken release];
    
    [super dealloc];
}

@end
