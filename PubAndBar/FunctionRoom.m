//
//  FunctionRoom.m
//  PubAndBar
//
//  Created by User7 on 30/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "FunctionRoom.h"
#import "Toolbar.h"
#import "ServerConnection.h"
#import "URLRequestString.h"

@implementation FunctionRoom
@synthesize backButton;
@synthesize lbl_heading;
@synthesize scrw;
@synthesize lbl_content;
@synthesize lbl_1st;
@synthesize lbl_2nd;
@synthesize lbl_3rd;
@synthesize lbl_4th;
@synthesize lbl_5th;
@synthesize lbl_6th;
@synthesize lbl_7th;
@synthesize lbl_8th;
@synthesize lbl_9th;
@synthesize lbl_10th;
@synthesize txt_1st;
@synthesize txt_2nd;
@synthesize txt_3rd;
@synthesize txt_4th;
@synthesize txt_5th;
@synthesize txt_6th;
@synthesize txt_7th;
@synthesize txt_8th;
@synthesize txt_9th;
@synthesize txt_view;
@synthesize btn_submit; 

@synthesize oAuthLoginView;


Toolbar *_Toolbar;
AppDelegate *app;

 int  height =10;

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
    self.view.frame = CGRectMake(0, 0, 320, 395);
    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _Toolbar = [[[Toolbar alloc]init]autorelease];
    _Toolbar.layer.borderWidth = 1.0f;
    [self.view addSubview:_Toolbar];

    [self CreateView];
    
}

