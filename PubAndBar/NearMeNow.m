//
//  PubList.m
//  PubAndBar
//
//  Created by User7 on 02/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "NearMeNow.h"
#import "PubDetail.h"
#import "Toolbar.h"
#import "SavePubDetailsInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveNearMeInfo.h"
#import "Global.h"
#import "AsyncImageView.h"

@implementation NearMeNow

@synthesize table_list;
@synthesize PubId;
@synthesize seg_control;
@synthesize PubArray;
@synthesize venu_btn;
@synthesize pub_list;
@synthesize  _pageName;


@synthesize oAuthLoginView;


UIImageView *pushImg;
UILabel *topLabel;
UILabel *middlelbl;
Toolbar *_Toolbar;
AppDelegate *app;
BOOL _IsSelect;

//int k=20;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withCategoryStr:(NSString *) categoryString;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        categoryStr = categoryString;
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
    
    self.eventTextLbl.text=_pageName;

    
    self.view.frame = CGRectMake(0, 0, 320, 395);

    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _Toolbar = [[[Toolbar alloc]init]autorelease];
    _Toolbar.layer.borderWidth = 1.0f;
    [self.view addSubview:_Toolbar];
    PubArray = [[[NSMutableArray alloc]init]autorelease];
    PubArray = [[SaveNearMeInfo GetNearMePubsInfo]retain];
    
    venu_btn=[[UIButton alloc]initWithFrame:CGRectMake(120, 360, 80, 20)];
    venu_btn.titleLabel.font= [UIFont systemFontOfSize:12.0];
    venu_btn.layer.borderColor=[UIColor whiteColor].CGColor;
    venu_btn.layer.borderWidth=1.0;
    venu_btn.layer.cornerRadius=10.0;
    venu_btn.titleLabel.textColor=[UIColor whiteColor];
    [venu_btn setTitle:@"More" forState:UIControlStateNormal];
    [venu_btn addTarget:self action:@selector(More_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    venu_btn.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    [self.view addSubview:venu_btn];
    [venu_btn release];
    
    pub_list=[[NSMutableArray alloc]init];
    //---------------------mb-28-05-12----------------------------//
    
    
    if ([GET_DEFAUL_VALUE(ShowNumberOfPubs) intValue]!=0) {
        noOfPubs=[GET_DEFAUL_VALUE(ShowNumberOfPubs) intValue];
    }else
        noOfPubs=20;
    k=noOfPubs;
       
    if([self.PubArray count]>noOfPubs){
        
        for ( int i=0; i<noOfPubs; i++) {
            [pub_list addObject:[PubArray objectAtIndex:i]];
        }
        if([self.PubArray count]==noOfPubs){
            venu_btn.hidden=YES;
        }
    }
    //--------------------------------------------------------//

        else
        {
            
            for ( int i=0; i<[PubArray count]; i++) {
                [pub_list addObject:[PubArray objectAtIndex:i]];
                
            }
            venu_btn.hidden=YES;
        }

       [self callingMapview];
       [self CreateHomeView];
    
   }

-(void)CreateHomeView{
    
    table_list = [[[UITableView alloc]init]autorelease];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleNone;
//*****************************************************************//    
    btn_view=[[UIView alloc]init];
    btn_view.backgroundColor=[UIColor whiteColor];
    
    list_btn=[[UIButton alloc]init];
    [list_btn addTarget:self action:@selector(List_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    map_btn=[[UIButton alloc]init];
    [map_btn addTarget:self action:@selector(Map_btnClick:) forControlEvents:UIControlEventTouchUpInside]; 
  
    //---------------mb-28-05-12---------------------//
    if ([GET_DEFAUL_VALUE(PubsShowsIn) isEqualToString:@"LIST"]) {
        //seg_control.selectedSegmentIndex =0;
        _IsSelect=NO;
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
                
                
                
                
            }
            else{
                [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                
                
                
            }
        }

        table_list.hidden=NO;
        venu_btn.hidden=NO;
    }
    else
    {
        //seg_control.selectedSegmentIndex =1;
        _IsSelect=YES;
        if ([Constant isiPad]) {
            ;
        }
        else{
            if ([Constant isPotrait:self]) {
                [map_btn setImage:[UIImage imageNamed:@"Map2Select.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"List1DeselectButton.png"] forState: UIControlStateNormal];
                
                
            }
            else{
                [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
                
                
            }
        }

        table_list.hidden=YES;
        obj_nearbymap.hidden=NO;
        venu_btn.hidden=YES;
    }
    //------------------------------------------------//
    //[seg_control addTarget:self action:@selector(ClickSegCntrl:) forControlEvents:UIControlEventValueChanged];
    
    [self setHomeViewFrame];
    
    [self.view addSubview:table_list];
    //[self.view addSubview:seg_control];
    
    [self.view addSubview:btn_view];
    [btn_view addSubview:list_btn];
    [btn_view addSubview:map_btn];
    [btn_view release];
    [list_btn release];
    [map_btn release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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


-(IBAction)List_btnClick:(id)sender{
    
    table_list.hidden = NO;
    obj_nearbymap.hidden = YES;
    _IsSelect=NO;
    if([pub_list count] == [PubArray count]){
        venu_btn.hidden=YES;
    } 
    else
        venu_btn.hidden=NO;
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
            
            
            
            
        }
        else{
            [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
            
            
            
        }
    }
    
}
-(IBAction)Map_btnClick:(id)sender{
    
    table_list.hidden = YES;
    obj_nearbymap.hidden = NO;
    venu_btn.hidden=YES;
    _IsSelect=YES;
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            [map_btn setImage:[UIImage imageNamed:@"Map2Select.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"List1DeselectButton.png"] forState: UIControlStateNormal];
            
            
        }
        else{
            [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
            
            
        }
    }
}
//*****************************************************************//  

-(IBAction)More_btnClick:(id)sender{
    
    //---------------------mb-28-05-12----------------------------//
    [pub_list removeAllObjects];  
    
    
    
    k=k+noOfPubs;
    int r =[PubArray count]%noOfPubs;
    //-------------------------------------------------------------//
    NSLog(@"%d",r);
    
    if (k<=([PubArray count]-r)) {
        
        for (int j=0; j<k; j++) {
            [pub_list addObject:[PubArray objectAtIndex:j]];
            
        }
        [table_list reloadData];
        
        [obj_nearbymap removeFromSuperview];
        [obj_nearbymap release];
        [self callingMapview];
        
    }
    else
    {
        for (int j=0; j<[PubArray count]; j++) {
            [pub_list addObject:[PubArray objectAtIndex:j]];
            
        }
        [table_list reloadData];
        
        [obj_nearbymap removeFromSuperview];
        [obj_nearbymap release];
        [self callingMapview];
        
        venu_btn.hidden=YES;
        
    }
    
}

-(void)callingMapview{
    
    NSLog(@"pub_list  %@",pub_list);
    obj_nearbymap = [[NearByMap alloc]initWithFrame:CGRectMake(0, 32, 320, 335) withArray:pub_list];
    [self.view addSubview:obj_nearbymap];
    obj_nearbymap.hidden=YES;
}

-(void)setHomeViewFrame{
    
    if ([Constant isiPad]){
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            table_list.frame = CGRectMake(0, 30, 320, 325);
            table_list.scrollEnabled = YES;
           // seg_control.frame = CGRectMake(90, 4, 140, 25);
            [obj_nearbymap setFrameOfView:CGRectMake(0, 32, 320, 325)];
            venu_btn.frame=CGRectMake(120, 360, 80, 20);
    //*****************************************************************//          
            btn_view.frame=CGRectMake(130, 6, 65.5, 19.5);
            list_btn.frame=CGRectMake(0.5, 0.5, 32, 18.5);
            map_btn.frame=CGRectMake(32.5, 0.5, 32, 18.5);

            
            if (_IsSelect==NO) {
                [list_btn setImage:[UIImage imageNamed:@"List1SelectButton.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"Map2Deselect.png"] forState: UIControlStateNormal];
                
            }
            else
            {
                [list_btn setImage:[UIImage imageNamed:@"List1DeselectButton.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"Map2Select.png"] forState: UIControlStateNormal];
                
           }
        }
 //*****************************************************************//             
        else{
            table_list.frame = CGRectMake(0, 40, 480, 165);
            table_list.scrollEnabled = YES;
            //seg_control.frame = CGRectMake(140, 14, 200, 25);
            [obj_nearbymap setFrameOfView:CGRectMake(0, 42, 480, 165)];
            venu_btn.frame=CGRectMake(190, 214, 100, 20);
  //***************************************************************//          
            btn_view.frame=CGRectMake(161, 16, 158, 21);
            list_btn.frame=CGRectMake(1, 1, 79, 19);
            map_btn.frame=CGRectMake(81, 1, 76, 19);
            
            if (_IsSelect==NO) {
                [list_btn setImage:[UIImage imageNamed:@"ListSelect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapDeselect.png"] forState: UIControlStateNormal];
                
            }
            else
            {
                [list_btn setImage:[UIImage imageNamed:@"ListDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"MapSelect.png"] forState: UIControlStateNormal];
                
            }
          }

        }
    }
//*****************************************************************//  

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [pub_list count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
    const NSInteger PUSH_IMAGE_TAG = 1003;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
    const NSInteger MID_LABEL_TAG=1005;
    const NSInteger TOP_IMAGE_TAG=1002;
    
    AsyncImageView *pubImage;
	UILabel *topLabel;
    UILabel *middleLable;
    UIView *vw;
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:CellIdentifier]
        ;
		vw = [[[UIView alloc]init]autorelease];
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.tag = MAINVIEW_VIEW_TAG;
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
        
        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        [cell.contentView addSubview:vw];
        
		topLabel=[[[UILabel alloc]initWithFrame:CGRectMake(50,0,200,37)]autorelease];
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:12];
        [vw addSubview:topLabel];
        
        middleLable=[[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 60, 37)]autorelease];
        middleLable.tag = MID_LABEL_TAG;
        middleLable.backgroundColor = [UIColor clearColor];
		middleLable.textColor = [UIColor whiteColor];
		middleLable.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		middleLable.font = [UIFont boldSystemFontOfSize:12];
        [vw addSubview:middleLable];
        
        
        pubImage=[[[AsyncImageView alloc]initWithFrame:CGRectMake(2,3,30,30)]autorelease];
		pubImage.tag = TOP_IMAGE_TAG;
		pubImage.backgroundColor = [UIColor clearColor];
        [vw addSubview:pubImage];


		
        pushImg = [[[UIImageView alloc]initWithFrame:CGRectMake(300, 15, 10, 10)]autorelease];
        pushImg.tag = PUSH_IMAGE_TAG;
        pushImg.image=[UIImage imageNamed:@"right_iPhone"];
        pushImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        [vw addSubview:pushImg];
        
    }
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
        pushImg=(UIImageView*)[cell viewWithTag:PUSH_IMAGE_TAG];
        vw=(UIView*)[cell viewWithTag:MAINVIEW_VIEW_TAG];
        middleLable = (UILabel *)[cell viewWithTag:MID_LABEL_TAG];
        pubImage = (AsyncImageView *)[cell viewWithTag:TOP_IMAGE_TAG];
        
	}
    @try {
        NSLog(@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]);
        topLabel.text = [[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName"];
        //middleLable.text = [NSString stringWithFormat:@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]];
        //-----------------------------------------mb-28-05-12--------//
        if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
            middleLable.text= [NSString stringWithFormat: @"%@ Km",[[pub_list objectAtIndex:indexPath.row] valueForKey:@"PubDistance"]];
        else
            middleLable.text=[NSString stringWithFormat:@"%0.2f",[[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]floatValue]* 0.6213371192];
        NSURL *url = [[NSURL alloc] initWithString:[[pub_list objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"]];
        [pubImage loadImageFromURL:url];

        //---------------------------------------------//

        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
    obj_detail.Pub_ID= [[PubArray objectAtIndex:indexPath.row] valueForKey:@"PubID"];
    [self.navigationController pushViewController:obj_detail animated:YES];
    [obj_detail release];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    table_list = nil;
    //seg_control=nil;
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

-(void)dealloc{
    [table_list release];
    [PubId release];
    //[seg_control release];
    [obj_nearbymap release];
    [super dealloc];
}
@end
