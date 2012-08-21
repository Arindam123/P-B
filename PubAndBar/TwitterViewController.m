//
//  TwitterViewController.m
//  PubAndBar
//
//  Created by MacMini10 on 16/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "TwitterViewController.h"
#import "TwitterView.h"
#import "InternetValidation.h"
#import <QuartzCore/QuartzCore.h>

/*
public static final String ACCESS_TOKEN = "594322211-w7vS3SdFVveM4zlnJVBD7s2B8Up03HFap4DVVdxi";
public static final String SECRET_TOKEN = "WE4yyI4NO2lcoBVkpDtxU6mLp1Rqz5wbg4QykKOQ9vQ";*/

#define kOAuthConsumerKey 	@"gYEYnyFK2VaH9nlDZfTyA" //@"WyK9BCF9z4g1P8Vtjp5gng"
#define kOAuthConsumerSecret @"Kn5UNBeFWYYEVmgdBXBsklwkyTbOlsXCxNDm5kQ4E" //@"eps8BFg6xF0bjihYWyYXngiqfDFr1MJCaGW6fCnHc"

@interface  TwitterViewController(Private_Method)

- (NSString *)_queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed;
- (NSString *)_encodeString:(NSString *)string;
-(void)postTwitter;    
@end


@implementation TwitterViewController


@synthesize textString,twitterObj,accessToken,consumer;

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
    textView.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickBarBtn:)];
    barBtn.style = UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = barBtn;
    [barBtn release];
    
    textView.text = textString;
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
																	target:self action:@selector(clickBarBtn:)];      
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];*/
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"authData"]) {
        
        [self performSelector:@selector(makeAccessToken4Twitter)];
    }
    
    else{
        
        [self performSelector:@selector(callingTwitterView) withObject:nil afterDelay:2.0];

    }
        
    
    // Do any additional setup after loading the view from its nib.
}


-(void) makeAccessToken4Twitter
{
    self.consumer = [[OAConsumer alloc] initWithKey:kOAuthConsumerKey
                                             secret:kOAuthConsumerSecret
                                              realm:@"http://api.twitter.com/"];
    
    self.accessToken = [[OAToken alloc] initWithHTTPResponseBody:[defaults objectForKey:@"authData"]];
}

-(void)clickBarBtn:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}


-(void) callingTwitterView
{
    twitterObj = [[TwitterView alloc] initWithNibName:@"TwitterView" bundle:nil];
    twitterObj._delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:twitterObj];
    [self presentModalViewController:nav animated:YES];
    [nav release];
    [twitterObj release];
    
}




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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [bgImageView release];
    [textView release];
    [shareButton release];
    //[twitterObj release];
    [textString release];
    [accessToken release];
    [consumer release];
    [super dealloc];
}
- (IBAction)shareButtonAction:(id)sender {
    
    [self postTwitter];
}


-(void)postTwitter
{
	//NSString *myRequestString = [NSString stringWithFormat:@"<status>Test...</status>"];
	//NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];
    
    if ([InternetValidation checkNetworkStatus]) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.xml"];
        OAMutableURLRequest *request = 
        [[OAMutableURLRequest alloc] initWithURL:url
                                        consumer:self.consumer
                                           token:self.accessToken
                                        callback:nil
                               signatureProvider:nil];
        
        NSLog(@"consumer  %@  accesstoken  %@",self.consumer,self.accessToken);
        
        //[request setValue:@"json" forHTTPHeaderField:@"x-li-format"];
        [request setHTTPMethod:@"POST"];
        [request setValue:textView.text forHTTPHeaderField:@"status"];
        //[request setHTTPBody:myRequestData];
        //NSLog(@"Request: %@",[request description]);
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
        [params setObject:textView.text forKey:@"status"];
        NSString *myRequestString = [self _queryStringWithBase:nil parameters:params prefixed:NO];
        NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];
        [request setHTTPBody:myRequestData];
        
        OADataFetcher *fetcher = [[OADataFetcher alloc] init];
        [fetcher fetchDataWithRequest:request
                             delegate:self
                    didFinishSelector:@selector(twitteApiCallResult:didFinish:)
                      didFailSelector:@selector(twitteApiCallResult:didFail:)];    
        [request release];
    }
    else{
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert  show];
        [alert  release];
    }
	
}


#pragma mark - Twitter Delegate Call


- (void)twitteApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data 
{
	NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
	NSLog(@">>>>>>>>>>>%@",responseBody);
    
    if ([responseBody rangeOfString:@"created_at"].location != NSNotFound) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Successfully posted..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    if ([responseBody rangeOfString:@"error"].location != NSNotFound) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Sorry Something went wrong..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}


- (void)twitteApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error 
{
    NSLog(@"%@",[error description]);
	//[self stopIndicator];
}


- (NSString *)_queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed
{
    // Append base if specified.
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    if (base) {
        [str appendString:base];
    }
    
    // Append each name-value pair.
    if (params) {
        int i;
        NSArray *names = [params allKeys];
        for (i = 0; i < [names count]; i++) {
            if (i == 0 && prefixed) {
                [str appendString:@"?"];
            } else if (i > 0) {
                [str appendString:@"&"];
            }
            NSString *name = [names objectAtIndex:i];
            [str appendString:[NSString stringWithFormat:@"%@=%@", 
							   name, [self _encodeString:[params objectForKey:name]]]];
        }
    }
    
    return str;
}


- (NSString *)_encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
																		   (CFStringRef)string, 
																		   NULL, 
																		   (CFStringRef)@";/?:@&=$+{}<>,",
																		   kCFStringEncodingUTF8);
    return [result autorelease];
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


#pragma mark - TwitterView Delegates

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username
{
    NSLog(@"AUthDAta  %@",data);
    
    //NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
    
    [self performSelector:@selector(makeAccessToken4Twitter)];

    
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username
{
    return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}


- (void) twitterOAuthConnectionFailedWithData: (NSData *) data
{
    
}


@end