-(void)CreateView{
    
    scrw = [[UIScrollView alloc]init];
    scrw.backgroundColor = [UIColor clearColor];
    
    req1=[[UILabel alloc]init];
    req1.backgroundColor=[UIColor clearColor];
    req1.text=@"(required)";
    req1.textColor=[UIColor whiteColor];
    req1.font = [UIFont boldSystemFontOfSize:10];
    req1.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req1];
    
    req2=[[UILabel alloc]init];
    req2.backgroundColor=[UIColor clearColor];
    req2.text=@"(required)";
    req2.textColor=[UIColor whiteColor];
    req2.font = [UIFont boldSystemFontOfSize:10];
    req2.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req2];
    
    req3=[[UILabel alloc]init];
    req3.backgroundColor=[UIColor clearColor];
    req3.text=@"(required)";
    req3.textColor=[UIColor whiteColor];
    req3.font = [UIFont boldSystemFontOfSize:10];
    req3.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req3];
    
    req4=[[UILabel alloc]init];
    req4.backgroundColor=[UIColor clearColor];
    req4.text=@"(required)";
    req4.textColor=[UIColor whiteColor];
    req4.font = [UIFont boldSystemFontOfSize:10];
    req4.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req4];
    
    req5=[[UILabel alloc]init];
    req5.backgroundColor=[UIColor clearColor];
    req5.text=@"(required)";
    req5.textColor=[UIColor whiteColor];
    req5.font = [UIFont boldSystemFontOfSize:10];
    req5.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req5];
    
    req6=[[UILabel alloc]init];
    req6.backgroundColor=[UIColor clearColor];
    req6.text=@"(required)";
    req6.textColor=[UIColor whiteColor];
    req6.font = [UIFont boldSystemFontOfSize:10];
    req6.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req6];
    
    req7=[[UILabel alloc]init];
    req7.backgroundColor=[UIColor clearColor];
    req7.text=@"(required)";
    req7.textColor=[UIColor whiteColor];
    req7.font = [UIFont boldSystemFontOfSize:10];
    req7.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req7];
    
    
    req8=[[UILabel alloc]init];
    req8.backgroundColor=[UIColor clearColor];
    req8.text=@"(required)";
    req8.textColor=[UIColor whiteColor];
    req8.font = [UIFont boldSystemFontOfSize:10];
    req8.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req8];
    
    req9=[[UILabel alloc]init];
    req9.backgroundColor=[UIColor clearColor];
    req9.text=@"(required)";
    req9.textColor=[UIColor whiteColor];
    req9.font = [UIFont boldSystemFontOfSize:10];
    req9.textAlignment=UITextAlignmentCenter;
    [scrw addSubview:req9];
    
        
    lbl_heading = [[UILabel alloc]init];
    lbl_heading.backgroundColor = [UIColor clearColor];
    lbl_heading.text = @"Function Rooms";
    lbl_heading.textColor = [UIColor whiteColor];
    lbl_heading.font = [UIFont boldSystemFontOfSize:15];
    lbl_heading.textAlignment=UITextAlignmentCenter;
    
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackWhiteButton.png"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.view addSubview:backButton];
    
    lbl_content =[[UILabel alloc]init];
    lbl_content.text = @"Complete this form and we will complete the search for you manually.Please to aquire that we will send to all venues that reach your criteria.So,could personally mean a lot of patience,calls from licenses.You may choose to leave out your phone number if this is .........";
    lbl_content.numberOfLines = 10;
    lbl_content.backgroundColor = [UIColor clearColor];
    lbl_content.font = [UIFont boldSystemFontOfSize:10];
    lbl_content.textColor = [UIColor whiteColor];
    lbl_content.lineBreakMode = UILineBreakModeWordWrap;
    
    lbl_1st = [[UILabel alloc]init];
    lbl_1st.text = @"Location:";
    lbl_1st.textColor = [UIColor whiteColor];
    lbl_1st.font = [UIFont boldSystemFontOfSize:10];
    lbl_1st.backgroundColor = [UIColor clearColor];
    
    lbl_2nd = [[UILabel alloc]init];
    lbl_2nd.text = @"How many people in your function for?";
    lbl_2nd.textColor = [UIColor whiteColor];
    lbl_2nd.numberOfLines = 3;
    lbl_2nd.font = [UIFont boldSystemFontOfSize:10];
    lbl_2nd.backgroundColor = [UIColor clearColor];
    lbl_2nd.lineBreakMode = UILineBreakModeWordWrap;
    
    lbl_3rd = [[UILabel alloc]init];
    lbl_3rd.text = @"Purpose of event:";
    lbl_3rd.textColor = [UIColor whiteColor];
    lbl_3rd.numberOfLines = 2;
    lbl_3rd.font = [UIFont boldSystemFontOfSize:10];
    lbl_3rd.backgroundColor = [UIColor clearColor];
    lbl_3rd.lineBreakMode = UILineBreakModeWordWrap;
    
    lbl_4th = [[UILabel alloc]init];
    lbl_4th.text = @"Date and Duration:";
    lbl_4th.textColor = [UIColor whiteColor];
    lbl_4th.numberOfLines = 3;
    lbl_4th.lineBreakMode = UILineBreakModeWordWrap;
    lbl_4th.font = [UIFont boldSystemFontOfSize:10];
    lbl_4th.backgroundColor = [UIColor clearColor];
    
    lbl_5th = [[UILabel alloc]init];
    lbl_5th.text = @"Do you require to Do?";
    lbl_5th.numberOfLines = 3;
    lbl_5th.lineBreakMode = UILineBreakModeWordWrap;
    lbl_5th.textColor = [UIColor whiteColor];
    lbl_5th.font = [UIFont boldSystemFontOfSize:10];
    lbl_5th.backgroundColor = [UIColor clearColor];
    
    
    lbl_6th = [[UILabel alloc]init];
    lbl_6th.text = @"Any other requirements:";
    lbl_6th.numberOfLines = 3;
    lbl_6th.lineBreakMode = UILineBreakModeWordWrap;
    lbl_6th.textColor = [UIColor whiteColor];
    lbl_6th.font = [UIFont boldSystemFontOfSize:10];
    lbl_6th.backgroundColor = [UIColor clearColor];
    
    lbl_7th = [[UILabel alloc]init];
    lbl_7th.text = @"Your Name:";
    lbl_7th.numberOfLines = 3;
    lbl_7th.lineBreakMode = UILineBreakModeWordWrap;
    lbl_7th.textColor = [UIColor whiteColor];
    lbl_7th.font = [UIFont boldSystemFontOfSize:10];
    lbl_7th.backgroundColor = [UIColor clearColor];
    
    lbl_8th = [[UILabel alloc]init];
    lbl_8th.text = @"Your email address:";
    lbl_8th.numberOfLines = 2;
    lbl_8th.textColor = [UIColor whiteColor];
    lbl_8th.font = [UIFont boldSystemFontOfSize:10];
    lbl_8th.backgroundColor = [UIColor clearColor];
    
    lbl_9th = [[UILabel alloc]init];
    lbl_9th.text = @"Confirm Email:";
    lbl_9th.textColor = [UIColor whiteColor];
    lbl_9th.font = [UIFont boldSystemFontOfSize:10];
    lbl_9th.backgroundColor = [UIColor clearColor];
    
    lbl_10th = [[UILabel alloc]init];
    lbl_10th.text = @"Confirm Telephone number:";
    lbl_10th.numberOfLines = 3;
    lbl_10th.lineBreakMode = UILineBreakModeWordWrap;
    lbl_10th.textColor = [UIColor whiteColor];
    lbl_10th.font = [UIFont boldSystemFontOfSize:10];
    lbl_10th.backgroundColor = [UIColor clearColor];
    
    txt_1st = [[UITextField alloc]init];
    txt_1st.backgroundColor = [UIColor whiteColor];
    txt_1st.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_1st.delegate=self;
    
    txt_2nd = [[UITextField alloc]init];
    txt_2nd.backgroundColor = [UIColor whiteColor];
    txt_2nd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_2nd.delegate=self;
    
    txt_3rd = [[UITextField alloc]init];
    txt_3rd.backgroundColor = [UIColor whiteColor];
    txt_3rd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_3rd.delegate=self;
    
    txt_4th = [[UITextField alloc]init];
    txt_4th.backgroundColor = [UIColor whiteColor];
    txt_4th.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_4th.delegate=self;
    
    txt_5th = [[UITextField alloc]init];
    txt_5th.backgroundColor = [UIColor whiteColor];
    txt_5th.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_5th.delegate=self;
    
    txt_view = [[UITextView alloc]init];
    txt_view.backgroundColor = [UIColor whiteColor];
    txt_view.layer.cornerRadius = 3;
    txt_view.delegate=self;
    
    txt_6th = [[UITextField alloc]init];
    txt_6th.backgroundColor = [UIColor whiteColor];
    txt_6th.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_6th.delegate=self;
    
    txt_7th = [[UITextField alloc]init];
    txt_7th.backgroundColor = [UIColor whiteColor];
    txt_7th.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_7th.delegate=self;
    
    txt_8th = [[UITextField alloc]init];
    txt_8th.backgroundColor = [UIColor whiteColor];
    txt_8th.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_8th.delegate=self;
    
    txt_9th = [[UITextField alloc]init];
    txt_9th.backgroundColor = [UIColor whiteColor];
    txt_9th.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txt_9th.delegate=self;
   

    btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_submit.backgroundColor = [UIColor whiteColor];
    [btn_submit setTitle:@"Submit" forState:UIControlStateNormal];
    [btn_submit addTarget:self action:@selector(Click_submitbtn:) forControlEvents:UIControlEventTouchUpInside];
    btn_submit.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn_submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_submit.layer.cornerRadius = 3;
       
    [self setViewFrame];
    [self.view addSubview:scrw];
    [self.view addSubview:lbl_content];
    [self.view addSubview:backButton];
    [self.view addSubview:lbl_heading];
    [scrw addSubview:lbl_1st];
    [scrw addSubview:lbl_2nd];
    [scrw addSubview:lbl_3rd];
    [scrw addSubview:lbl_4th];
    [scrw addSubview:lbl_5th];
    [scrw addSubview:lbl_6th];
    [scrw addSubview:lbl_7th];
    [scrw addSubview:lbl_8th];
    [scrw addSubview:lbl_9th];
    [scrw addSubview:lbl_10th];
    [scrw addSubview:txt_1st];
    [scrw addSubview:txt_2nd];
    [scrw addSubview:txt_3rd];
    [scrw addSubview:txt_4th];
    [scrw addSubview:txt_5th];
    [scrw addSubview:txt_6th];
    [scrw addSubview:txt_view];
    [scrw addSubview:txt_7th];
    [scrw addSubview:txt_8th];
    [scrw addSubview:txt_9th];
   
    [scrw addSubview:btn_submit];
   
    [lbl_1st release];
    [lbl_2nd release];
    [lbl_3rd release];
    [lbl_4th release];
    [lbl_5th release];
    [lbl_6th release];
    [lbl_7th release];
    [lbl_8th release];
    [lbl_9th release];
    [lbl_10th release];
    [req1 release];
    [req2 release];
    [req3 release];
    [req4 release];
    [req5 release];
    [req6 release];
    [req7 release];
    [req8 release];
    [req9 release];
    
}

