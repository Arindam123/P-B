//
//  SportDetail.m
//  PubAndBar
//
//  Created by User7 on 08/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "SportDetail.h"
#import "PubList.h"
#import "AppDelegate.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "ASIHTTPRequest.h"

@implementation SportDetail
@synthesize vw_header;
@synthesize frstlbl;
@synthesize secndlbl;
@synthesize thrdlbl;
@synthesize fourthlbl;
@synthesize fifthlbl;
@synthesize backButton;
@synthesize table_list;
@synthesize array;
@synthesize sportID;
@synthesize sport_name;

@synthesize searchRadius;
@synthesize searchUnit;
@synthesize venu_btn;
@synthesize arr;
@synthesize hud = _hud;
//////////////////JHUMA///////////////////////////////////

@synthesize str_title;
@synthesize Title_lbl;

@synthesize oAuthLoginView;

AppDelegate *app;

int k=5;

UIInterfaceOrientation orientation;

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
    self.eventTextLbl.text=sport_name;
    
    
    toolBar = [[Toolbar alloc]init];
    // toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    
    
    
    array=[[NSMutableArray alloc]init];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMdd"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    NSLog(@"%@",dateString);
    
    array = [[SaveSportDetailInfo GetSport_EventInfo:sportID withRadius:searchRadius currentDate:dateString]retain];
    
    
    arr=[[NSMutableArray alloc]init];
    
    
    
    
    // [self CreateView];
    
    //-----------------------------------mb----------------------------//
    if ([array count]==0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    [self CreateView];
    
    
    if ([array count]<5) {
        for (int m=0; m<[array count]; m++) {
            [arr addObject:[array objectAtIndex:m]];
            
        }
        venu_btn.hidden=YES;
        
    }
    else{
        
        for (int m=0; m<5; m++) {
            [arr addObject:[array objectAtIndex:m]];
        }
    }
    
    
    
    
    //----------------------------------------------------------------//
    
}

