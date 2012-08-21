//
//  PubList.m
//  PubAndBar
//
//  Created by User7 on 02/05/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "NearMeNow.h"
#import "PubDetail.h"
#import "SavePubDetailsInfo.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveNearMeInfo.h"
#import "Global.h"
#import "AsyncImageView.h"
#import "InternetValidation.h"
#import "AppDelegate.h"
//******************************* amit-04/06/2012 *************************//
#import "ServerConnection.h"
#import "DBFunctionality.h"
#import "JSON.h"
#import "PubList.h"
#import "FoodDetails_Microsite.h"
#import "RealAle_Microsite.h"
#import "ASYImage.h"
#import "AsyncImageView_New.h"
#import "PubList.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "NearMeNowCell.h"
//***************************************************************************//


@interface NearMeNow(Private_Methods)

-(void) getNonSub;
- (UIImage*) imageScaledToSize: (CGSize) newSize  oldImage:(UIImage*)oldImage;

@end


@implementation NearMeNow

@synthesize table_list;
@synthesize PubId;
@synthesize seg_control;
@synthesize PubArray;
//@synthesize venu_btn;
@synthesize pub_list;
@synthesize  _pageName;
//******************************* amit-04/06/2012 *************************//
@synthesize hud = _hud;
//***************************************************************************//

@synthesize oAuthLoginView;
@synthesize str_distance;
@synthesize backButton;
@synthesize bulletPointArray,
openingHours4Day,
openingHours4Hours;

@synthesize header_DictionaryData;

//@synthesize middleLbl;


UIInterfaceOrientation orientation;
AppDelegate *delegate ;
PubList *obj_PubList;
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
    
    shiftToNextPage = NO;
    
    self.eventTextLbl.text=_pageName;
    mapArray = [[NSMutableArray alloc] init];
    
    moreNonSubPubsHitCount = 1;

    
    self.view.frame = CGRectMake(0, 0, 320, 395);

   
    _Toolbar = [[[Toolbar alloc]init]autorelease];
   // _Toolbar.layer.borderWidth = 1.0f;
    [self.view addSubview:_Toolbar];
    PubArray = [[[NSMutableArray alloc]init]autorelease];
    NSLog(@"%@",str_distance);
    
    if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"Miles"])
    {
        //-------------------------mb-02-06-12------------------//
        NSString *radius;
        if ([str_distance isEqualToString:@"> 20.0"])
        {   
            radius=[[str_distance stringByReplacingOccurrencesOfString:@">" withString:@""] retain];
            str_distance=[[NSString stringWithFormat:@">%f",[radius floatValue]*1.609344 ] retain];
        }else
        {
            radius=[[str_distance stringByReplacingOccurrencesOfString:@"<=" withString:@""] retain];
            str_distance=[[NSString stringWithFormat:@"<=%f",[radius floatValue]*1.609344] retain];
        }
        //------------------------------------------------------//
    }
    
    PubArray = [[SaveNearMeInfo GetNearMePubsInfo:str_distance]retain];
    
    
    
//    venu_btn=[[UIButton alloc]initWithFrame:CGRectMake(120, 360, 80, 20)];
//    venu_btn.titleLabel.font= [UIFont systemFontOfSize:12.0];
//    venu_btn.layer.borderColor=[UIColor whiteColor].CGColor;
//    venu_btn.layer.borderWidth=1.0;
//    venu_btn.layer.cornerRadius=10.0;
//    venu_btn.titleLabel.textColor=[UIColor whiteColor];
//    [venu_btn setTitle:@"More" forState:UIControlStateNormal];
//    [venu_btn addTarget:self action:@selector(More_btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    venu_btn.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
//    [self.view addSubview:venu_btn];
    
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.view addSubview:backButton];
    
    array4NonSubPubs = [[NSMutableArray alloc] init];
    
    [self getNonSub];
    
    if ([PubArray count] == 0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Sorry no venues match your search criteria within the distance chosen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 10;
        [alert show];
        [alert release];
    }
    
    
}


-(void) getNonSub
{
    NSLog(@"GET_DEFAUL_VALUE(ShowsResultIN) %@",GET_DEFAUL_VALUE(ShowsResultIN));
    
    if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"Miles"])
    {
        //-------------------------mb-02-06-12------------------//
        NSString *radius;
        if ([str_distance isEqualToString:@"> 20.0"])
        {              radius=[str_distance stringByReplacingOccurrencesOfString:@">" withString:@""];
            str_distance=[[NSString stringWithFormat:@">%f",[radius floatValue]*1.609344] retain];
        }else
        {
            radius=[str_distance stringByReplacingOccurrencesOfString:@"<=" withString:@""];
            str_distance=[[NSString stringWithFormat:@"<=%f",[radius floatValue]*1.609344] retain];
        }
        //------------------------------------------------------//
    }
    
    NSMutableArray *tempArray = [[SaveNearMeInfo GetNearMeNonSubPubsInfo:str_distance withLimitValue:[GET_DEFAUL_VALUE(ShowNumberOfPubs) intValue] hitCount:moreNonSubPubsHitCount]retain];
    
    
    for (id result in tempArray) {
        
        [array4NonSubPubs addObject:result];
    }
    //array4NonSubPubs = [tempArray retain];
    [tempArray release];
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"PubDistance" ascending:YES selector:@selector(compare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [array4NonSubPubs sortedArrayUsingDescriptors:sortDescriptors];
    
    [array4NonSubPubs removeAllObjects];
    [array4NonSubPubs addObjectsFromArray:sortedArray];
    
    NSLog(@"NonSubPubs  %@   \nSubPubs %@",array4NonSubPubs,PubArray);
    
    /*NSArray *copy = [array4NonSubPubs copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([array4NonSubPubs indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [array4NonSubPubs removeObjectAtIndex:index];
            NSLog(@"REMOVAL  %d",index);
        }
        index--;
    }
    [copy release];*/
    
    if ([array4NonSubPubs count] == 0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Non-Subscribed Venues Found! Please Try Again......" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 10;
        [alert show];
        [alert release];
    }
}