-(void)setViewFrame{

    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            scrw.contentSize = CGSizeMake(0, 450);
           lbl_heading.frame = CGRectMake(110, 0, 125, 30);
            backButton.frame = CGRectMake(5, 10, 50, 20);
            scrw.frame = CGRectMake(0, 120, 320, 260);
            lbl_content.frame = CGRectMake(50, 25, 230, 100);
            lbl_1st.frame = CGRectMake(20, 0, 80, 35);
            lbl_2nd.frame = CGRectMake(20, 35, 80, 50);
            lbl_3rd.frame = CGRectMake(20, 80, 80, 35);
            lbl_4th.frame = CGRectMake(20, 125, 80, 35);
            lbl_5th.frame = CGRectMake(20, 160, 80, 35);
            lbl_6th.frame = CGRectMake(20, 203, 80, 35);
            lbl_7th.frame = CGRectMake(20, 270, 80, 35);
            lbl_8th.frame = CGRectMake(20, 305, 80, 35);
            lbl_9th.frame = CGRectMake(20, 345, 80, 35);
            lbl_10th.frame = CGRectMake(20, 380, 80, 50);
            txt_1st.frame = CGRectMake(105, 10, 150, 20);
            txt_2nd.frame = CGRectMake(105, 45, 150, 20);
            txt_3rd.frame = CGRectMake(105, 87, 150, 20);
            txt_4th.frame = CGRectMake(105, 132, 150, 20);
            txt_5th.frame = CGRectMake(105, 172, 150, 20);
            txt_view.frame = CGRectMake(105,210, 160, 60);
            txt_6th.frame = CGRectMake(105, 280, 150, 20);
            txt_7th.frame = CGRectMake(105, 315, 150, 20);
            txt_8th.frame = CGRectMake(105,357 , 150, 20);
            txt_9th.frame = CGRectMake(105, 390, 150, 20);
            btn_submit.frame = CGRectMake(230, 420, 50, 20);
            
            
            req1.frame=CGRectMake(255, 4, 50, 20);
            req2.frame=CGRectMake(255, 40, 50, 20);
            req3.frame=CGRectMake(255, 80, 50, 20);
            req4.frame=CGRectMake(255, 125, 50, 20);
            req5.frame=CGRectMake(255, 165, 50, 20);
            req6.frame=CGRectMake(265, 212, 50, 20);
            req7.frame=CGRectMake(255, 273, 50, 20);
            req8.frame=CGRectMake(255, 309, 50, 20);
            req9.frame=CGRectMake(255, 350, 50, 20);
            
                     
        }
        
        else{
            scrw.contentSize = CGSizeMake(0, 335);
            lbl_heading.frame = CGRectMake(180, 12, 125, 40);
            backButton.frame = CGRectMake(20, 26, 50, 20);
            lbl_content.frame = CGRectMake(90, 45, 300, 70);
             scrw.frame = CGRectMake(0, 120, 480, 110);
            lbl_1st.frame = CGRectMake(90, 0, 100, 20);
            txt_1st.frame = CGRectMake(200, 7, 170, 15);
            lbl_2nd.frame = CGRectMake(90, 30, 100, 30);
            txt_2nd.frame = CGRectMake(200, 36, 170, 15);
            lbl_3rd.frame = CGRectMake(90, 58, 100, 30);
            txt_3rd.frame = CGRectMake(200, 66, 170, 15);
            lbl_4th.frame = CGRectMake(90, 85, 100, 30);
            txt_4th.frame = CGRectMake(200, 94, 170, 15);
            lbl_5th.frame = CGRectMake(90, 114, 100, 30);
            txt_5th.frame = CGRectMake(200, 122, 170, 15);
            lbl_6th.frame = CGRectMake(90, 145, 100, 30);
            txt_view.frame = CGRectMake(200, 148, 180, 40);
            lbl_7th.frame = CGRectMake(90, 190, 100, 30);
            txt_6th.frame = CGRectMake(200, 200, 170, 15);
            lbl_8th.frame = CGRectMake(90, 220, 100, 30);
            txt_7th.frame = CGRectMake(200, 230, 170, 15);
            lbl_9th.frame = CGRectMake(90, 250, 100, 30);
            txt_8th.frame = CGRectMake(200,260 , 170, 15);
            lbl_10th.frame = CGRectMake(90, 284, 100, 30);
            txt_9th.frame = CGRectMake(200, 290, 170, 15);
            btn_submit.frame = CGRectMake(345, 314, 50, 20);
            
            req1.frame=CGRectMake(370, 0, 70, 20);
            req2.frame=CGRectMake(370, 30, 70, 20);
            req3.frame=CGRectMake(370, 60, 70, 20);
            req4.frame=CGRectMake(370, 87, 70, 20);
            req5.frame=CGRectMake(370, 117, 70, 20);
            req6.frame=CGRectMake(380, 145, 70, 20);
            req7.frame=CGRectMake(370, 193, 70, 20);
            req8.frame=CGRectMake(370, 224, 70, 20);
            req9.frame=CGRectMake(370, 254, 70, 20);
                  
        }
    }

}

