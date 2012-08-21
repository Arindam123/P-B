//
//  DetailViewController.m
//  DemoSocialNetwork
//
//  Created by MacMini10 on 05/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "TwitterViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize  oAuthLoginView;


@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize nextButton = _nextButton;
@synthesize postButton = _postButton;

- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [_nextButton release];
    [_postButton release];
    [twitterButton release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

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
    [self configureView];
}

- (void)viewDidUnload
{
    [self setNextButton:nil];
    [self setPostButton:nil];
    [twitterButton release];
    twitterButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
- (IBAction)nextButtonAction:(id)sender {
    
    /*TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];*/
    oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loginViewDidFinish:) 
                                                 name:@"loginViewDidFinish" 
                                               object:oAuthLoginView];
    [self presentModalViewController:oAuthLoginView animated:YES];
}

- (IBAction)postButtonAction:(id)sender {
    [oAuthLoginView testApiForPostingMessage:nil];

}

- (IBAction)twitterButtonAction:(id)sender {
    
    TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}


#pragma mark
#pragma mark LinkedIN Delegates


-(void) loginViewDidFinish:(NSNotification*)notification
{
        
    /*[oAuthLoginView release];
     oAuthLoginView = nil;*/
}


@end