#pragma  Mark-
#pragma  Mark- AlertView Delegate
//--------------------------mb----------------------------------//
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) 
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)CreateView{
    
    table_list = [[UITableView alloc]init];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    table_list.scrollEnabled=YES;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];
    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    vw_header = [[UIView alloc]init];
    vw_header.layer.cornerRadius=5.0;
    //vw.backgroundColor = [UIColor colorWithRed:96/255 green:94/255 blue:93/255 alpha:1];
    vw_header.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];//[UIColor grayColor];
    
    
    frstlbl = [[UILabel alloc]init];
    frstlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    ////////////////////////////JHUMA/////////////////////////////////////////////////////
    
    
    vw1 = [[[UIView alloc]init]autorelease];
    vw2 = [[[UIView alloc]init]autorelease];
    vw3 = [[[UIView alloc]init]autorelease];
    vw4 = [[[UIView alloc]init]autorelease];
    //vw5 = [[[UIView alloc]init]autorelease];
    vw1.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    vw2.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    vw3.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    vw4.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    
    //vw5.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
    
    frstlbl.text = @"EVENT";
    frstlbl.textColor = [UIColor whiteColor];
    frstlbl.font = [UIFont systemFontOfSize:9];
    frstlbl.textAlignment=UITextAlignmentCenter;
    
    
    
    secndlbl = [[UILabel alloc]init];
    secndlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    secndlbl.textColor = [UIColor whiteColor];
    secndlbl.font = [UIFont systemFontOfSize:9];
    secndlbl.text = @"DATE";
    secndlbl.textAlignment=UITextAlignmentCenter;
    
    thrdlbl = [[UILabel alloc]init];
    thrdlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    thrdlbl.textColor = [UIColor whiteColor];
    thrdlbl.font = [UIFont systemFontOfSize:9];
    thrdlbl.text = @"TIME";
    thrdlbl.textAlignment=UITextAlignmentCenter;
    
    fourthlbl = [[UILabel alloc]init];
    fourthlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fourthlbl.textColor = [UIColor whiteColor];
    fourthlbl.font = [UIFont systemFontOfSize:9];
    fourthlbl.text = @"TYPE";
    fourthlbl.textAlignment=UITextAlignmentCenter;
    
    fifthlbl = [[UILabel alloc]init];
    fifthlbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    fifthlbl.textColor = [UIColor whiteColor];
    fifthlbl.font = [UIFont systemFontOfSize:9];
    fifthlbl.text = @"CHANNEL";
    fifthlbl.textAlignment=UITextAlignmentCenter;
    
    Title_lbl = [[UILabel alloc]init];
    Title_lbl.backgroundColor = [UIColor clearColor];
    Title_lbl.textColor = [UIColor whiteColor];
    Title_lbl.font = [UIFont boldSystemFontOfSize:11];
    Title_lbl.numberOfLines=2;
    NSString *str=[NSString stringWithFormat:@"Pubs & Bars showing %@ on TV",str_title];
    Title_lbl.text =str;
    Title_lbl.textAlignment=UITextAlignmentCenter;
    
    venu_btn=[[UIButton alloc]initWithFrame:CGRectMake(120, 360, 80, 20)];
    venu_btn.titleLabel.font= [UIFont systemFontOfSize:12.0];
    venu_btn.layer.borderColor=[UIColor whiteColor].CGColor;
    venu_btn.layer.borderWidth=1.0;
    venu_btn.layer.cornerRadius=10.0;
    venu_btn.titleLabel.textColor=[UIColor whiteColor];
    [venu_btn setTitle:@"More" forState:UIControlStateNormal];
    [venu_btn addTarget:self action:@selector(More_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    venu_btn.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    
    
    
    
    
    [self setViewFrame];
    [self.view addSubview:vw_header];
    [vw_header addSubview:vw1];
    [vw_header addSubview:vw2];
    [vw_header addSubview:vw3];
    [vw_header addSubview:vw4];
    //[self.view addSubview:vw5];
    [vw_header addSubview:frstlbl];
    [vw_header addSubview:secndlbl];
    [vw_header addSubview:thrdlbl];
    [vw_header addSubview:fourthlbl];
    [vw_header addSubview:fifthlbl];
    [self.view addSubview:table_list];
    [self.view addSubview:backButton];
    [self.view addSubview:Title_lbl];
    [self.view addSubview:venu_btn];
    [venu_btn release];
    
    [frstlbl release];
    [secndlbl release];
    [thrdlbl release];
    [fourthlbl release];
    [fifthlbl release];
    [backButton release];
    [vw_header release];
    [Title_lbl release];
}
/////////////////////////////////////////////////////////////////////////////

-(IBAction)ClickBack:(id)sender{
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

////////////////////////////JHUMA///////////////////////////////////

-(IBAction)More_btnClick:(id)sender{
    
    
    /*int r=[array count]%5;
    if (r==0) {
        r = [array count]/5;
    }
    int i=[array count]-r;
    
    k=k+5;
    if(k<=i){
        [arr removeAllObjects];
        
        for (int j =0; j<k; j++) {
            [arr addObject:[array objectAtIndex:j]];
        }
        [table_list reloadData];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully more Sport Event Details has been added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    else if(r!=0)
    {
        [arr removeAllObjects];
        for (int j =0; j<[array count]; j++) {
            [arr addObject:[array objectAtIndex:j]];
        }
        [table_list reloadData];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully more Sport Event Details has been added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        venu_btn.hidden=YES;
        
    }
    else
    {
        venu_btn.hidden=YES;
    }*/
    
    if ([array count] > [arr count]) {
        
        //[arr removeAllObjects];
        int count = [arr count];
        
        for (int j =0; j<5; j++) {
            NSLog(@"%d",j);
            
            [arr addObject:[array objectAtIndex:count+j]];
            if ([array count] ==  [arr count]) {
                break;
            }
            
        }
        [table_list reloadData];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Successfully more Sport Event Details has been added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];

    }
    
    
    
    
}



-(void)setViewFrame{
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        //-----------------mb-04-06-12------------------------//
        if ([Constant isPotrait:self]) {
            
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait) {
                vw_header.frame = CGRectMake(8.5, 124, 303, 45);
                frstlbl.frame = CGRectMake(10, 2, 75, 30);
                vw1.frame=CGRectMake(96, 0, 1, 45);
                
                secndlbl.frame = CGRectMake(99, 2, 39, 30);
                
                vw2.frame=CGRectMake(143, 0, 1, 45);
                
                thrdlbl.frame = CGRectMake(145, 2, 28, 30);
                
                vw3.frame=CGRectMake(180, 0, 1, 45);
                
                fourthlbl.frame = CGRectMake(183, 2, 54, 30);
                
                vw4.frame=CGRectMake(241, 0, 1, 45);
                
                fifthlbl.frame = CGRectMake(246, 2, 52, 30);
                
                //vw5.frame=CGRectMake(9, 321, 302.5, 1);
                
                backButton.frame = CGRectMake(8, 90, 50, 25);
                
                Title_lbl.frame=CGRectMake(60, 90, 230, 30);
                
                table_list.frame = CGRectMake(8.5, 164, 303, 241);
                
                venu_btn.frame=CGRectMake(120, 385, 80, 20);
                
                if (app.ismore==YES) {
                    //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                    
                }
                else{
                    //toolBar.frame = CGRectMake(0, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                }
                
                
                
            }
            if (self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
                
                vw1.frame=CGRectMake(94, 0, 1, 45);
                vw2.frame=CGRectMake(141, 0, 1, 45);
                vw3.frame=CGRectMake(178, 0, 1, 45);
                vw4.frame=CGRectMake(242, 0, 1, 45);
                
                vw_header.frame = CGRectMake(8.5, 124, 303, 45);
                frstlbl.frame = CGRectMake(10, 2, 75, 30);
                secndlbl.frame = CGRectMake(99, 2, 39, 30);
                thrdlbl.frame = CGRectMake(145, 2, 28, 30);
                fourthlbl.frame = CGRectMake(183, 2, 54, 30);
                fifthlbl.frame = CGRectMake(246, 2, 52, 30);
                
                
                
                backButton.frame = CGRectMake(8, 90, 50, 25);
                Title_lbl.frame=CGRectMake(60, 90, 230, 30);
                table_list.frame = CGRectMake(8.5, 164, 303, 241);
                
                venu_btn.frame=CGRectMake(120, 385, 80, 20);
                
                
                if (app.ismore==YES) {
                    //toolBar.frame = CGRectMake(-320, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                    
                }
                else{
                    //toolBar.frame = CGRectMake(0, 387, 640, 48);
                    toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                }
                
                
                
                
            }
            
        }
        
        else{
            if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
                
                vw1.frame=CGRectMake(145, 0, 1, 45);
                vw2.frame=CGRectMake(217, 0, 1, 45);
                vw3.frame=CGRectMake(274, 0, 1, 45);
                vw4.frame=CGRectMake(366, 0, 1, 45);
                table_list.frame = CGRectMake(10, 152, 460, 105);
                venu_btn.frame=CGRectMake(190, 229, 100, 20);
                backButton.frame = CGRectMake(10, 85, 50, 25);
                frstlbl.frame = CGRectMake(0, 0, 154, 40);
                secndlbl.frame = CGRectMake(144, 0, 74, 40);
                
                thrdlbl.frame = CGRectMake(215, 0, 59, 40);
                
                fourthlbl.frame = CGRectMake(270, 0, 96, 40);
                
                fifthlbl.frame = CGRectMake(367, 0, 93, 40);
                
                Title_lbl.frame=CGRectMake(125, 80, 230, 30);
                
                vw_header.frame = CGRectMake(10, 117, 460, 42);
                table_list.scrollEnabled = YES;
                
                if (app.ismore==YES) {
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                else{
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                
                
                
                
            }
            if (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
                
                vw1.frame=CGRectMake(145, 0, 1, 45);
                vw2.frame=CGRectMake(217, 0, 1, 45);
                vw3.frame=CGRectMake(274, 0, 1, 45);
                vw4.frame=CGRectMake(366, 0, 1, 45);
                table_list.frame = CGRectMake(10, 152, 460, 105);
                venu_btn.frame=CGRectMake(190, 229, 100, 20);
                backButton.frame = CGRectMake(10, 85, 50, 25);
                frstlbl.frame = CGRectMake(0, 0, 154, 40);
                secndlbl.frame = CGRectMake(144, 0, 74, 40);
                
                thrdlbl.frame = CGRectMake(215, 0, 59, 40);
                
                fourthlbl.frame = CGRectMake(270, 0, 96, 40);
                
                fifthlbl.frame = CGRectMake(369, 0, 93, 40);
                
                Title_lbl.frame=CGRectMake(125, 80, 230, 30);
                
                vw_header.frame = CGRectMake(10, 117, 460, 42);
                table_list.scrollEnabled = YES;
                
                if (app.ismore==YES) {
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                else{
                    toolBar.frame = CGRectMake(8.5, 261, 463, 53);
                }
                
                
                
                
                
            }
            
            
        }
    }
}
//------------------------------------------//
////////////////////////////////////////////////////////////////////////////////////////

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    venu_btn.hidden=YES;
    // app.ismore=NO;
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
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
    TwitterViewController *obj = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:nil];
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-pubs-bars-on-tv_%d.html",str_title,[sportID intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    tempurl = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?url=%@",tempurl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:tempurl]];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        tempurl = response;
    }
    
    
    
    obj.textString=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",str_title,tempurl];
    
    NSLog(@"%@",obj.textString);
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];}                 