-(IBAction)Click_submitbtn:(id)sender {
    
    if ([txt_1st.text isEqualToString:@""] || [txt_2nd.text isEqualToString:@""] || [txt_3rd.text isEqualToString:@""] || [txt_2nd.text isEqualToString:@""] || [txt_2nd.text isEqualToString:@""] || [txt_4th.text isEqualToString:@""] || [txt_5th.text isEqualToString:@""] || [txt_view.text isEqualToString:@""] || [txt_6th.text isEqualToString:@""] || [txt_7th.text isEqualToString:@""] || [txt_8th.text isEqualToString:@""] || txt_1st.text == nil || txt_2nd.text==nil || txt_3rd.text==nil || txt_4th.text==nil || txt_5th.text==nil || txt_view.text==nil || txt_6th.text==nil || txt_7th.text==nil || txt_8th.text==nil) {
        
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please fill up all required field." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 release];
                
    }
    
    else{
        
        if(![txt_7th.text isEqualToString:txt_8th.text]){
            
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please check your email address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert2 show];
            [alert2 release];

    }
    else{
            
    [self formSubmit:txt_1st.text numberOfpeople:txt_2nd.text purposeOfEvent:txt_3rd.text Date:txt_4th.text Require:txt_5th.text OtherRequirements:txt_view.text Name:txt_6th.text Emailaddress:txt_7th.text ConfirmEmail:txt_8th.text PhoneNumber:txt_9th.text];
            
        }
        
    }
        
 }

