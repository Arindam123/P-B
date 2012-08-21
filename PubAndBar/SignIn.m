//
//  SignIn.m
//  PubAndBar
//
//  Created by Apple on 04/07/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SignIn.h"
#import "SignUp.h"
#import "Constant.h"
#import "URLRequestString.h"
#import "Home.h"
#import "InternetValidation.h"

@implementation SignIn
@synthesize btn_cancel;
@synthesize txt_Email;
@synthesize txt_Password;
@synthesize btn_signUp;
@synthesize btn_signin;
@synthesize ScrollVw;


@interface SignUp(Private_Methods)

-(void)signUp:(NSString *)_mailID 
     password:(NSString *)_password;

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
    txt_Email.backgroundColor=[UIColor clearColor];
    txt_Password.backgroundColor=[UIColor clearColor];
    txt_Email.borderStyle=NO;
    txt_Password.borderStyle=NO;
    ScrollVw.contentSize=CGSizeMake(320, 620);
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    
}
-(BOOL) validateEmail: (NSString *)Email {
    NSString *emailRegex = @"[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex]; 
    return [emailTest evaluateWithObject:Email];
    
}


-(IBAction)ClickCancel:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}




-(IBAction)ClickSignUp:(id)sender{
    
     if([[app.SaveSignIn valueForKey:@"success"]isEqualToString:@"success"]){
       
       UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Already Sign in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       alert1.tag=11;
       [alert1 show];
       [alert1 release];
       
   }
    
    
   else{ 
    
    SignUp *obj_SignUp=[[SignUp alloc]initWithNibName:[Constant GetNibName:@"SignUp"] bundle:[NSBundle mainBundle]];
    //[self.presentModalViewController:obj_SignIn animated:YES];
    
    [self presentModalViewController:obj_SignUp animated:YES];
    
    [obj_SignUp release];
   }
    
    
}

-(IBAction)ClickSignin:(id)sender{
    
    if([[app.SaveSignIn valueForKey:@"success"]isEqualToString:@"success"]){
        
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Already Sign in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=11;
        [alert1 show];
        [alert1 release];
        
    }
    else{
    
    
    if ([txt_Email.text isEqualToString:@""] || [txt_Password.text isEqualToString:@""]) {
        
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Please fill up all required field." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
               
        
        [self signUp:txt_Email.text password:txt_Password.text];
       
        
        
      /*  UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully Sign in.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=10;
        [alert1 show];
        [alert1 release];*/
        
    }

    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==10){
        if(buttonIndex==0){
            [self dismissModalViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Sign In Done" object:self];            
            
           /* Home *obj_Home=[[Home alloc]initWithNibName:[Constant GetNibName:@"Home"] bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:obj_Home animated:YES];*/
            

            
        }
    }
}

-(void)MoveHome{
    
    
}

-(void)signUp:(NSString *)_mailID password:(NSString *)_password 
{
    if([InternetValidation  checkNetworkStatus])
    {
    
    
    NSString *post = [NSString stringWithFormat:@"emailid=%@&password=%@",_mailID,_password];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    
    [request setURL:[NSURL URLWithString:SignInURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"%@",returnData);
    
    Content_jsonData=[[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"%@",Content_jsonData);
    if([Content_jsonData isEqualToString:@"success"]){
         app =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.SaveSignIn setValue:Content_jsonData forKey:@"success"];
        [app.SaveSignIn synchronize];
        
        NSLog(@"%@",Content_jsonData);
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully Sign in.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert1.tag=10;
    [alert1 show];
        [alert1 release];
    }
    else
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Enter correct Email ID & Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==txt_Email) {
        [txt_Email resignFirstResponder];
        //[txt_Password becomeFirstResponder];
        [ScrollVw setContentOffset:CGPointMake(0, 40)animated:YES];
        //return YES;
    }
    
    else if (textField==txt_Password) {
        [txt_Password resignFirstResponder];
        [ScrollVw setContentOffset:CGPointMake(0, 0)animated:YES];
        //return YES;
    }
        return YES;   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==txt_Email)
        [ScrollVw setContentOffset:CGPointMake(0, 40)animated:YES];
    else if (textField==txt_Password)
        [ScrollVw setContentOffset:CGPointMake(0, 80)animated:YES];
        
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




- (void)viewDidUnload
{
    [txt_Email release];
    txt_Email = nil;
    [txt_Password release];
    txt_Password = nil;
    [btn_signUp release];
    btn_signUp = nil;
    [btn_signin release];
    btn_signin = nil;
    [ScrollVw release];
    ScrollVw = nil;
    [btn_cancel release];
    btn_cancel = nil;
  
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
    [txt_Email release];
    [txt_Password release];
    [btn_signin release];
    [ScrollVw release];
    [btn_cancel release];
    [btn_signUp release];
    [super dealloc];
}
@end