- (void)ShareInGooglePlus:(NSNotification *)notification {
    GooglePlusViewController *obj = [[GooglePlusViewController alloc] initWithNibName:@"GooglePlusViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:navigationController animated:YES];
    [navigationController release];
    [obj release];;
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
    NSString *fb_str;
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-pubs-bars-on-tv_%d.html",str_title,[sportID intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    fb_str=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",str_title,tempurl];
    
    [mailController setMessageBody:[NSString stringWithFormat:@"%@",fb_str] isHTML:NO];
    //[mailController setToRecipients:[NSArray arrayWithObjects:EmailStr, nil]];
    mailController.mailComposeDelegate = self;
    [[[[mailController viewControllers] lastObject] navigationItem] setTitle:@"Pub & bar Network"];
    [self presentModalViewController:mailController animated:YES];
    
    [mailController release];
    
}

#pragma mark EmailComposer Delegate-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)Settings:(NSNotification *)notification {
    MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
    [obj_MyProfileSetting release];
}

- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-pubs-bars-on-tv_%d.html",str_title,[sportID intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    obj.shareText=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",str_title,tempurl];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
    
}

-(void) loginViewDidFinish:(NSNotification*)notification
{
    [oAuthLoginView release];
    oAuthLoginView = nil;
}

- (void)ShareInFacebook:(NSNotification *)notification {
    NSLog(@"%d",[sportID intValue ]);
    
    
    NSString *tempurl=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/%@-pubs-bars-on-tv_%d.html",str_title,[sportID intValue]];
    
    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    NSString *fb_str=[NSString stringWithFormat:@"Pubs and Bars showing %@ %@",str_title,tempurl];
    
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = [NSString stringWithFormat:@"%@",fb_str];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}