-(void)CreateHomeView{
    
    table_list = [[UITableView alloc]init];
    table_list.delegate=self;
    table_list.dataSource=self;
    table_list.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    table_list.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    table_list.separatorColor = [UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
//*****************************************************************//    
    //btn_view=[[UIView alloc]init];
    //btn_view.backgroundColor=[UIColor whiteColor];
    
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
                [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateHighlighted];

                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateHighlighted];
                
                
                
            }
            else{
                [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateHighlighted];
                
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateHighlighted];
                
                
                
            }
        }
        
        table_list.hidden=NO;
        
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
                [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateHighlighted];
                
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateHighlighted];
                
                
                
            }
            else{
                [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateHighlighted];
                
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateHighlighted];
                
                
                
            }
        }
        
        table_list.hidden=YES;
        obj_nearbymap.hidden=NO;
        //venu_btn.hidden=YES;
    }
    //------------------------------------------------//
    //[seg_control addTarget:self action:@selector(ClickSegCntrl:) forControlEvents:UIControlEventValueChanged];
    
    [self setHomeViewFrame];
    
    [self.view addSubview:table_list];
    //[self.view addSubview:seg_control];
    
    //[self.view addSubview:btn_view];
    [self.view addSubview:list_btn];
    [self.view addSubview:map_btn];
    //[btn_view release];
    [list_btn release];
    [map_btn release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
 app.IsNonsubscribed=NO;
    
    if (!shiftToNextPage) {
        [self SetCustomNavBarFrame];
        [self setHomeViewFrame];
        
        // delegate.ismore=NO;
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
                //venu_btn.hidden=YES;
            }
            else
            {
                
            }
                //venu_btn.hidden=NO;
        }
        //--------------------------------------------------------//
        
        else
        {
            
            for ( int i=0; i<[PubArray count]; i++) {
                [pub_list addObject:[PubArray objectAtIndex:i]];
                
            }
            //venu_btn.hidden=YES;
        }
        //[self callingMapview];
        
        [mapArray removeAllObjects];
        
        for (id result in pub_list) {
            
            [mapArray addObject:result];
        }
        
        for (id result in array4NonSubPubs) {
            
            [mapArray addObject:result];
        }
        
        obj_nearbymap = [[NearByMap alloc] initWithFrame:CGRectMake(10, 75, 300, 290) withArray:mapArray withController:self];
        [self.view addSubview:obj_nearbymap];
        obj_nearbymap.hidden = YES;
        
        [self CreateHomeView];
        //[table_list reloadData];
        
    }
    [self AddNotification];

    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
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
    
    obj.textString = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}                     


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
    [mailController setMessageBody:[NSString stringWithFormat:@"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto"] isHTML:NO];
    
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
    MyProfileSetting *obj_MyProfileSetting=[[MyProfileSetting alloc]initWithNibName:[Constant GetNibName:@"MyProfileSetting"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_MyProfileSetting animated:YES];
    [obj_MyProfileSetting release];
}

- (void)ShareInLinkedin:(NSNotification *)notification {
    
    LinkedINViewController *obj = [[LinkedINViewController alloc] initWithNibName:@"LinkedINViewController" bundle:nil];
    
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    
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
    
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
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
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Greetings", @"name",
     @"Check it out!", @"caption",
     //@"Want to share through Greetings", @"description",
     @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8",@"message",
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


-(IBAction)List_btnClick:(id)sender{
    
    table_list.hidden = NO;
    obj_nearbymap.hidden = YES;
    _IsSelect=NO;
    if([pub_list count] == [PubArray count]){
        //venu_btn.hidden=YES;
    } 
    else
        //venu_btn.hidden=NO;
    
    
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
            
            
            
            
        }
        else{
            [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateNormal];
            [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
            
            
            
        }
    }
    
}


-(IBAction)Map_btnClick:(id)sender{
    
    table_list.hidden = YES;
    obj_nearbymap.hidden = NO;
    //venu_btn.hidden=NO;
    _IsSelect=YES;
    [self callingMapview];
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
//*********************************** amit-04/06/2012 ************************//
           [obj_nearbymap setFrameOfView:CGRectMake(10, 124, 300, 290)];
//*****************************************************************//  
            
        }
        else{
            [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
            [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
    //*********************************** amit-04/06/2012 ************************//
            [obj_nearbymap setFrameOfView:CGRectMake(10, 120, 460, 135)];
    //*****************************************************************//  
            
        }
    }
}


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
        
        // NSString *msg_str=[NSString stringWithFormat:@"Successfully %d pubs and bars has been added",noOfPubs];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"More venues successfully added – scroll down to see more" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        alert.tag=40;
        [alert show];
        [alert release];
        
        //[obj_nearbymap removeFromSuperview];
        //[obj_nearbymap release];
     //   [self callingMapview];
        
    }
    else
    {
        for (int j=0; j<[PubArray count]; j++) {
            [pub_list addObject:[PubArray objectAtIndex:j]];
            
        }
        [table_list reloadData];
        NSString *msg_str=[NSString stringWithFormat:@"Successfully %d pubs and bars has been added",noOfPubs];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:msg_str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       
        alert.tag=40;
        [alert show];
        [alert release];
       
        
        //[obj_nearbymap removeFromSuperview];
        //[obj_nearbymap release];
       // [self callingMapview];
        
        //venu_btn.hidden=YES;
        
       
        
    }
    
}

-(void) MoreButtonClick4NonSubPubs:(id) sender
{
    [self getNonSub];
    [table_list reloadData];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Scroll down to see more non subscribed venues." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag=40;
    [alert show];
    [alert release];

}


-(void)callingMapview{
    
    NSLog(@"pub_list  %@",pub_list);
    if (obj_nearbymap) {
        
        [obj_nearbymap removeFromSuperview];
        [obj_nearbymap release];
    }
    
    //mapArray = [[NSMutableArray alloc] init];
    [mapArray removeAllObjects];
    
    for (id result in pub_list) {
        
        [mapArray addObject:result];
    }
    
    for (id result in array4NonSubPubs) {
        
        [mapArray addObject:result];
    }
    
    obj_nearbymap = [[NearByMap alloc]initWithFrame:CGRectMake(0, 124, 320, 290) withArray:mapArray withController:self];
    [self.view addSubview:obj_nearbymap];
    if (_IsSelect==NO)
     {
         obj_nearbymap.hidden=YES;
     }
    else
        obj_nearbymap.hidden=NO;
    
}

