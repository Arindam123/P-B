//
//  SignUp.m
//  PubAndBar
//
//  Created by Apple on 03/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SignUp.h"
#import "URLRequestString.h"
#import "SignIn.h"
#import "Constant.h"
#import "InternetValidation.h"

@implementation SignUp
@synthesize btn_cancel;
@synthesize Create_Profile;
@synthesize txt_FirstName;
@synthesize txt_LastName;
@synthesize txt_Email;
@synthesize txt_Password;
@synthesize txt_Location;


@interface SignUp(Private_Methods)

-(void)signUp:(NSString *)_deviceID 
         name:(NSString *)name 
       mailID:(NSString *)_mailID 
     password:(NSString *)_password 
     lastName:(NSString *)_lastName 
     location:(NSString *)_location;

@end




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
    txt_FirstName.backgroundColor=[UIColor clearColor];
    txt_LastName.backgroundColor=[UIColor clearColor];
    txt_Email.backgroundColor=[UIColor clearColor];
    txt_Password.backgroundColor=[UIColor clearColor];
    txt_Location.backgroundColor=[UIColor clearColor];
    txt_FirstName.borderStyle=NO;
    txt_LastName.borderStyle=NO;
    txt_Email.borderStyle=NO;
    txt_Password.borderStyle=NO;
    txt_Location.borderStyle=NO;
    
    scrll.contentSize=CGSizeMake(320, 550);
    scrll.scrollEnabled=YES;
    
}
-(BOOL) validateEmail: (NSString *)Email {
    NSString *emailRegex = @"[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex]; 
    return [emailTest evaluateWithObject:Email];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==txt_FirstName) {
        [txt_FirstName resignFirstResponder];
        //[txt_LastName becomeFirstResponder];
       // [scrll setContentOffset:CGPointMake(0, 40)animated:YES];
        //return YES;
    }
    
    else if (textField==txt_LastName) {
        [txt_LastName resignFirstResponder];
         //[txt_Email becomeFirstResponder];
       // [scrll setContentOffset:CGPointMake(0, 50)animated:YES];
        //return YES;
    }
    else if (textField==txt_Email) {
        [txt_Email resignFirstResponder];
        //[txt_Password becomeFirstResponder];
       // [scrll setContentOffset:CGPointMake(0, 100)animated:YES];
        //return YES;
    }
    else if (textField==txt_Password) {
        [txt_Password resignFirstResponder];
       // [txt_Location becomeFirstResponder];
       
        //return YES;
    }
   else if (textField==txt_Location) {
     [txt_Location resignFirstResponder];
        [scrll setContentOffset:CGPointMake(0, 0)animated:YES];
 }

    return YES;   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
   if (textField==txt_FirstName) 
        [scrll setContentOffset:CGPointMake(0, 10)animated:YES];
    else if (textField==txt_LastName)
        [scrll setContentOffset:CGPointMake(0, 50)animated:YES];
    else if (textField==txt_Email)
        [scrll setContentOffset:CGPointMake(0, 90)animated:YES];

    else if (textField==txt_Password)
        [scrll setContentOffset:CGPointMake(0, 120)animated:YES];
    else if (textField==txt_Location)
        [scrll setContentOffset:CGPointMake(0, 150)animated:YES];

    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text=nil;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    ;
}


-(IBAction)ClickCancel:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}
-(IBAction)CreateProfile:(id)sender{
    
    if ([txt_FirstName.text isEqualToString:@""] || [txt_LastName.text isEqualToString:@""] || [txt_Email.text isEqualToString:@""] || [txt_Password.text isEqualToString:@""] || [txt_Location.text isEqualToString:@""]) {
        
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Please fill up all required field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=11;
        [alert1 show];
        [alert1 release];
        
    }
    
    else if(([self validateEmail:txt_Email.text]==NO))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Please enter valid Email Id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }

    
    else{

    
    [self signUp:[UIDevice currentDevice].uniqueIdentifier name:txt_FirstName.text mailID:txt_Email.text password:txt_Password.text lastName:txt_LastName.text location:txt_Location.text];
    
        
      /*  UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully Sign up.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=10;
        [alert1 show];
        [alert1 release];*/
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==10){
    if(buttonIndex==0){
         [self dismissModalViewControllerAnimated:YES];
     /*   SignIn *obj_SignIn=[[SignIn alloc]initWithNibName:[Constant GetNibName:@"SignIn"] bundle:[NSBundle mainBundle]];
        //[self.presentModalViewController:obj_SignIn animated:YES];
        
        [self presentModalViewController:obj_SignIn animated:YES];*/

    }
    }
}

-(void)signUp:(NSString *)_deviceID 
         name:(NSString *)name 
       mailID:(NSString *)_mailID 
     password:(NSString *)_password 
     lastName:(NSString *)_lastName 
     location:(NSString *)_location 




{
    if([InternetValidation  checkNetworkStatus])
    {
   
    
    NSString *post = [NSString stringWithFormat:@"appid=%@&name=%@&emailid=%@&password=%@&lastName=%@&location=%@",_deviceID,name,_mailID,_password,_lastName,_location];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    
    [request setURL:[NSURL URLWithString:SignUpURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"%@",returnData);
    
    NSString *Content_jsonData=[[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"%@",Content_jsonData);
    if([Content_jsonData isEqualToString:@"success"]){
         app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [app.Savedata setValue:txt_FirstName.text forKey:@"SignUp_FirstName"];
        [app.Savedata setValue:txt_LastName.text forKey:@"SignUp_LastName"];
        [app.Savedata setValue:txt_Email.text forKey:@"SignUp_Email"];
        [app.Savedata setValue:txt_Password.text forKey:@"SignUp_Password"];
        [app.Savedata setValue:txt_Location.text forKey:@"SignUp_Location"];
        
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully Sign up.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=10;
        [alert1 show];
        [alert1 release];
    }
    else
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Enter correct Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=12;
        [alert1 show];
        [alert1 release];
    }
    }
    else
    {
        //[self performSelector:@selector(dismissHUD:)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }
    
    
}


- (void)viewDidUnload
{
    [btn_cancel release];
    btn_cancel = nil;
    [Create_Profile release];
    Create_Profile = nil;
    [txt_FirstName release];
    txt_FirstName = nil;
    [txt_LastName release];
    txt_LastName = nil;
    [txt_Email release];
    txt_Email = nil;
    [txt_Password release];
    txt_Password = nil;
    [txt_Location release];
    txt_Location = nil;
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
    [Create_Profile release];
    [txt_FirstName release];
    [txt_LastName release];
    [txt_Email release];
    [txt_Location release];
    [txt_Password release];
   
    [btn_cancel release];
    [super dealloc];
}
@end