-(IBAction)ClickBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
 }
;
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=NO;
    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
     [self AddNotification];
 }


-(void)AddNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInTwitter:)name:@"Twitter"  object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInGooglePlus:)name:@"GooglePlus"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInLinkedin:)name:@"Linkedin"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInFacebook:)name:@"Facebook"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInMessage:)name:@"Message"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Settings:)name:@"Settings"  object:nil];
    
}
#pragma  mark-
#pragma mark- share

- (void)ShareInTwitter:(NSNotification *)notification {
    iCodeOauthViewController *obj_twt=[[iCodeOauthViewController alloc]initWithNibName:nil bundle:nil];
     obj_twt.twt_text=@"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v  This will do the job of informing the recipient of the message about the app so they download it.";
    [self.navigationController pushViewController:obj_twt animated:YES];
    [obj_twt release];
}                 


- (void)ShareInGooglePlus:(NSNotification *)notification {
    ;
}


- (void)ShareInMessage:(NSNotification *)notification {
    Class messageClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (messageClass != nil) 
    {                         
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendMail]) 
        {
            [self displayEmailComposerSheet];
        }
        else 
        {        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
            
        }
    }
    else 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning !" message:@"Device not configured to send Mail." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }
    
}
-(void)displayEmailComposerSheet
{
    MFMailComposeViewController * mailController = [[MFMailComposeViewController alloc]init] ;
    
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"The Big Fish Experience"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

#pragma mark EmailComposer Delegate-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)Settings:(NSNotification *)notification {
    MyPreferences *obj_mypreferences=[[MyPreferences alloc]initWithNibName:[Constant GetNibName:@"MyPreferences"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_mypreferences animated:YES];
    [obj_mypreferences release];
}


- (void)ShareInLinkedin:(NSNotification *)notification {
    oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loginViewDidFinish:) 
                                                 name:@"loginViewDidFinish" 
                                               object:oAuthLoginView];
    
    
    [self presentModalViewController:oAuthLoginView animated:YES];
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [oAuthLoginView release];
    oAuthLoginView = nil;
}

