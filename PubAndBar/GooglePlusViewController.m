//
//  ViewController.m
//  TestGPPlus
//
//  Created by Arijit Da on 05/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GooglePlusViewController.h"

@implementation GooglePlusViewController
@synthesize vwWeb;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *str=@"<html><head><title>Share demo: Basic page</title><link rel='canonical' href='http://www.example.com' /><script type='text/javascript' src='https://apis.google.com/js/plusone.js'></script></head><body><g:plus action='share'></g:plus><br><br><hr><a href='https://plus.google.com/share?url={URL}' onclick='javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;'><img src='https://www.gstatic.com/images/icons/gplus-64.png' alt='Share on Google+'/></a></body></html>";
    [self.vwWeb loadHTMLString:str baseURL:nil];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType 
{
	NSURL *url = request.URL;
	NSString *urlString = url.absoluteString;
    NSLog(@"%@",urlString);
    /*
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
            if([urlString rangeOfString:@"user_refused"].location == NSNotFound){
                // User refused to allow our app access
                // Notify parent and close this view
                [[NSNotificationCenter defaultCenter] 
                 postNotificationName:@"loginViewDidFinish"        
                 object:self 
                 userInfo:nil];
            }
            
            [self dismissModalViewControllerAnimated:YES];
        }
    }
    */
 	return YES;
    
}


- (void)viewDidUnload
{
    [self setVwWeb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
}

- (void) cancel: (id) sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    // Return YES for supported orientations
   // return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [vwWeb release];
    [super dealloc];
}
@end
