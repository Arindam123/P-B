//
//  TwitterViewController.m
//  TestTwitter
//


#import "TwitterView.h"
//#import "Constants.h"

#define kOAuthConsumerKey 	@"gYEYnyFK2VaH9nlDZfTyA" //@"WyK9BCF9z4g1P8Vtjp5gng"
#define kOAuthConsumerSecret @"Kn5UNBeFWYYEVmgdBXBsklwkyTbOlsXCxNDm5kQ4E" //@"eps8BFg6xF0bjihYWyYXngiqfDFr1MJCaGW6fCnHc"

@implementation TwitterView

@synthesize requestToken, accessToken, profile, consumer;
@synthesize _delegate;

//
// OAuth step 1a:
//
// The first step in the the OAuth process to make a request for a "request token".
// Yes it's confusing that the work request is mentioned twice like that, but it is whats happening.
//
- (void)requestTokenFromProvider
{
    OAMutableURLRequest *request = 
	[[[OAMutableURLRequest alloc] initWithURL:requestTokenURL
									 consumer:self.consumer
										token:nil   
									 callback:linkedInCallbackURL
							signatureProvider:nil] autorelease];
    
    [request setHTTPMethod:@"POST"];   
    OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(requestTokenResult:didFinish:)
                  didFailSelector:@selector(requestTokenResult:didFail:)];    
}

//
// OAuth step 1b:
//
// When this method is called it means we have successfully received a request token.
// We then show a webView that sends the user to the LinkedIn login page.
// The request token is added as a parameter to the url of the login page.
// LinkedIn reads the token on their end to know which app the user is granting access to.
//
- (void)requestTokenResult:(OAServiceTicket *)ticket didFinish:(NSData *)data 
{
    //if (ticket.didSucceed == NO) 
	//        return;
	
    NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    self.requestToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
    [responseBody release];
    [self allowUserToLogin];
	//NSLog(@">>>>>>>>>>>%@",responseBody);
}

- (void)requestTokenResult:(OAServiceTicket *)ticket didFail:(NSData *)error 
{
    NSLog(@"%@",[error description]);
}

//
// OAuth step 2:
//
// Show the user a browser displaying the LinkedIn login page.
// They type username/password and this is how they permit us to access their data
// We use a UIWebView for this.
//
// Sending the token information is required, but in this one case OAuth requires us
// to send URL query parameters instead of putting the token in the HTTP Authorization
// header as we do in all other cases.
//
- (void)allowUserToLogin
{
    NSString *userLoginURLWithToken = [NSString stringWithFormat:@"%@?oauth_token=%@", 
									   userLoginURLString, self.requestToken.key];
    
    userLoginURL = [NSURL URLWithString:userLoginURLWithToken];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL: userLoginURL];
    [webView loadRequest:request];     
}


//
// OAuth step 3:
//
// This method is called when our webView browser loads a URL, this happens 3 times:
//
//      a) Our own [webView loadRequest] message sends the user to the LinkedIn login page.
//
//      b) The user types in their username/password and presses 'OK', this will submit
//         their credentials to LinkedIn
//
//      c) LinkedIn responds to the submit request by redirecting the browser to our callback URL
//         If the user approves they also add two parameters to the callback URL: oauth_token and oauth_verifier.
//         If the user does not allow access the parameter user_refused is returned.
//
//      Example URLs for these three load events:
//          a) https://www.linkedin.com/uas/oauth/authorize?oauth_token=<token value>
//
//          b) https://www.linkedin.com/uas/oauth/authorize/submit   OR
//             https://www.linkedin.com/uas/oauth/authenticate?oauth_token=<token value>&trk=uas-continue
//
//          c) hdlinked://linkedin/oauth?oauth_token=<token value>&oauth_verifier=63600     OR
//             hdlinked://linkedin/oauth?user_refused
//             
//
//  We only need to handle case (c) to extract the oauth_verifier value
//
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType 
{
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
    
	activityIndicator.hidden=NO;
    [activityIndicator startAnimating];
    
    BOOL requestForCallbackURL = ([urlString rangeOfString:linkedInCallbackURL].location != NSNotFound);
    if ( requestForCallbackURL )
    {
        BOOL userAllowedAccess = ([urlString rangeOfString:@"user_refused"].location == NSNotFound);
        if ( userAllowedAccess )
        {            
            [self.requestToken setVerifierWithUrl:url];
            [self accessTokenFromProvider];
        }
        else
        {
            // User refused to allow our app access
            // Notify parent and close this view
            [[NSNotificationCenter defaultCenter] 
			 postNotificationName:@"loginViewDidFinish"        
			 object:self 
			 userInfo:nil];
			
            [self dismissModalViewControllerAnimated:YES];
        }
    }
    else
    {
        // Case (a) or (b), so ignore it
    }
	return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
	activityIndicator.hidden=YES;
}

