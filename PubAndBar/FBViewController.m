//
//  FBViewController.m
//  PubAndBar
//
//  Created by MacMini10 on 16/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "FBViewController.h"
#import "InternetValidation.h"
#import <QuartzCore/QuartzCore.h>

@implementation FBViewController


@synthesize  hud = _hud;
@synthesize shareText;


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
    
    bgImage.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor darkTextColor];

    submitButton.layer.cornerRadius = 5.0;
    
    textVIew.returnKeyType = UIReturnKeyDone;
    textVIew.layer.cornerRadius = 5.0;
    textVIew.text = shareText;
    textVIew.delegate = self;
    [self.navigationController setNavigationBarHidden:NO];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonpressed:)];
    barBtn.style = UIBarButtonItemStyleBordered;
    self.navigationItem.leftBarButtonItem = barBtn;
    [barBtn release];
    
    
    [self performSelector:@selector(addMBHud) withObject:nil afterDelay:.5];
    [self performSelector:@selector(CallingForFacebook) withObject:nil afterDelay:1.5];
    
    // Do any additional setup after loading the view from its nib.
}


-(void) cancelButtonpressed:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitButtonAction:(id)sender
{
    NSString *str=[NSString stringWithFormat:@"%@",textVIew.text];

    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Pub & Bar Network", @"name",
     //@"I just shared video with Spin TV.",@"caption",
     //@"www.facebook.com/tinge",@"link",
     str,@"message",
     //@"www.pub", @"href",
     nil];  


    //    @"Spin TV", @"name",
    //    @"I just shared story with Spin TV.",@"caption",
    //    str,@"description",
    //    @"www.facebook.com/tinge", @"link",

    //NSLog(@"params    %@",params);
    //[episode valueForKey:@"episodeVideo"], @"link",
    //    [NSMutableDictionary dictionaryWithObjectsAndKeys:
    //     @"http://developers.facebook.com/docs/reference/dialogs/", @"link",
    //     @"http://fbrell.com/f8.jpg", @"picture",
    //     @"Facebook Dialogs", @"name",
    //     @"Reference Documentation", @"caption",
    //     @"Dialogs provide a simple, consistent interface for apps to interact with users.", @"description",
    //     @"Facebook Dialogs are so easy!",  @"message",
    //     nil];


    //[self performSelector:@selector(addMBHud)];
    // [self performSelector:@selector(CallingForPostToFacebook) withObject:nil afterDelay:0.5];
    if([InternetValidation  checkNetworkStatus])
    {
        
        [[FacebookController sharedInstance] postToFacebook:params];
    }
    else
    {
        //[self performSelector:@selector(dismissHUD:)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert  show];
        [alert  release];
    }
}

-(void) CallingForFacebook
{
    if([InternetValidation  checkNetworkStatus])
    {
        
        [[FacebookController sharedInstance] setFbDelegate:self];
        [[FacebookController sharedInstance] initialize];
    }
    else
    {
        //[self performSelector:@selector(dismissHUD:)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert  show];
        [alert  release];
    }
    
    
}


#pragma mark -
#pragma mark - Facebook Delegate

-(void)GetFBData:(id)data
{
    //NSLog(@"FBData   %@",data);
    //[self performSelector:@selector(dismissHUD:)];
    if ([data objectForKey:@"id"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Successfully posted..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}
-(void)RequestError:(NSError *)err
{
    NSLog(@"Error  %@",[err description]);
    
    if(err!=nil)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Sorry! Something went wrong ..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}


- (void)FBLoginDone :(id) objectDictionay
{
    NSLog(@"DIC  %@",objectDictionay);
    [self performSelector:@selector(dismissHUD:)];
}


#pragma mark -
#pragma mark - Dismiss Hud

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
    
}


-(void) addMBHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = @"Loading...";
    
}


#pragma  mark -
#pragma  mark - textviewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];       
        
    }
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
	/*CGRect viewFrame = self.view.frame;
	viewFrame.origin.y -= 50;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	[self.view setFrame:viewFrame];
	[UIView commitAnimations];*/
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    /*CGRect viewFrame = self.view.frame;
    if (viewFrame.origin.y < 0.0) {
        
        viewFrame.origin.y += 50;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }*/
    
}




- (void)viewDidUnload
{
    [bgImage release];
    bgImage = nil;
    [textVIew release];
    textVIew = nil;
    [submitButton release];
    submitButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [_hud release];
    _hud = nil;
    [bgImage release];
    [textVIew release];
    [submitButton release];
    [shareText release];
    [super dealloc];
}



@end
