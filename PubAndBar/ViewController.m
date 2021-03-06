//
//  ViewController.m
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MyPreferences.h"
#import "SignIn.h"
#import "Home.h"
#import "ContactHelp.h"

@implementation ViewController

//////////////////JHUMA//////////////////////
@synthesize vw;
@synthesize btn_search;
@synthesize btn_signup;
@synthesize btn_help;
@synthesize lbl_version;



AppDelegate *del;

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
    //self.view.backgroundColor = [UIColor grayColor];
    del = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //////////////////JHUMA//////////////////////
    
    vw.layer.borderWidth=1;
    vw.layer.borderColor=[UIColor lightGrayColor].CGColor;
    vw.layer.cornerRadius=10.0;
    lbl_version.layer.borderWidth=1;
    lbl_version.layer.borderColor=[UIColor lightGrayColor].CGColor;
    lbl_version.layer.cornerRadius=10.0;


}

- (void)viewDidUnload
{
    [btn_search release];
    btn_search = nil;
    [self setBtn_search:nil];
    [btn_signup release];
    btn_signup = nil;
    [self setBtn_signup:nil];
    [btn_help release];
    btn_help = nil;
    [self setBtn_help:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    self.mainNavigationView.hidden=YES;
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
}
-(IBAction)ClickSignUp:(id)sender{
    
     SignIn *obj_SignIn=[[SignIn alloc]initWithNibName:[Constant GetNibName:@"SignIn"] bundle:[NSBundle mainBundle]];
   //[self.presentModalViewController:obj_SignIn animated:YES];
    
    [self presentModalViewController:obj_SignIn animated:YES];
    
    //[obj_SignIn release];
    
    
}
-(IBAction)ClickSearch:(id)sender{
    Home *obj_Home=[[Home alloc]initWithNibName:[Constant GetNibName:@"Home"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_Home animated:YES];

    
}
-(IBAction)ClickHelp:(id)sender{
    
    ContactHelp *obj_ContactHelp=[[ContactHelp alloc]initWithNibName:[Constant GetNibName:@"ContactHelp"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_ContactHelp animated:YES];

    
}
-(IBAction)ClicksetMyPreference:(id)sender{
   
    MyPreferences *obj_mypreferences=[[MyPreferences alloc]initWithNibName:[Constant GetNibName:@"MyPreferences"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_mypreferences animated:YES];
    [obj_mypreferences release];
}

-(IBAction)ClickEnterWithoutPreference:(id)sender{
    NSLog(@"ClickEnterWithoutPreference");
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    Home *obj = [[Home alloc]initWithNibName:[Constant GetNibName:@"Home"] bundle:[NSBundle mainBundle]];
    delegate.homeView = obj;
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];
}

- (void)dealloc {
    [btn_search release];
   // [btn_search release];
    //[btn_signup release];
    [btn_signup release];
    //[btn_help release];
    [btn_help release];
    [super dealloc];
}
@end