-(void) FBLoginDone:(id)objectDictionay
{
    [self wallPosting];
}
-(void) wallPosting
{
    
    
    NSLog(@"%d",[sportID intValue ]);
    NSString *fb_str=[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/cricket-pubs-bars-on-tv_%d.html",[sportID intValue]];
    
    
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",fb_str
     // @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://tinyurl.com/8x5jh6v  This will do the job of informing the recipient of the message about the app so they download it."
     ,@"message",
     // @"Want to share through Greetings", @"description",
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
	
	UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Error Occurred!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	myAlert.tag = 60;
	[myAlert show];
	[myAlert release];
}

- (void)dialogCompleteWithUrl:(NSURL *)url{
	
	if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound) {
		//NSLog(@"URL  %@",url);			//alert user of successful post
		
		UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Feed" message:@"Message Posted Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"ARRAY   %d   %d",[arr count],[array count]);
    if ([array count] == [arr count])
        return [arr count];
    else    
        return [arr count] + 1;
    
    
    //return [arr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *topLabel;
    UILabel *middlelbl;
    UILabel *bottomlbl;
    UILabel *endlbl;
    UILabel *extremelbl;
    
    const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger MIDDLE_LABEL_TAG = 1002;
    const NSInteger BOTTOM_LABEL_TAG = 1003;
    const NSInteger END_LABEL_TAG = 1004;
    const NSInteger EXTREME_LABEL_TAG = 1005;
    
    //static NSString *CellIdentifier = @"Cell";
    static NSString *postCellId = @"postCell";
    static NSString *moreCellId = @"moreCell";
    UITableViewCell *cell = nil;
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [arr count];
    
    if (row == count) {
        
        cell = [aTableView dequeueReusableCellWithIdentifier:moreCellId];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] 
                     initWithStyle:UITableViewCellStyleDefault 
                     reuseIdentifier:moreCellId] autorelease];
        }
        
        cell.textLabel.text = @"Touch to load more items...";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
    }
    else{
        
        cell = [aTableView dequeueReusableCellWithIdentifier:postCellId];
        
        if (cell == nil) {
            
            cell =	[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postCellId] autorelease];
            
            
            
            //	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            //    
            //	if (cell == nil)
            //	{
            //        
            //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            /*   UIView *vw6 = [[UIView alloc]initWithFrame:CGRectMake(0, 102, 1, 50)];
             vw6.backgroundColor= [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
             UIView * vw7 = [[UIView alloc]init];
             vw7.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
             
             UIView *vw8 = [[UIView alloc]init];
             vw8.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
             
             UIView *vw9 = [[UIView alloc]init];
             vw9.backgroundColor=[UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1];
             // vw10 = [[UIView alloc]init];
             //vw10.backgroundColor= [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];*/
            
            
            
            topLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 102, 50)]autorelease];
            
            //[cell.contentView addSubview:vw6];
            
            topLabel.tag = TOP_LABEL_TAG;
            topLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            topLabel.backgroundColor = [UIColor clearColor];
            topLabel.textColor = [UIColor whiteColor];
            topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            topLabel.font = [UIFont boldSystemFontOfSize:9];
            topLabel.layer.borderWidth= 1.0;
            topLabel.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            topLabel.textAlignment = UITextAlignmentCenter;
            topLabel.numberOfLines=3;
            topLabel.lineBreakMode = UILineBreakModeWordWrap;
            [cell.contentView addSubview:topLabel];
            
            
            middlelbl =[[[UILabel alloc]initWithFrame:CGRectMake(101, 0, 51, 50)]autorelease];
            middlelbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            middlelbl.tag = MIDDLE_LABEL_TAG;
            middlelbl.backgroundColor = [UIColor clearColor];
            middlelbl.textColor = [UIColor whiteColor];
            middlelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            middlelbl.font = [UIFont boldSystemFontOfSize:9];
            middlelbl.numberOfLines=2;
            middlelbl.layer.borderWidth= 1.0;
            middlelbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            middlelbl.textAlignment = UITextAlignmentCenter;
            [cell.contentView addSubview:middlelbl];
            
            
            bottomlbl =[[[UILabel alloc]initWithFrame:CGRectMake(151, 0, 41, 50)]autorelease];
            bottomlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            bottomlbl.tag = BOTTOM_LABEL_TAG;
            bottomlbl.backgroundColor = [UIColor clearColor];
            bottomlbl.textColor = [UIColor whiteColor];
            bottomlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            bottomlbl.font = [UIFont boldSystemFontOfSize:9];
            bottomlbl.layer.borderWidth= 1.0;
            bottomlbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            bottomlbl.textAlignment = UITextAlignmentCenter;
            [cell.contentView addSubview:bottomlbl];
            
            
            endlbl =[[[UILabel alloc]initWithFrame:CGRectMake(191, 0, 65, 49.5)]autorelease];
            endlbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            endlbl.tag = END_LABEL_TAG;
            endlbl.backgroundColor = [UIColor clearColor];
            endlbl.textColor = [UIColor whiteColor];
            endlbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            endlbl.font = [UIFont boldSystemFontOfSize:9];
            endlbl.layer.borderWidth= 0.5;
            endlbl.numberOfLines=3;
            endlbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            endlbl.textAlignment = UITextAlignmentCenter;
            [cell.contentView addSubview:endlbl];
            
            extremelbl =[[[UILabel alloc]initWithFrame:CGRectMake(255, 0, 65, 49.5)]autorelease];
            extremelbl.autoresizingMask=UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleHeight; 
            extremelbl.tag = EXTREME_LABEL_TAG;
            extremelbl.backgroundColor = [UIColor clearColor];
            extremelbl.textColor = [UIColor whiteColor];
            extremelbl.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
            extremelbl.font = [UIFont boldSystemFontOfSize:9];
            extremelbl.numberOfLines=2;
            extremelbl.layer.borderWidth= 0.5;
            extremelbl.layer.borderColor = [UIColor colorWithRed:117.0/255.0 green:129.0/255.0 blue:144.0/255.0 alpha:1].CGColor;//[[UIColor grayColor]CGColor];
            extremelbl.textAlignment = UITextAlignmentCenter;
            [cell.contentView addSubview:extremelbl];
            
        }
    }
    
    if (cell != nil){
        topLabel = (UILabel *)[cell.contentView viewWithTag:TOP_LABEL_TAG];
        middlelbl = (UILabel *)[cell.contentView viewWithTag:MIDDLE_LABEL_TAG];
        bottomlbl = (UILabel *)[cell.contentView viewWithTag:BOTTOM_LABEL_TAG];
        endlbl = (UILabel *)[cell.contentView viewWithTag:END_LABEL_TAG];
        extremelbl = (UILabel *)[cell.contentView viewWithTag:EXTREME_LABEL_TAG];
    }
    @try {
        topLabel.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Sport_EventName" ];
        
        /*  NSString *str_date=[[array objectAtIndex:indexPath.row]valueForKey:@"Sport_Date" ];
         
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
         [formatter setDateFormat:@"dd/MM/yyyy"];
         
         NSDate *dateString = [formatter dateFromString:str_date];
         // NSLog(@"%@",dateString);
         
         NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
         NSString *dateString1 = [formatter1 stringFromDate:dateString];
         
         
         middlelbl.text =[NSString stringWithFormat:@"%@",dateString1];*/
        
        /*NSString *str_date;
         
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
         [dateFormat setDateFormat:@"dd-MM-yyyy"];
         
         NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row]valueForKey:@"Sport_Date" ]]];
         
         NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
         [dateFormat2 setDateFormat:@"eeee dd MMMM"];
         
         str_date = [dateFormat2 stringFromDate:tempDate]; 
         [dateFormat release];
         [dateFormat2 release];
         
         NSLog(@"%@",str_date);
         NSLog(@"%@",[[array objectAtIndex:indexPath.row]valueForKey:@"Sport_Date" ]);
         middlelbl.text =str_date;*/
        
        middlelbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Sport_Date"];
        bottomlbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Time" ];
        endlbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Type" ];
        extremelbl.text = [[array objectAtIndex:indexPath.row]valueForKey:@"Channel" ];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    UIImageView *backgroundImageView = [[[UIImageView alloc] init] autorelease];
    if(indexPath.row %2 == 0){
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        cell.backgroundView = backgroundImageView;
        
    }
    else{
        [backgroundImageView setBackgroundColor:[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1]]; 
        cell.backgroundView = backgroundImageView;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger row = [indexPath row];
	NSUInteger count = [arr count];
	
	if (row == count) {
		
        
        [self performSelector:@selector(More_btnClick:)];
		
	}
    else{
        
        
        PubList *obj = [[PubList alloc]initWithNibName:[Constant GetNibName:@"PubList"] bundle:[NSBundle mainBundle] withCategoryStr:sport_name];
        obj.searchRadius = searchRadius;
        obj.catID = [[array objectAtIndex:indexPath.row] valueForKey:@"Sport_ID"];
        obj.sport_eventID = [[array objectAtIndex:indexPath.row] valueForKey:@"Sport_EventID"];
        obj.Pubid=[[array objectAtIndex:indexPath.row] valueForKey:@"PubID"];
        
        ////////////////////////////JHUMA///////////////////////////////////
        
        obj.eventName=[[array objectAtIndex:indexPath.row]valueForKey:@"Sport_EventName"];
        
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];
    }
    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
    }
    return YES;
}
-(void)dealloc{
    [table_list release];
    [searchRadius release];
    [toolBar release];
    [super dealloc];
}

@end