-(void)setHomeViewFrame{
    
    if ([Constant isiPad]){
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            table_list.frame = CGRectMake(10, 132, 300, 282);
            table_list.scrollEnabled = YES;
           // seg_control.frame = CGRectMake(90, 4, 140, 25);
            [obj_nearbymap setFrameOfView:CGRectMake(10, 133, 300, 290)];
            //venu_btn.frame=CGRectMake(120, 392, 80, 20);
    //*****************************************************************//          
//            btn_view.frame=CGRectMake(130, 6, 65.5, 19.5);
//            list_btn.frame=CGRectMake(0.5, 0.5, 32, 18.5);
//            map_btn.frame=CGRectMake(32.5, 0.5, 32, 18.5);
             backButton.frame=CGRectMake(8, 90, 50, 25);
           //btn_view.frame=CGRectMake(81, 102, 158, 21);
            list_btn.frame=CGRectMake(95, 90, 79, 32);
            map_btn.frame=CGRectMake(170, 90, 79, 32);
            
            if (delegate.ismore==YES) {
               // _Toolbar.frame = CGRectMake(-320, 387, 640, 48);
                 _Toolbar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            else{
                //_Toolbar.frame = CGRectMake(0, 387, 640, 48);
                 _Toolbar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            
                        
            if (_IsSelect==NO) {
                [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
                
            }
            else
            {
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                
           }
        }
 //*****************************************************************//             
        else{
            table_list.frame = CGRectMake(10, 120, 460, 135);
            table_list.scrollEnabled = YES;
            //seg_control.frame = CGRectMake(140, 14, 200, 25);
            [obj_nearbymap setFrameOfView:CGRectMake(10, 120, 460, 135)];
            //venu_btn.frame=CGRectMake(190, 235, 100, 20);
  
            
            
            //btn_view.frame=CGRectMake(160, 84, 158, 21);
            list_btn.frame=CGRectMake(155, 83, 79, 32);
            map_btn.frame=CGRectMake(230, 83, 79, 32);
            
            backButton.frame = CGRectMake(10, 85, 50, 25);
            
            if (delegate.ismore==YES) {
              
                _Toolbar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                _Toolbar.frame = CGRectMake(8.5, 261, 463, 53);
            }

            
            if (_IsSelect==NO) {
                [list_btn setImage:[UIImage imageNamed:@"BigListSelect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapDeselect.png"] forState: UIControlStateNormal];
                
            }
            else
            {
                [list_btn setImage:[UIImage imageNamed:@"BigListDeselect.png"] forState: UIControlStateNormal];
                [map_btn setImage:[UIImage imageNamed:@"BigMapSelect.png"] forState: UIControlStateNormal];
                
            }
          }

        }
}



-(IBAction)ClickBack:(id)sender{
       [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 23)];
    view.contentMode = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:182.0/255.0 green:192.0/255.0 blue:199.0/255.0 alpha:0.9] CGColor], (id)[[UIColor colorWithRed:151.0/255.0 green:165.0/255.0 blue:175.0/255.0 alpha:0.9] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:1];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    
    if (section == 0) {
        NSString *sectionTitle = @"  Subscribed Venues (full info)";
        
        // Create label with section title
        UILabel *label = [[[UILabel alloc] init] autorelease];
        label.frame = CGRectMake(0, 0, tableView.bounds.size.width, 23);
        label.contentMode = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.textColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        label.font = [UIFont boldSystemFontOfSize:14.0];
        label.text = sectionTitle;
        label.backgroundColor = [UIColor clearColor];
        //label.shadowOffset = CGSizeMake(0, 1);
        //label.layer.masksToBounds = YES;
        //label.shadowColor = [UIColor blackColor];
        
        //label.backgroundColor = [UIColor clearColor];
        [view autorelease];
        [view addSubview:label];
    }
    if (section == 1 && [array4NonSubPubs count] != 0){
        
        NSString *sectionTitle = @"  Non-Subscribed Venues (basic info)";
        
        // Create label with section title
        UILabel *label = [[[UILabel alloc] init] autorelease];
        label.frame = CGRectMake(0, 0, tableView.bounds.size.width, 23);
        label.contentMode = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        label.textColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
        label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        label.font = [UIFont boldSystemFontOfSize:14.0];
        label.text = sectionTitle;
        label.backgroundColor = [UIColor clearColor];
        //label.layer.shadowOffset = CGSizeMake(0, 1);
        label.layer.masksToBounds = YES;
        //label.shadowOffset = CGSizeMake(-1, 0);
        //label.shadowColor = [UIColor blackColor];
        
        //label.backgroundColor = [UIColor clearColor];
        [view autorelease];
        [view addSubview:label];
    }
       
    // Create header view and add label as a subview
    
    
    return view;
}