- (void)ShareInFacebook:(NSNotification *)notification {
    [[FacebookController sharedInstance] setFbDelegate:self];
    [[FacebookController sharedInstance] initialize];
}

-(void) FBLoginDone:(id)objectDictionay
{
    [self wallPosting];
}
-(void) wallPosting
{
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     @"Want to share through Greetings", @"description",
     @"https://m.facebook.com/apps/Greetings/", @"link",
     //@"http://fbrell.com/f8.jpg", @"picture",
     nil];  
    [[FacebookController sharedInstance].facebook dialog:@"feed"
                                               andParams:params
                                             andDelegate:self];    
    // barButton.enabled = YES;
}

-(void) fbDidLogin
{
    //NSLog(@"TOKEn  fbDidLogin %@",[facebook accessToken]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self wallPosting];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    // barButton.enabled = YES;
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error{
	
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Error Occurred!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
	
	if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
		//NSLog(@"URL  %@",url);			//alert user of successful post
		
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Message Posted Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		myAlert.tag = 6;
		[myAlert show];
		[myAlert release];
        
    }
    
}

- (void)dialogDidNotCompleteWithUrl:(NSURL *)url{
	
	//NSLog(@"URL  %@",url);
    
}

-(void) dialogDidComplete:(FBDialog *)dialog{
    
    
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	//NSLog(@"did not login");
}

- (void) fbDidLogout {
	// Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
    
}    

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Twitter" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GooglePlus" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Linkedin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Facebook" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Message" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Settings" object:nil];
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setViewFrame];
    
 }
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        _Toolbar.frame = CGRectMake(0, 387, 320, 48);
    }
    else{
        _Toolbar.frame = CGRectMake(0, 240, 480, 48);
    }
    
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
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
    CGRect viewFrame = self.view.frame;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            viewFrame.origin.y -= 165;
        }
        else{
            
            viewFrame.origin.y -= 115;
        }

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    
    if (viewFrame.origin.y < 0.0) {
        
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                viewFrame.origin.y += 165;
            }
            else{
                
                viewFrame.origin.y += 115;
            }

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
            
        }

    }
}

#pragma  mark -
#pragma  mark - texFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
    
   }

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
    CGRect viewFrame = self.view.frame;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            
            viewFrame.origin.y -= 125;
        }
        else{
            
            viewFrame.origin.y -= 75; 
        }

    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.view setFrame:viewFrame];
	[UIView commitAnimations];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    CGRect viewFrame = self.view.frame;
    
    if (viewFrame.origin.y < 0.0) {
        
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                
                viewFrame.origin.y += 125;
            }
            else{
                
              viewFrame.origin.y += 75;  
            }

    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.view setFrame:viewFrame];
	[UIView commitAnimations];
            
    }
        
  }
}

-(void)formSubmit:(NSString *)location numberOfpeople:(NSString *)noOfpeople purposeOfEvent:(NSString *)event Date:(NSString *)date Require:(NSString *)require OtherRequirements:(NSString *)otherRequirements Name:(NSString *)name Emailaddress:(NSString *)email ConfirmEmail:(NSString *)con_email PhoneNumber:(NSString *)ph_number
{
    
    NSString *post = [NSString stringWithFormat:@"Location=%@&NumberOfPeople=%f&purposeOfEvent=%@&Date=%@&Required=%@&OtherRequirements=%@&Name=%@&Emailaddress=%@&ConfirmEmail=%@&PhoneNumber=%@",location,noOfpeople,event,date,require,otherRequirements,name,email,con_email,ph_number];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    
    [request setURL:[NSURL URLWithString:FormsubmitURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"%@",returnData);
    
    NSString *Content_jsonData=[[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding] autorelease];
    
    NSLog(@"%@",Content_jsonData);
    
}


@end