//
// OAuth step 4:
//
- (void)accessTokenFromProvider
{ 
    OAMutableURLRequest *request = 
	[[[OAMutableURLRequest alloc] initWithURL:accessTokenURL
									 consumer:self.consumer
										token:self.requestToken   
									 callback:nil
							signatureProvider:nil] autorelease];
    
    [request setHTTPMethod:@"POST"];
    OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(accessTokenResult:didFinish:)
                  didFailSelector:@selector(accessTokenResult:didFail:)];    
}

- (void)accessTokenResult:(OAServiceTicket *)ticket didFinish:(NSData *)data 
{
    NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    
    BOOL problem = ([responseBody rangeOfString:@"oauth_problem"].location != NSNotFound);
    if ( problem )
    {
        NSLog(@"Request access token failed.");
        NSLog(@"%@",responseBody);
    }
    else
    {
        self.accessToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
    }
	
	
	NSString *username = [self extractUsernameFromHTTPBody:responseBody];
    
	if (username.length > 0) {
		if ([_delegate respondsToSelector: @selector(storeCachedTwitterOAuthData:forUsername:)]) 
            [_delegate storeCachedTwitterOAuthData:responseBody forUsername:username];
	}
    
	NSLog(@">>>>>>>>>>%@",responseBody);
    
    
    // Notify parent and close this view
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:@"loginViewDidFinish"        
     object:self];
    
    [self dismissModalViewControllerAnimated:YES];
    [responseBody release];
}

//
//  This api consumer data could move to a provider object
//  to allow easy switching between LinkedIn, Twitter, etc.
//
- (void)initTwitterInApi
{
    apikey = kOAuthConsumerKey;
    secretkey = kOAuthConsumerSecret;   
	
    self.consumer = [[OAConsumer alloc] initWithKey:apikey
											 secret:secretkey
											  realm:@"http://api.twitter.com/"];
	
    requestTokenURLString = @"https://api.twitter.com/oauth/request_token";
    accessTokenURLString = @"https://api.twitter.com/oauth/access_token";
    userLoginURLString = @"https://api.twitter.com/oauth/authorize";    
    linkedInCallbackURL = @"hdlinked://twitter/oauth";
    
    requestTokenURL = [[NSURL URLWithString:requestTokenURLString] retain];
    accessTokenURL = [[NSURL URLWithString:accessTokenURLString] retain];
    userLoginURL = [[NSURL URLWithString:userLoginURLString] retain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title=@"Twitter";
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
																	target:self action:@selector(clickBarBtn:)];      
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
    [self initTwitterInApi];
    
}


-(void)clickBarBtn:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
	
	NSLog(@"Api Key:%@		Secret Key:%@",apikey,secretkey);
    //if ([apikey length] < 64 || [secretkey length] < 64)
	//    {
	//        UIAlertView *alert = [[UIAlertView alloc]
	//                          initWithTitle: @"OAuth Starter Kit"
	//                          message: @"You must add your apikey and secretkey.  See the project file readme.txt"
	//                          delegate: nil
	//                          cancelButtonTitle:@"OK"
	//                          otherButtonTitles:nil];
	//        [alert show];
	//        [alert release];
	//        
	//        // Notify parent and close this view
	//        [[NSNotificationCenter defaultCenter] 
	//         postNotificationName:@"loginViewDidFinish"        
	//         object:self];
	//        
	//        [self dismissModalViewControllerAnimated:YES];
	//    }
	
    [self requestTokenFromProvider];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}


- (NSString *) extractUsernameFromHTTPBody: (NSString *) body {
	if (!body) return nil;
	
	NSArray					*tuples = [body componentsSeparatedByString: @"&"];
	if (tuples.count < 1) return nil;
	
	for (NSString *tuple in tuples) {
		NSArray *keyValueArray = [tuple componentsSeparatedByString: @"="];
		
		if (keyValueArray.count == 2) {
			NSString				*key = [keyValueArray objectAtIndex: 0];
			NSString				*value = [keyValueArray objectAtIndex: 1];
			
			if ([key isEqualToString:@"screen_name"]) return value;
		}
	}
	
	return nil;
}


- (BOOL) isAuthorized {	
	if (self.accessToken.key && self.accessToken.secret) return YES;
	
	//first, check for cached creds
//	NSString					*accessTokenString = [_delegate respondsToSelector: @selector(cachedTwitterOAuthDataForUsername:)] ? [(id) _delegate cachedTwitterOAuthDataForUsername:self.username] : @"";
//    
//    	if (accessTokenString.length) {				
//    		[self.accessToken release];
//    		self.accessToken = [[OAToken alloc] initWithHTTPResponseBody: accessTokenString];
//    		//[self setUsername: [self extractUsernameFromHTTPBody: accessTokenString] password: nil];
//    		if (self.accessToken.key && self.accessToken.secret) return YES;
//    	}
//    	
//    	[self.accessToken release];										// no access token found.  create a new empty one
//	self.accessToken = [[OAToken alloc] initWithKey: nil secret: nil];
	return NO;
}


@end