/*
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Subscribed Venues(full info)";
    }
    if (section == 1 && [array4NonSubPubs count] != 0){
        return @"Non-Subscribed Venues(basic info)";
    }
    return nil;
}*/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{        NSLog(@"[array4NonSubPubs count]  %d section %d",[array4NonSubPubs count],section);

	if (section == 0) {
        if ([PubArray count] > [pub_list count])
        return [pub_list count] +1;
        else
            return [pub_list count];

    }
    if (section == 1){
        return [array4NonSubPubs count]+1;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    
        
        /*const NSInteger TOP_LABEL_TAG = 1001;
        const NSInteger PUSH_IMAGE_TAG = 1003;
        const NSInteger MAINVIEW_VIEW_TAG = 1004;
        const NSInteger MID_LABEL_TAG=1005;
        const NSInteger TOP_IMAGE_TAG=1002;
        const NSInteger MIDDLE_LABEL_TAG=1006;
        
        AsyncImageView_New *pubImage;
        UILabel *label4Name;
        UILabel *label4Distance;
        UIView *vw;
        UIImageView *pushImg;
        UILabel *middleLbl;*/
        
    //static NSString *CellIdentifier = @"Cell";
    static NSString *postCellId = @"postCell";
    static NSString *moreCellId = @"moreCell";
    //UITableViewCell *cell = nil;
    NearMeNowCell *nearMeNowCell = nil;

    if (indexPath.section == 0) {
        
        NSUInteger row = [indexPath row];
        NSUInteger count = [pub_list count];
        
        if (row == count) {
            
            nearMeNowCell = (NearMeNowCell *)[aTableView dequeueReusableCellWithIdentifier:moreCellId];
            if (nearMeNowCell == nil) {
                nearMeNowCell = [[[NearMeNowCell alloc] 
                                  initWithStyle:UITableViewCellStyleDefault 
                                  reuseIdentifier:moreCellId] autorelease];
            }
            
            nearMeNowCell.textLabel.text = @"Touch to load more items...";
            nearMeNowCell.textLabel.textAlignment = UITextAlignmentCenter;
            nearMeNowCell.textLabel.textColor = [UIColor whiteColor];
            nearMeNowCell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            [nearMeNowCell.pushImg removeFromSuperview];
            [nearMeNowCell.pubImage removeFromSuperview];
            [nearMeNowCell.label4Name removeFromSuperview];
            [nearMeNowCell.label4Distance removeFromSuperview];
        }
        
        else{
            
            nearMeNowCell = (NearMeNowCell *)[aTableView dequeueReusableCellWithIdentifier:postCellId];
            
            if (nearMeNowCell == nil)
            {
                
                nearMeNowCell = [[[NearMeNowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postCellId] autorelease];
                nearMeNowCell.frame = CGRectMake(0, 0, aTableView.frame.size.width, 50);
                
                
                
            }
        }
    }
    
    if (indexPath.section == 1) {
        
        NSUInteger row = [indexPath row];
        NSUInteger count = [array4NonSubPubs count];
        
        if (row == count) {
            
            nearMeNowCell = (NearMeNowCell *)[aTableView dequeueReusableCellWithIdentifier:moreCellId];
            if (nearMeNowCell == nil) {
                nearMeNowCell = [[[NearMeNowCell alloc] 
                         initWithStyle:UITableViewCellStyleDefault 
                         reuseIdentifier:moreCellId] autorelease];
            }
            
            nearMeNowCell.textLabel.text = @"Touch to load more items...";
            nearMeNowCell.textLabel.textAlignment = UITextAlignmentCenter;
            nearMeNowCell.textLabel.textColor = [UIColor whiteColor];
            nearMeNowCell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            [nearMeNowCell.pushImg removeFromSuperview];
            [nearMeNowCell.pubImage removeFromSuperview];
            [nearMeNowCell.label4Name removeFromSuperview];
            [nearMeNowCell.label4Distance removeFromSuperview];

            
        }
        
        else{
            
            nearMeNowCell = (NearMeNowCell *)[aTableView dequeueReusableCellWithIdentifier:postCellId];
            
            if (nearMeNowCell == nil)
            {
                
                nearMeNowCell = [[[NearMeNowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postCellId] autorelease];
                nearMeNowCell.frame = CGRectMake(0, 0, aTableView.frame.size.width, 50);

                
                
                
            }
        }
    }
    
    
        
        
        //else
        /*{
            label4Name = (UILabel *)[cell.contentView viewWithTag:TOP_LABEL_TAG];
            
            middleLbl = (UILabel *)[cell.contentView viewWithTag:MIDDLE_LABEL_TAG];
            pushImg=(UIImageView*)[cell.contentView viewWithTag:PUSH_IMAGE_TAG];
            vw=(UIView*)[cell.contentView viewWithTag:MAINVIEW_VIEW_TAG];
            label4Distance = (UILabel *)[cell.contentView viewWithTag:MID_LABEL_TAG];
            pubImage = (AsyncImageView_New *)[cell.contentView viewWithTag:TOP_IMAGE_TAG];
            
        }*/
    
    
     
        @try {
            
            if (indexPath.section == 0) {
                
                //NSLog(@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]);
                nearMeNowCell.label4Name.text = [[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName"];
                nearMeNowCell.middleLbl.text=[NSString stringWithFormat:@"%@",[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistrict"]];
                
                
                
                //middleLable.text = [NSString stringWithFormat:@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]];
                //-----------------------------------------mb-28-05-12--------//
                if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
                    nearMeNowCell.label4Distance.text= [NSString stringWithFormat: @"%d Km",(int)floor([[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"] doubleValue])];
                else
                    nearMeNowCell.label4Distance.text=[NSString stringWithFormat:@"%d Miles",(int)floor([[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192)];
                
                NSLog(@"DISTANCE   %@",[NSString stringWithFormat:@"%0.2f Miles",[[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192]);
                NSLog(@"PHOTO URL  %@",[[pub_list objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"]);
                NSLog(@"NAME   %@",[[pub_list objectAtIndex:indexPath.row]valueForKey:@"PubName"]);
                
                [[AsyncImageLoader sharedLoader] cancelLoadingURL:nearMeNowCell.pubImage.imageURL];
                nearMeNowCell.pubImage.image = [UIImage imageNamed:@"icon.png"];
                
                if ([[[pub_list objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"] length] != 0) {
                    
                    NSString *tempurl=[NSString stringWithFormat:[[pub_list objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"]];
                    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    NSURL *url = [[NSURL alloc] initWithString:tempurl];
                    nearMeNowCell.pubImage.imageURL = url;
//                    UIImage *tempImage = [pubImage.image retain];
//                    CGSize newSize = CGSizeMake(40, 40);
//                    pubImage.image = [self imageScaledToSize:newSize oldImage:tempImage];
                }
            
            }
            if(indexPath.section == 1){
                
                //NSLog(@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]);
                nearMeNowCell.label4Name.text = [[array4NonSubPubs objectAtIndex:indexPath.row]valueForKey:@"PubName"];
                nearMeNowCell.middleLbl.text=[NSString stringWithFormat:@"%@",[[array4NonSubPubs objectAtIndex:indexPath.row]valueForKey:@"PubDistrict"]];
                
                
                
                //middleLable.text = [NSString stringWithFormat:@"%f",[[[PubArray objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]];
                //-----------------------------------------mb-28-05-12--------//
                if ([GET_DEFAUL_VALUE(ShowsResultIN) isEqualToString:@"KM"])
                    nearMeNowCell.label4Distance.text= [NSString stringWithFormat: @"%d Km",(int)floor([[[array4NonSubPubs objectAtIndex:indexPath.row] valueForKey:@"PubDistance"] doubleValue])];
                else
                    nearMeNowCell.label4Distance.text=[NSString stringWithFormat:@"%d Miles",(int)floor([[[array4NonSubPubs objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192)];
                
                NSLog(@"DISTANCE   %@",[NSString stringWithFormat:@"%0.2f Miles",[[[array4NonSubPubs objectAtIndex:indexPath.row]valueForKey:@"PubDistance"]doubleValue]* 0.6213371192]);
                NSLog(@"PHOTO URL  %@",[[array4NonSubPubs objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"]);
                NSLog(@"NAME   %@",[[array4NonSubPubs objectAtIndex:indexPath.row]valueForKey:@"PubName"]);
                
                //[[AsyncImageLoader sharedLoader] cancelLoadingURL:pubImage.imageURL];
                nearMeNowCell.pubImage.image = [UIImage imageNamed:@"icon.png"];
                
               /* if ([[[pub_list objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"] length] != 0) {
                    
                    NSString *tempurl=[NSString stringWithFormat:[[pub_list objectAtIndex:indexPath.row] valueForKey:@"venuePhoto"]];
                    tempurl = [tempurl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    NSURL *url = [[NSURL alloc] initWithString:tempurl];
                    pubImage.imageURL = url;
                }*/
            }
            
            
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
    
        nearMeNowCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return nearMeNowCell;
    
}

//****************************************** amit-04/06/2012 *************************//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        NSUInteger row = [indexPath row];
        NSUInteger count = [pub_list count];
        
        if (row == count) {
            
            //NSArray *newPosts = [feed newPosts];
            /*NSUInteger newCount = [array count];
             
             if (newCount) {
             
             [self.posts addObjectsFromArray:newPosts];
             [newPosts release];
             
             NSMutableArray *insertIndexPaths = [NSMutableArray array];
             for (NSUInteger item = count; item < count + newCount; item++) {
             
             [insertIndexPaths addObject:[NSIndexPath indexPathForRow:item 
             inSection:0]];
             }
             
             [self.tableView beginUpdates];
             [self.tableView insertRowsAtIndexPaths:insertIndexPaths 
             withRowAnimation:UITableViewRowAnimationFade];
             [self.tableView endUpdates];
             
             [self.tableView scrollToRowAtIndexPath:indexPath 
             atScrollPosition:UITableViewScrollPositionNone 
             animated:YES];
             
             NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
             if (selected) {
             [self.tableView deselectRowAtIndexPath:selected animated:YES];
             }
             }*/
            
            [self performSelector:@selector(More_btnClick:)];
            
        }
        else {
            if ([[delegate sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]]])
            {
                [self afterSuccessfulConnection:[[delegate sharedDefaults] objectForKey:[NSString stringWithFormat:@"PubID:%@",[[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]]]];
            }
            else
            {
                [self performSelector:@selector(addMBHud)];
                [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
            }
            
        }
        
        
    }
    
    /*else if (indexPath.section == 1){
        
        NSUInteger row = [indexPath row];
        NSUInteger count = [array4NonSubPubs count];
        
        if (row == count) {
            moreNonSubPubsHitCount++;

            [self performSelector:@selector(MoreButtonClick4NonSubPubs:)];

        }
        else{
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"Sorry no details found for Non-subscribed pubs" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //alert.tag = 10;
            [alert show];
            [alert release];
        }
        
        
    }*/
    else if (indexPath.section == 1){
        
        NSUInteger row = [indexPath row];
        NSUInteger count = [array4NonSubPubs count];
        
        if (row == count) {
            moreNonSubPubsHitCount++;

            [self performSelector:@selector(MoreButtonClick4NonSubPubs:)];
                                            
        }
        else{
            
            delegate.IsNonsubscribed=YES;
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            obj_detail.bulletPointArray=[array4NonSubPubs objectAtIndex:row];
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
            
        }
        
        
        }

    
}


#pragma mark Image Scaling

- (UIImage*) imageScaledToSize: (CGSize) newSize  oldImage:(UIImage*)oldImage
{
	UIGraphicsBeginImageContext(newSize);
	[oldImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}


#pragma mark Calling Server

-(void) callingServer
{    // && [InternetValidation hasConnectivity]
    if([InternetValidation  checkNetworkStatus])
    {
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        NSLog(@"%@",[[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]);
        [conn1 getPubDetails:[[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"]];
        [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    else
    {
        //[self performSelector:@selector(dismissHUD:)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable. Do you want to retry?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 30) {
        [self performSelector:@selector(dismissHUD:)];

        if (buttonIndex == 0) {
            
            [self performSelector:@selector(addMBHud)];
            [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];
        }
        else{
            [self performSelector:@selector(dismissHUD:)];
            
        }
    }
    if (alertView.tag == 10) {
        
        if (buttonIndex == 0) {
            
            //[self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if (alertView.tag == 40) {
        if (buttonIndex == 0) {
        [self callingMapview];
            [self setHomeViewFrame];
        }
    }
}


#pragma mark ServerConnection Delegates


-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
    NSMutableArray *pubDetailsArray = [[[json valueForKey:@"pubDetails"] valueForKey:@"details"] retain];
    
    if ([pubDetailsArray count] != 0) {
        
        //[[delegate sharedDefaults] setObject:data_Response forKey:[NSString stringWithFormat:@"PubID:%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"]]];
        //[[delegate sharedDefaults] synchronize];
        
        NSString *PUBID = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubID"];
        //NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubEmail"]);
        NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"Mobile"]);
        NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubWebsite"]);
        NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubDescription"]);
        NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"venuePhoto"]);
        NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"venueCapacity"]);
        NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestRail"]);
        NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestTube"]);
        NSLog(@"%@",[[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"LocalBuses"]);
        NSLog(@"%@",[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"]);
        //NSArray *Arr_PubComp = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"]
        
        //**************************** Biswa ******************************************************
        //*********************** Update Pub Details **********************************************  
        
       
        
        bulletPointArray=[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubBullet"] retain];
        
        NSLog(@"%@",bulletPointArray);
        
        
              
        NSMutableDictionary *OpenHoursDictionary=[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubOpenHours"] retain];
        //    NSMutableArray *arr;
        //    [arr addObject:OpenHoursDictionary];
        openingHours4Day = (NSMutableArray *)[[[OpenHoursDictionary keyEnumerator] allObjects] retain];
        openingHours4Hours = [[NSMutableArray alloc] init];
        for (int i = 0; i<[openingHours4Day count]; i++) {
            
            [openingHours4Hours addObject:[OpenHoursDictionary valueForKey:[openingHours4Day objectAtIndex:i]]];
        }
        
        NSLog(@"ARRAy   %@   %@",openingHours4Day,openingHours4Hours); 
        NSLog(@"%d %@",[OpenHoursDictionary count],[[OpenHoursDictionary keyEnumerator] allObjects]);
        

        
        
        NSString *pubEmail = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubEmail"];
        NSString *pubMobile = [[pubDetailsArray objectAtIndex:0] valueForKey:@"Mobile"];
        NSString *pubWebsite = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubWebsite"];
        NSString *pubDescription = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubDescription"];
        NSString *venuePhoto = [[pubDetailsArray objectAtIndex:0] valueForKey:@"venuePhoto"];
        NSString *venueStyle = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"venueStyle"];
        NSString *venueCapacity = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"venueCapacity"];
        NSString *pubNearestRail = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestRail"];
        NSString *pubNearestTube = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"NearestTube"];
        NSString *pubLocalBuses = [[[pubDetailsArray objectAtIndex:0] valueForKey:@"otherDetails"] valueForKey:@"LocalBuses"];
        NSString *pubCompany = [[[[pubDetailsArray objectAtIndex:0] valueForKey:@"pubCompany"] objectAtIndex:0] valueForKey:@"pubCompany"];
        NSString *pubAddressAll = [[pubDetailsArray objectAtIndex:0] valueForKey:@"pubAddressAll"];
        NSString *pubPhoneNo = @"No Info";
        
        if (pubEmail.length == 0) {
            
            pubEmail = @"No Info";
        }
        if (pubMobile.length == 0) {
            
            pubMobile = @"No Info";
        }
        if (pubWebsite.length == 0) {
            
            pubWebsite = @"No Info";
        }
        if (pubDescription.length == 0) {
            
            pubDescription = @"No Info";
        }
        if (venuePhoto.length == 0) {
            
            venuePhoto = @"No Info";
        }
        if (venueStyle.length == 0) {
            
            venueStyle = @"No Info";
        }
        if (venueCapacity.length == 0) {
            
            venueCapacity = @"No Info";
        }
        if (pubNearestRail.length == 0) {
            
            pubNearestRail = @"No Info";
        }
        if (pubNearestTube.length == 0) {
            
            pubNearestTube = @"No Info";
        }
        if (pubLocalBuses.length == 0) {
            
            pubLocalBuses = @"No Info";
        }
        if (pubCompany.length == 0) {
            
            pubCompany = @"No Info";
        }
        if (pubAddressAll.length == 0) {
            
            pubAddressAll = @"No Info";
        }
        
        
        
        
        [[DBFunctionality sharedInstance] InsertValue_Pub_details:pubEmail pubMobile:pubMobile pubWebsite:pubWebsite pubdescription:pubDescription pubImage:venuePhoto venueStyle:venueStyle venueCapacity:venueCapacity nearestRail:pubNearestRail nearestTube:pubNearestTube localBuses:pubLocalBuses pubCompany:pubCompany PubID:PUBID PubAddress:pubAddressAll PubPhoneNo:pubPhoneNo];
        //*********************** Update Pub Details **********************************************
        
        
        //******************************Pub_Photo*************************************************** 
        
        NSMutableArray *GeneralImagesArray = [[[pubDetailsArray objectAtIndex:0]valueForKey:@"General Images"] retain];
        NSMutableArray *FunctionRoomImagesArray = [[[pubDetailsArray objectAtIndex:0]valueForKey:@"Function Room Images"] retain];
        NSMutableArray *FoodordrinkImagesArray = [[[pubDetailsArray objectAtIndex:0]valueForKey:@"Food or drink Images"] retain];
        
        for (int i = 0; i < [GeneralImagesArray count]; i++) {
            
            if (![GeneralImagesArray valueForKey:@"info"]) {
                [[DBFunctionality sharedInstance] InsertValue_Pub_PhotoWithPubID:PUBID GeneralImages:[[GeneralImagesArray objectAtIndex:i] valueForKey:@"Photo"] GeneralImageID:[[GeneralImagesArray objectAtIndex:i] valueForKey:@"ID"]];
            }
            
        }
        
        for (int m = 0; m < [FunctionRoomImagesArray count]; m++) {
            
            
            if (![FunctionRoomImagesArray valueForKey:@"info"]) {
                [[DBFunctionality sharedInstance] InsertValue_Pub_PhotoWithPubID:PUBID FunctionRoomImages:[[FunctionRoomImagesArray objectAtIndex:m] valueForKey:@"Photo"] FunctionRoomImageID:[[FunctionRoomImagesArray objectAtIndex:m] valueForKey:@"ID"]];
            }
            
        }
        
        for (int l = 0; l < [FoodordrinkImagesArray count]; l++) {
            
            
            
            if (![FoodordrinkImagesArray valueForKey:@"info"]) {
                [[DBFunctionality sharedInstance] InsertValue_Pub_PhotoWithPubID:PUBID FoodDrinkImages:[[FoodordrinkImagesArray objectAtIndex:l] valueForKey:@"Photo"] FoodDrinkImageID:[[FoodordrinkImagesArray objectAtIndex:l] valueForKey:@"ID"]];
            }
            
            
        }
        //******************************Pub_Photo***************************************************  
        
        
        
        //******************************* Event ****************************************************
        //if ([delegate.sharedDefaults objectForKey:@"Events"]) {
            NSMutableArray *Arr_AllEvent = [[pubDetailsArray objectAtIndex:0] valueForKey:@"Event"];
            NSLog(@"%@",[Arr_AllEvent valueForKey:@"info"]);
            
            for (int i = 0; i < [Arr_AllEvent count]; i++) {
                NSMutableDictionary *Dict_Event = [Arr_AllEvent objectAtIndex:i];
                NSString *Event_Type_ID = [[Dict_Event valueForKey:@"Event ID"] retain];
                NSString *event_name = [[Dict_Event valueForKey:@"Event Name"] retain];
                NSMutableArray *Arr_EventDetails = [[Dict_Event valueForKey:@"Event Details"] retain];
                NSLog(@"%@",Event_Type_ID);
                NSLog(@"%@",event_name);
                NSLog(@"%@",Arr_EventDetails);
                for (int j = 0; j < [Arr_EventDetails count]; j++) {
                    NSLog(@"%@",[Arr_EventDetails valueForKey:@"info"]);
                    NSString *Event_ID = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"ID"];
                    NSString *Date = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Event Date"];
                    NSString *Event_Desc = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Event Description"];
                    if (![[[Arr_EventDetails objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"No Details Available"]) {
                        
                        
                        if (Date.length == 0) {
                            Date = [Constant GetCurrentDateTime];
                        }
                        if (Event_Desc.length == 0) {
                            Event_Desc = @"No Info";
                        }
                        
                        [[DBFunctionality sharedInstance] UpdateEvent_DetailByID:Event_ID eventtypeid:Event_Type_ID date:Date eventdesc:Event_Desc PUBID:PUBID isNoInfo:NO];
                    }
                    else{
                        [[DBFunctionality sharedInstance] UpdateEvent_DetailByID:Event_ID eventtypeid:Event_Type_ID date:nil eventdesc:@"No Info" PUBID:PUBID isNoInfo:YES];
                        
                    }
                    //[Event_ID release];
                    //[Date release];
                    //[Event_Desc release];
                }
                [Arr_EventDetails release];
            }
            [Arr_AllEvent release];
        //}
        
        //******************************* Event ****************************************************
        
        //****************************** Food and offers *******************************************
        //if ([delegate.sharedDefaults objectForKey:@"Food"]) {
            //NSMutableDictionary *foodDictioinary = [[pubDetailsArray valueForKey:@"Food & Offers"] retain];
            NSMutableArray *Arr_Foodandoffers = [[pubDetailsArray valueForKey:@"Food & Offers"] retain];
            //if ([foodDictioinary ob] != nil) {
            NSString *str_foodinfo = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Food Information"] retain];
            NSString *str_foodservingtime = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Food Serving Time"] retain];
            NSString *str_chefdescription = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Chef Description"] retain];
            NSString *str_special_offers = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Special Offers"] retain];
            
            if (str_foodinfo.length == 0) {
                
                str_foodinfo = @"No Info";
            }
            if (str_foodservingtime.length == 0) {
                
                str_foodservingtime = @"No Info";
            }
            if (str_chefdescription.length == 0) {
                
                str_chefdescription = @"No Info";
            }
            if (str_special_offers.length == 0) {
                
                str_special_offers = @"No Info";
            }
            
            NSMutableArray *Arr_foodType = [[[Arr_Foodandoffers objectAtIndex:0] valueForKey:@"Food Type"] retain];
            //if (![[[Arr_foodType objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
            for (int i = 0; i < [Arr_foodType count]; i++) {
                [[DBFunctionality sharedInstance] UpdateFoodDetailsByFoodTypeId:[[Arr_foodType objectAtIndex:0] valueForKey:@"ID"] byPubID:PUBID FoodInfor:str_foodinfo FoodServingTime:str_foodservingtime Chiefdesc:str_chefdescription SpeicalOffers:str_special_offers];
                //[[DBFunctionality sharedInstance] UpdateFoodDetailsByFoodTypeId:[[Arr_foodType objectAtIndex:0] valueForKey:@"ID"] byPubID:[[pubDetailsArray objectAtIndex:0] valueForKey:@"PubID"] FoodInfor:nil FoodServingTime:str_foodservingtime Chiefdesc:str_chefdescription SpeicalOffers:str_special_offers];
                //}
            }
            //}
        //}
        
        //****************************** Food and offers *******************************************
        
        
        //***************************** Facilities *************************************************
        //if ([delegate.sharedDefaults objectForKey:@"Facilities"]) {
            NSMutableArray *Array_Facilities = [pubDetailsArray valueForKey:@"Facilities"];
            NSString *Str_FacilitiesInfo = [[[Array_Facilities objectAtIndex:0] valueForKey:@"Facility Information"] retain];
            
            if (Str_FacilitiesInfo.length == 0) {
                
                Str_FacilitiesInfo = @"No Info";
            }
            
            NSMutableArray *Arr_FacilitiesType = [[Array_Facilities objectAtIndex:0] valueForKey:@"Facilities Type"];
            //if (![[[Arr_FacilitiesType objectAtIndex:0]valueForKey:@"info"] isEqualToString:@"<null>"]){
            for (int i = 0; i < [Arr_FacilitiesType count]; i++) {
                NSString *Str_FacilitiesTypeId = [[Arr_FacilitiesType objectAtIndex:i] valueForKey:@"ID"];
                [[DBFunctionality sharedInstance] UpdateAmmenitiesDetailsbyPubId:PUBID AmmnitiesID:Str_FacilitiesTypeId FacilitiesInfo:Str_FacilitiesInfo];
            }
            // }
            
        //}
        //***************************** Facilities *************************************************
        
        
        
        
        
        
        //***************************** Real Ale ***************************************************
        //if ([delegate.sharedDefaults objectForKey:@"Real Ale"]) {
            NSMutableArray *Arr_RealAle = [[pubDetailsArray objectAtIndex:0] valueForKey:@"Real Ale"];
            //if (![[[Arr_RealAle objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
            NSMutableArray *Arr_RealAleDetails = [[Arr_RealAle objectAtIndex:0] valueForKey:@"Real Ale Details"];
            if (![[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
                
                NSLog(@"%@",[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"]);
                //NSLog(@"%@",[[[Arr_RealAleDetails objectAtIndex:0]valueForKey:@"info"] objectAtIndex:0]);
                if (![[[Arr_RealAleDetails objectAtIndex:0]valueForKey:@"info"] isEqualToString:@"<null>"]) {
                    NSLog(@"%d",[Arr_RealAleDetails count]);
                    for (int i = 0; i < [Arr_RealAleDetails count]; i++) {
                        NSLog(@"%@",[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerTitle"]);
                        
                        NSString *Str_BeetTitle = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerTitle"];
                        if(Str_BeetTitle.length == 0)
                            Str_BeetTitle = @"No Info";
                        
                        NSString *Str_Breweryname = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BreweryName"];
                        if(Str_Breweryname.length == 0)
                            Str_Breweryname = @"No Info";
                        
                        NSString *Str_Beer_ABV = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"ABV"];
                        if(Str_Beer_ABV.length == 0)
                            Str_Beer_ABV = @"No Info";
                        
                        NSString *Str_Beer_Color = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"See"];
                        if(Str_Beer_Color.length == 0)
                            Str_Beer_Color = @"No Info";
                        
                        NSString *Beer_Smeel = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Smell"];
                        if(Beer_Smeel.length == 0)
                            Beer_Smeel = @"No Info";
                        
                        NSString *Beer_Taste = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Taste"];
                        if(Beer_Taste.length == 0)
                            Beer_Taste = @"No Info";
                        
                        NSString *Str_LicenseNote = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"LicenseeNotes"];
                        if(Str_LicenseNote.length == 0)
                            Str_LicenseNote = @"No Info";
                        
                        NSString *Str_Ale_Name = [[Arr_RealAleDetails objectAtIndex:i] valueForKey:@"BreweryName"];
                        if(Str_Ale_Name.length == 0)
                            Str_Ale_Name = @"No Info";
                        
                        NSString *Str_Ale_Email = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Email"];
                        if(Str_Ale_Email.length == 0)
                            Str_Ale_Email = @"No Info";
                        
                        NSString *Str_AleWebsiteurl = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Email"];
                        if(Str_AleWebsiteurl.length == 0)
                            Str_AleWebsiteurl = @"No Info";
                        
                        NSString *Str_Address = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"Address"];
                        if(Str_Address.length == 0)
                            Str_Address = @"No Info";
                        
                        NSString *Str_Postcode = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"postCode"];
                        if(Str_Postcode.length == 0)
                            Str_Postcode = @"No Info";
                        
                        NSString *Str_Contactname = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"ContactName"];
                        if(Str_Contactname.length == 0)
                            Str_Contactname = @"No Info";
                        
                        NSString *Str_phonenumber = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"PhoneNumber"];
                        if(Str_phonenumber.length == 0)
                            Str_phonenumber = @"No Info";
                        
                        NSString *Str_District = [[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"District"];
                        if(Str_District.length == 0)
                            Str_District = @"No Info";
                        
                        
                        [[DBFunctionality sharedInstance] UpdateBeerDetailsByPubId:PUBID BeerID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"BeerID"] Beer_Name:Str_BeetTitle Catagory:Str_Breweryname Beer_ABV:Str_Beer_ABV Beer_Color:Str_Beer_Color Beer_Smell:Beer_Smeel Beer_Taste:Beer_Taste License_Note:Str_LicenseNote Ale_ID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"AleID"]];
                        
                        
                        
                        [[DBFunctionality sharedInstance] UpdateRealAleDetailsByPubId:PUBID Ale_ID:[[Arr_RealAleDetails objectAtIndex:i]valueForKey:@"AleID"] Ale_Name:Str_Ale_Name Ale_MailID:Str_Ale_Email Ale_Website:Str_AleWebsiteurl Ale_Address:Str_Address Ale_Postcode:Str_Postcode Ale_ContactName:Str_Contactname Ale_PhoneNumber:Str_phonenumber Ale_District:Str_District];
                    }
                    
                }
            }
            //NSLog(@"%@",[[[Arr_RealAleDetails objectAtIndex:0] valueForKey:@"info"]);
            
            //}
        //}
        //***************************** Real Ale ***************************************************
        
        
        
        
        
        //***************************** Sports & TV ************************************************
        //Sport_Id will be add in Json,then I have to implement it....
        //if ([delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
            NSMutableArray *Arr_SportsEvent = [[pubDetailsArray valueForKey:@"SportsEvent"] retain];
            if (![[[[Arr_SportsEvent objectAtIndex:0] objectAtIndex:0] valueForKey:@"info"] isEqualToString:@"<null>"]) {
                NSMutableArray *Arr_SportsEventDetails = [[[[Arr_SportsEvent objectAtIndex:0] objectAtIndex:0] valueForKey:@"Sports Event Details"] retain];
                if (![[[Arr_SportsEventDetails objectAtIndex:0]  valueForKey:@"info"] isEqualToString:@"<null>"]) {
                    NSLog(@"%d",[Arr_SportsEventDetails count]);
                    for (int i = 0; i < [Arr_SportsEventDetails count]; i++) {
                        
                        
                        NSString *Str_Type = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Type"];
                        if(Str_Type.length == 0)
                            Str_Type = @"No Info";
                        
                        NSString *Str_ThreeD = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"threeD"];
                        if(Str_ThreeD.length == 0)
                            Str_ThreeD = @"No Info";
                        
                        NSString *Str_sportsdesc = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"sportsDescription"];
                        if(Str_sportsdesc.length == 0)
                            Str_sportsdesc = @"No Info";
                        
                        NSString *Str_Sound = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Sound"];
                        if(Str_Sound.length == 0)
                            Str_Sound = @"No Info";
                        
                        NSString *Str_Screen = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Screen"];
                        if(Str_Screen.length == 0)
                            Str_Screen = @"No Info";
                        
                        NSString *Str_hd = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"HD"];
                        if(Str_hd.length == 0)
                            Str_hd = @"No Info";
                        
                        NSString *Str_eventname = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"eventName"];
                        if(Str_eventname.length == 0)
                            Str_eventname = @"No Info";
                        
                        NSString *Str_dateshow = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Date Show"];
                        if(Str_dateshow.length == 0)
                            Str_dateshow = @"No Info";
                        
                        NSString *Str_channel = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Channel"];
                        if(Str_channel.length == 0)
                            Str_channel = @"No Info";
                        
                        NSString *Str_timeshow = [[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Time Show"];
                        if(Str_timeshow.length == 0)
                            Str_timeshow = @"No Info";
                        
                        
                        
                        [[DBFunctionality sharedInstance] Update_Sport_DetailsbyPubId:PUBID SportEventID:[[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"event ID"] Type:Str_Type ThreeD:Str_ThreeD SportsDescription:Str_sportsdesc Sound:Str_Sound Screen:Str_Screen HD:Str_hd eventName:Str_eventname Date:Str_dateshow Channel:Str_channel Time:Str_timeshow SportID:[[Arr_SportsEventDetails objectAtIndex:i]  valueForKey:@"Sports ID"]];
                    }
                }
            }
        //}
        
        [self performSelector:@selector(dismissHUD:)];
        
        if([categoryStr isEqualToString:@"Real Ale"]){
            
            RealAle_Microsite *obj_RealAle_Microsite=[[RealAle_Microsite alloc]initWithNibName:[Constant GetNibName:@"RealAle_Microsite"] bundle:[NSBundle mainBundle]];
            
            obj_RealAle_Microsite.Pubid=[[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row]valueForKey:@"PubID"];
            obj_RealAle_Microsite.category_Str=categoryStr;
            
            obj_RealAle_Microsite.header_DictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                           [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                                           [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                                           [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                                           [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                                           nil];
            
            
            [self.navigationController pushViewController:obj_RealAle_Microsite animated:YES];
            [obj_RealAle_Microsite release];
            
        }
        
        else
        {
            //NSLog(@"ARRAy   %@",PubArray);
            PubDetail *obj_detail = [[PubDetail alloc]initWithNibName:[Constant GetNibName:@"PubDetail"] bundle:[NSBundle mainBundle]];
            obj_detail.headerDictionaryData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubName"],@"PubName",
                                               [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubDistrict"],@"PubDistrict",
                                               [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubCity"],@"PubCity",
                                               [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubPostCode"],@"PubPostCode",
                                               nil];
            obj_detail.Pub_ID= [[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"PubID"];
            obj_detail.sporeid=[[PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"Sport_ID"];
            obj_detail.Sport_Evnt_id =[ [PubArray objectAtIndex:[table_list indexPathForSelectedRow].row] valueForKey:@"Sport_EventID"];
            //obj_detail.categoryStr=@"NearMeNow";
            // obj_detail.EventId = eventID;
           // obj_detail.categoryStr=categoryStr;
            obj_detail.categoryStr=_pageName;
            
            obj_detail.OpenDayArray=openingHours4Day;
            obj_detail.OpenHourArray=openingHours4Hours;
            obj_detail.bulletPointArray=bulletPointArray;
            
            
            [self.navigationController pushViewController:obj_detail animated:YES];
            [obj_detail release];
        }
        
        shiftToNextPage = YES;

    }
    
    else{
        [self performSelector:@selector(dismissHUD:)];
 
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub & Bar Network" message:@"No Venue details Found! Please Try Again......" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 10;
        [alert show];
        [alert release];
    }
    
           
}

//-------------------------------------------------------//

-(void)afterFailourConnection:(id)msg
{
	
    [self performSelector:@selector(callingServer) withObject:nil afterDelay:1.0];

	
	
}
/*UIImage *rowBackGround;
 UIImage *selectBackGround;*/


#pragma mark-
#pragma mark-addMBHud
-(void) addMBHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.labelText = @"Loading...";
    
}
#pragma mark Dismiss Hud

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
    
}
//**********************************************************************//

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [table_list release];
    table_list = nil;
    //seg_control=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    orientation = interfaceOrientation;
    
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        _Toolbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
        
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        _Toolbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
    }
    return YES;
}

-(void)dealloc{
    [table_list release];
    //[PubId release];
    //[seg_control release];
    [obj_nearbymap release];
    [backButton release];
    //[venu_btn release];
    [mapArray release];
    [super dealloc];
}
@end
