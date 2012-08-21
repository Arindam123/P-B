//
//  DistenceWheel.m
//  PubAndBar
//
//  Created by Alok K Goyal on 09/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "DistenceWheel.h"
#import "Catagory.h"
#import "EventCatagory.h"
#import "RealAleDetail.h"
#import "JSON.h"
#import "DBFunctionality.h"
#import <CoreLocation/CoreLocation.h>
#import "ServerConnection.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "NearMeNow.h"
#import "RealAle.h"
#import "Global.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"


@interface DistenceWheel()

-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude;

@end


@implementation DistenceWheel

@synthesize lblSetmaxDistnc;
@synthesize pickerDistenceWheel;
@synthesize btnSend;
@synthesize btnNearesttoMe;
@synthesize distenceArray;
@synthesize lbl_or;
@synthesize vw_line;
@synthesize backButton;
@synthesize _name;
@synthesize _name1;
@synthesize ale_ID;
@synthesize hud = _hud;
@synthesize  oAuthLoginView;



int Row_number;
BOOL HavetoPushAfterSports = NO;

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
    //self.navigationItem.hidesBackButton = NO;
    
    toolBar = [[Toolbar alloc]init];
   // toolBar.layer.borderWidth = 1.0f;
    [self.view addSubview:toolBar];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround.png"]];
    
    self.view.backgroundColor=[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    
    //appDelegate.ismore=NO;
    [self CreateView];
    
        
    distenceArray = [[NSMutableArray alloc]initWithObjects:@"0.5",@"1.0",@"3.0",
                     @"4.0",@"5.0",@"10.0",@"12.0",@"13.0",@"15.0",@"17.0",@"20.0",@"Above 20.0", nil];
    
    //self.eventTextLbl.text = _name;
    self.eventTextLbl.text=[NSString stringWithFormat:@"Choose Radius"];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    //appDelegate.ismore=NO;
    self.navigationController.navigationBarHidden=YES;
//    [navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
  /*  if (GET_DEFAUL_VALUE(ShowsResultIN) !=nil) {
        [lblSetmaxDistnc setText:[NSString stringWithFormat: @"Set Maximum Distance (in %@)",GET_DEFAUL_VALUE(ShowsResultIN)]];
    }else
        [lblSetmaxDistnc setText:[NSString stringWithFormat: @"Set Maximum Distance (in Miles)"]];*/
    [self AddNotification];
    [self SetCustomNavBarFrame];
    [self setCreateViewFrame];
    
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
     @"Check out this great FREE app and search facility for finding pubs and bars” and then a bitly or tiny link to the http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8",@"message",
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

-(void)CreateView{
    
    btnSend = [[UIButton alloc]init];
    [btnSend addTarget:self action:@selector(ClickSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btnSend setImage:[UIImage imageNamed:@"SendDeselect.png"] forState:UIControlStateNormal];
    [btnSend setImage:[UIImage imageNamed:@"SendSelect.png"] forState:UIControlStateHighlighted];
    
    
    
    lbl_or = [[UILabel alloc]init];
    lbl_or.text = @"OR";
    lbl_or.textColor = [UIColor whiteColor];
    lbl_or.font = [UIFont systemFontOfSize:9];
    lbl_or.backgroundColor = [UIColor clearColor];
    
    btnNearesttoMe = [[UIButton alloc]init];
    [btnNearesttoMe setTitle:@"NEAREST TO ME NOW" forState:UIControlStateNormal];
    [btnNearesttoMe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnNearesttoMe addTarget:self action:@selector(ClickNearesrtoMeBtn:) forControlEvents:UIControlEventTouchUpInside];
    btnNearesttoMe.titleLabel.textAlignment=UITextAlignmentCenter;
    btnNearesttoMe.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [btnNearesttoMe setBackgroundColor:[UIColor clearColor]];
    
    vw_line = [[UIView alloc] init];
    vw_line.backgroundColor = [UIColor whiteColor];
    
    btnNearesttoMeImg = [[UIImageView alloc]init];
    //[btnNearesttoMeImg setImage:[UIImage imageNamed:[Constant GetImageName:@"right"]]];
    //[btnNearesttoMe addSubview:btnNearesttoMeImg];
    
    //------------------------------mb-28-05-12----------------------//
    lblSetmaxDistnc = [[UILabel alloc]init];
   
    
    lblSetmaxDistnc.textColor=[UIColor whiteColor];
    [lblSetmaxDistnc setFont:[UIFont boldSystemFontOfSize:10]];
    lblSetmaxDistnc.backgroundColor = [UIColor clearColor];
    //--------------------------------------------//
    
    pickerDistenceWheel = [[UIPickerView alloc]init];
    pickerDistenceWheel.delegate = self;
    pickerDistenceWheel.dataSource = self;
    pickerDistenceWheel.showsSelectionIndicator=YES;
    
    backButton = [[UIButton alloc]init];
    [backButton addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"BackDeselect.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateHighlighted];

    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:10];
   
    [self.view addSubview:backButton];
    
    [self setCreateViewFrame];
    
    [self.view addSubview:lbl_or];
    [self.view addSubview:btnNearesttoMe];
    [self.view addSubview:vw_line];
    [self.view addSubview:btnSend];
    [self.view addSubview:lblSetmaxDistnc];
    [self.view addSubview:pickerDistenceWheel];
    
    [vw_line release];
    [lbl_or release];

}


-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude
{
    NSString *latitude = @"51.5001524";
    NSString *longitude = @"-0.1262362";
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[latitude doubleValue]  longitude:[longitude doubleValue]];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
    
    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    [location1 release];
    [location2 release];
    
    return distance;
}




#pragma mark ServerConnection Delegates


-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
//    NSLog(@"RESPONSE  %@",data_Response);
//    
//    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//
//    
//    //NSLog(@"pickervalue 11 %@",pickerValue);
//    if ([_name isEqualToString:@"Events"]) {
//        NSDictionary *json = [data_Response JSONValue];
//        NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
//        NSLog(@"%d",[Arr_events count]);
//        for (int i = 0; i < [Arr_events count]; i++) {
//            NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
//            NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
//            NSLog(@"%@",Str_Event);
//            NSString *EventTypeID;
//            
//            if ([Str_Event isEqualToString:@"RegularEvent"])
//                EventTypeID = @"1";
//            else if([Str_Event isEqualToString:@"OneOffEvent"])
//                EventTypeID = @"2";
//            else if([Str_Event isEqualToString:@"ThemeNight"])
//                EventTypeID = @"3";
//            
//            NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
//            NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
//            for (int j = 0; j < [Arr_EventDetails count]; j++) {
//                int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
//                NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
//                NSLog(@"%d",EventId);
//                NSLog(@"%@",Str_EventName);
//                
//                NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
//                NSLog(@"%d",[Arr_PubInfo count]);
//                
//                for (int k = 0; k < [Arr_PubInfo count]; k++) {
//                    NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
//                    NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
//                    int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
//                    CLLocationDistance _distance = 0.0;
//                    
//                    
//                    if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil) 
//                        _distance = [Constant GetDistanceFromPub:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"]];
//                    NSLog(@"%f",_distance);
//                    //_distance = 2;
//                    //[[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance];
//                    NSLog(@"%@",[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]);
//                    [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance creationdate:[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]];
//                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:_distance latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Date"]];
//                }
//            }
//        }
//        
//        
//        if ([delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
//            EventCatagory *Obj_eventcatagory = [[EventCatagory alloc]initWithNibName:[Constant GetNibName:@"EventCatagory"] bundle:nil withString:nil];
//            [self.navigationController pushViewController:Obj_eventcatagory animated:YES];
//            [Obj_eventcatagory release];
//            
//        }
//        else if (![delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
//            HavetoPushAfterSports = YES;
//            [self PopulateSportsData];
//        }
//        [Arr_events release];
//        [self performSelector:@selector(dismissHUD:)];
//    }
//    
//    if([_name isEqualToString:@"Food & Offers"])
//    {
//        //SBJsonParser *parser = [[SBJsonParser alloc] init];
//        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
//        NSMutableArray *foodAndOfferArray = [[[json valueForKey:@"Details"] valueForKey:@"Food & Offers Details"] retain];
//        //[parser release];
//        
//        //-----------------------------mb-----------------------------//
//        if ([foodAndOfferArray count]!=0) {
//            //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
//            for (int i = 0; i<[foodAndOfferArray count]; i++) {
//                
//                [[DBFunctionality sharedInstance] InsertValue_Food_Type:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] withName:[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food and Offers Type"]];
//                
//                NSMutableArray *pubInfoArray = [[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Pub Information"] retain];
//                
//                for (int j = 0; j<[pubInfoArray count]; j++) {
//                    
//                    //NSLog(@"%@",currentPoint);
//                    //NSLog(@"Lat  %f   Long  %f",currentPoint.coordinate.latitude,currentPoint.coordinate.longitude);
//                    //appDelegate.currentPoint.coordinate.latitude
//                    //appDelegate.currentPoint.coordinate.longitude
//                    
//                    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] doubleValue]];
//                    
//                    
//                    [[DBFunctionality sharedInstance] InsertValue_Food_Detail:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withFoodID:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] pubDistance:distance/1000];
//                    
//                    
//                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:j] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
//                }
//                NSLog(@"pubInfoArray   %@",pubInfoArray);
//                [pubInfoArray release];
//            }
//            [foodAndOfferArray release];
//            
//            [self performSelector:@selector(dismissHUD:)];
//            
//            NSLog(@"pickervalue 22 %@",pickerValue);
//            Catagory *obj = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
//            obj.searchRadius = pickerValue;
//            obj.Name = _name;
//            [self.navigationController pushViewController:obj animated:YES];
//            [obj release];
//        }
//        else
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Food and Offers" message:@"NO Data Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//        }
//        
//        /**/ 
//    }
//    
//    
//    if([_name isEqualToString:@"Real Ale"])
//    {
//        //SBJsonParser *parser = [[SBJsonParser alloc] init];
//        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
//        NSMutableArray *realAleArray = [[[json valueForKey:@"Details"] valueForKey:@"Brewery Details"] retain];
//        //[parser release];
//        
//        if ([realAleArray count] !=0) {
//            for (int i = 0; i<[realAleArray count]; i++) {
//                
//                //[[DBFunctionality sharedInstance] InsertValue_RealAle_Type:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withName:[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Name"]];
//                
//                NSMutableArray *beerDetailsArray = [[[realAleArray objectAtIndex:i] valueForKey:@"Beer Details"] retain];
//                
//                for (int j = 0; j<[beerDetailsArray count]; j++) {
//                    
//                    
//                    NSMutableArray *pubDetailsArray = [[[beerDetailsArray objectAtIndex:j] valueForKey:@"Pub Information"] retain];
//                    
//                    
//                    for (int k = 0; k< [pubDetailsArray count]; k++) {
//                        
//                        
//                        
//                        //NSLog(@"%@",currentPoint);
//                        //NSLog(@"Lat  %f   Long  %f",currentPoint.coordinate.latitude,currentPoint.coordinate.longitude);
//                        //appDelegate.currentPoint.coordinate.latitude
//                        //appDelegate.currentPoint.coordinate.longitude
//                        
//                        double distance = [self calculateDistance:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
//                        
//                        [[DBFunctionality sharedInstance] InsertValue_RealAle_Type:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withName:[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Name"] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] pubDistance:distance/1000];
//                        
//                        [[DBFunctionality sharedInstance] InsertValue_Beer_Detail:[[[beerDetailsArray objectAtIndex:j] valueForKey:@"Beer ID"] intValue] withBreweryID:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withBeerName:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Ale Name"] withBeerCategory:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Category"] pubDistance:distance/1000];
//                        
//                        
//                        
//                        [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
//                    }
//                    
//                    [pubDetailsArray release];
//                    
//                    
//                    
//                }
//                
//                [beerDetailsArray release];
//                
//                //NSLog(@"%@",currentPoint);
//                //NSLog(@"Lat  %f   Long  %f",currentPoint.coordinate.latitude,currentPoint.coordinate.longitude);
//                //appDelegate.currentPoint.coordinate.latitude
//                //appDelegate.currentPoint.coordinate.longitude
//                
//                
//                
//                
//            }
//            
//            [realAleArray release];
//            
//            [self performSelector:@selector(dismissHUD:)];
//            
//            
//            
//            
//            RealAle *obj_ele= [[RealAle alloc]initWithNibName:[Constant GetNibName:@"RealAle"] bundle:[NSBundle mainBundle] withString:_name];
//            obj_ele.realale=_name;
//            obj_ele.searchRadius = pickerValue;
//            [self.navigationController pushViewController:obj_ele animated:YES];
//            [obj_ele release];
//        }
//        else
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"RealAle" message:@"NO Data Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//        }
//
//    }
//    
//    //----------------------mb-25/05/12/5-45p.m.------------------------//
//    else if([_name isEqualToString:@"Facilities"])
//    {
//        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
//        NSMutableArray *AmenitiesArray = [[[json valueForKey:@"Details"] valueForKey:@"Amenities Details"] retain];
//        for (int i = 0; i<[AmenitiesArray count]; i++) {
//            
//            [[DBFunctionality sharedInstance] InsertValue_Amenities_Type:i+1 withName:[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]];
//            
//            NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Facility Details"] retain];
//            NSLog(@"facilityDetailsArray  %d",[facilityDetailsArray count]);
//            
//            for (int j = 0; j<[facilityDetailsArray count]; j++) {
//                
//                NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
//                NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
//                
//                for (int k=0; k<[pubInfoArray count]; k++) {
//                    
//
//                    
//                    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
//                    
//                    
//                    
//                    [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:distance/1000 ];
//                    
//                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
//                }
//                
//                [pubInfoArray release];
//            }
//            [facilityDetailsArray release];
//        }
//        [AmenitiesArray release];
//        
//        [self performSelector:@selector(dismissHUD:)];
//        
//        
//        Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
//        obj_catagory.Name = _name;
//        obj_catagory.searchRadius = pickerValue;
//        NSLog(@"picker>>>>>>>>> %@",pickerValue);
//        [self.navigationController pushViewController:obj_catagory animated:YES];
//        [obj_catagory release];
//    }
//    //-----------------------------5-45------------------------//
//   
//        //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
//    
//    else if([_name isEqualToString:@"Sports on TV"])
//    {
//        NSDictionary *json = [data_Response JSONValue];//[parser objectWithString:data_Response];
//        NSMutableArray *sportsArray = [[[json valueForKey:@"Details"] valueForKey:@"Sports Details"] retain];
//        
//        for (int i = 0; i<[sportsArray count]; i++) {
//            
//            [[DBFunctionality sharedInstance] InsertValue_Sports_Type:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] withName:[[sportsArray objectAtIndex:i] valueForKey:@"Category Name"]];
//            
//            NSMutableArray *sportDetailsArray = [[[sportsArray objectAtIndex:i] valueForKey:@"event"] retain];
//            NSLog(@"facilityDetailsArray  %d",[sportDetailsArray count]);
//            
//            for (int j = 0; j<[sportDetailsArray count]; j++) {
//                
//                NSMutableArray *pubInfoArray=[[[sportDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
//                NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
//                
//                if ([pubInfoArray count] == 35) {
//                    
//                    NSLog(@"Problem");
//                }
//                
//                for (int k=0; k<[pubInfoArray count]; k++) {
//                    
//                    
//                    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
//                    
//                    
//                    [[DBFunctionality sharedInstance] InsertValue_Sports_Detail:[[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventID"] intValue] sport_TypeID:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] event_Name:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventName"] event_Description:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventDescription"] event_Date:[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"] event_Channel:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Channel"] reservation:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Reservation"] sound:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Sound"] hd:[[sportDetailsArray objectAtIndex:j] valueForKey:@"HD"] threeD:[[sportDetailsArray objectAtIndex:j] valueForKey:@"threeD"] screen:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Screen"] PubID:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withPubDistance:distance/1000 event_Time:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Time"] event_Type:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Type"]];
//                    
//                    [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:distance/1000 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date]];
//                }
//                
//                [pubInfoArray release];
//            }
//            [sportDetailsArray release];
//        }
//        [sportsArray release];
//        
//        [self performSelector:@selector(dismissHUD:)];
//        
//        
//        if (HavetoPushAfterSports) {
//            HavetoPushAfterSports = NO;
//            EventCatagory *Obj_eventcatagory = [[EventCatagory alloc]initWithNibName:[Constant GetNibName:@"EventCatagory"] bundle:nil withString:nil];
//            [self.navigationController pushViewController:Obj_eventcatagory animated:YES];
//            [Obj_eventcatagory release];
//        }
//        else{
//            Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
//            obj_catagory.Name = _name;
//            obj_catagory.searchRadius = pickerValue;
//            NSLog(@"picker>>>>>>>>> %@",pickerValue);
//            [self.navigationController pushViewController:obj_catagory animated:YES];
//            [obj_catagory release];
//        }
//    }
//    
    
}

//-------------------------------------------------------//

-(void)afterFailourConnection:(id)msg
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Error Occurred!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
     [alert show];
     [alert release];
	
	
}




#pragma mark - Button Actions


-(IBAction)ClickBack:(id)sender{
   // appDelegate.ismore=NO;
    
    [backButton setImage:[UIImage imageNamed:@"BackSelect.png"] forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)ClickSendBtn:(id)sender
{
    btnSend.titleLabel.textColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    AppDelegate *delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"KEY VALUE  %@",[delegate.sharedDefaults objectForKey:@"Food"]);
    
    pickerValue = [NSString stringWithFormat:@"%@",[distenceArray objectAtIndex:[pickerDistenceWheel selectedRowInComponent:0]]];
    
    /*if ([pickerValue isEqualToString:@"0.5"]) {
        
        pickerValue = @"<= 0.5";
    }*/
    if ([pickerValue isEqualToString:@"Above 20.0"]) {
        
        pickerValue = @"> 20.0";
        
    }
    else if([pickerValue isEqualToString:@"0.5"] || [pickerValue isEqualToString:@"1.0"] || [pickerValue isEqualToString:@"3.0"] || [pickerValue isEqualToString:@"4.0"] || [pickerValue isEqualToString:@"12.0"] || [pickerValue isEqualToString:@"13.0"] || [pickerValue isEqualToString:@"5.0"] || [pickerValue isEqualToString:@"10.0"] || [pickerValue isEqualToString:@"15.0"] || [pickerValue isEqualToString:@"17.0"] || [pickerValue isEqualToString:@"20.0"])
    {
        NSString *tempStr =[NSString stringWithFormat:@"<=%@",pickerValue];
        pickerValue = [tempStr retain];
    }
    
    appDelegate.SelectedRadius = pickerValue;
    
    NSLog(@"picker value  %@",pickerValue);
    
    
    
    
    if([_name isEqualToString:@"Events"]){
        /* EventCatagory *obj_event = [[EventCatagory alloc]initWithNibName:[Constant GetNibName:@"EventCatagory"] bundle:[NSBundle mainBundle] withString:_name];
         [self.navigationController pushViewController:obj_event animated:YES];
         [ obj_event release];*/
        
        
        /*if (![delegate.sharedDefaults objectForKey:@"Events"]) {
            
            [self performSelector:@selector(addMBHud)];
            [delegate.sharedDefaults setObject:@"1" forKey:@"Events"];
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 geteventsData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{*/
            
             //if ([pickerValue isEqualToString:@"> 20.0"]) {
            EventCatagory *obj_event = [[EventCatagory alloc]initWithNibName:[Constant GetNibName:@"EventCatagory"] bundle:[NSBundle mainBundle] withString:_name];
            obj_event.strPagename=_name;
            [self.navigationController pushViewController:obj_event animated:YES];
            [ obj_event release];
            // }
            /*else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }*/
            /*Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
             obj_catagory.Name = _name;
             obj_catagory.searchRadius = pickervalue;
             //obj_catagory.searchUnit = 
             [self.navigationController pushViewController:obj_catagory animated:YES];
             [obj_catagory release];*/
        //}
        //****************************************Biswa****************************************
        
    }
    
    else if([_name isEqualToString:@"Real Ale"]){
        
//        if (![delegate.sharedDefaults objectForKey:@"Real Ale"]) {
//            
//            [self performSelector:@selector(addMBHud)];
//            [delegate.sharedDefaults setObject:@"1" forKey:@"Real Ale"];
//            ServerConnection *conn1 = [[ServerConnection alloc] init];
//            [conn1 getRealAleData:nil];
//            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
//            [conn1 release];
//        }
//        else{
            
           /* RealAle *obj_ele= [[RealAle alloc]initWithNibName:[Constant GetNibName:@"RealAle"] bundle:[NSBundle mainBundle] withString:_name];
            obj_ele.realale=_name;
            obj_ele.searchRadius = pickerValue;
            [self.navigationController pushViewController:obj_ele animated:YES];
            [obj_ele release];*/
            //if ([pickerValue isEqualToString:@"> 20.0"]) {
            
            
            RealAleDetail *obj = [[RealAleDetail alloc]initWithNibName:[Constant GetNibName:@"RealAleDetail"] bundle:[NSBundle mainBundle]];
            obj._Name=_name;
            obj.Realale_ID =ale_ID;
            obj.str_breweryName=_name1;
            obj.searchRadius = pickerValue;
            [self.navigationController pushViewController:obj animated:YES];
            [obj release];
            //}
            /*else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }*/


        //}
        
    }
    
    
    else if([_name isEqualToString:@"Sports on TV"]){
        
        /*Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
        obj_catagory.Name = _name;
        obj_catagory.searchRadius = pickerValue;
        [self.navigationController pushViewController:obj_catagory animated:YES];
        [obj_catagory release];*/
        
//        if (![delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
//            
//            [self PopulateSportsData];
//
//        }
//        else{
            // if ([pickerValue isEqualToString:@"> 20.0"]) {
            
            Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
            obj_catagory.Name = _name;
            obj_catagory.searchRadius = pickerValue;
            [self.navigationController pushViewController:obj_catagory animated:YES];
            [obj_catagory release];
           //  }
            /*else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }*/
       // }
    }
    
    
    else if([_name isEqualToString:@"Facilities"]){
         //---------------------------mb 5-45 -----------------------------//
        
//        if (![delegate.sharedDefaults objectForKey:@"Facilities"]) {
//           
//            [self performSelector:@selector(addMBHud)];
//            [delegate.sharedDefaults setObject:@"1" forKey:@"Facilities"];
//            ServerConnection *conn1 = [[ServerConnection alloc] init];
//            [conn1 getEventsData:nil];
//            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
//            [conn1 release];
//        }
//        else{
             //if ([pickerValue isEqualToString:@"> 20.0"]) {
                 
            Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
            obj_catagory.Name = _name;
            obj_catagory.searchRadius = pickerValue;
            [self.navigationController pushViewController:obj_catagory animated:YES];
            [obj_catagory release];
             //}
            /* else{
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                 [alert show];
                 [alert release];

             }*/
        //}
        //--------------------------------------------------//
        
//        Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
//        obj_catagory.Name = _name;
//        [self.navigationController pushViewController:obj_catagory animated:YES];
//        [obj_catagory release];
    }
    
    
    else if([_name isEqualToString:@"Food & Offers"]){ 

//        if (![delegate.sharedDefaults objectForKey:@"Food"]) {
//            
//            [self performSelector:@selector(addMBHud)];
//            [delegate.sharedDefaults setObject:@"1" forKey:@"Food"];
//            ServerConnection *conn1 = [[ServerConnection alloc] init];
//            [conn1 getFoodandOffersData:nil];
//            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
//            [conn1 release];
//        }
//        else{
            // if ([pickerValue isEqualToString:@"> 20.0"]) {
                 
            Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
            obj_catagory.Name = _name;
            obj_catagory.searchRadius = pickerValue;
            //obj_catagory.searchUnit = 
            [self.navigationController pushViewController:obj_catagory animated:YES];
            [obj_catagory release];
            // }
           /* else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
 
            }*/
        //}
       
    }
    //-----------------------mb-28-05-12----------------------------//
    
    else
        if([_name isEqualToString:@"Near me now!"]){
            
           // if ([pickerValue isEqualToString:@"> 20.0"]) {
        
        NearMeNow *objNearMENOW=[[NearMeNow alloc]initWithNibName:[Constant GetNibName:@"NearMeNow"] bundle:[NSBundle mainBundle]];
        objNearMENOW._pageName=_name;
            objNearMENOW.str_distance=pickerValue;
            
        [self.navigationController pushViewController:objNearMENOW animated:YES];
        [objNearMENOW release];
           // }
           // else
//            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [alert show];
//                [alert release];
//            }
        
        
    }
    
    
}

-(void)PopulateSportsData{
    @try {
        AppDelegate *delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self performSelector:@selector(addMBHud)];
        [delegate.sharedDefaults setObject:@"1" forKey:@"Sports on TV"];
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 getSportsData:nil];
        [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}


-(IBAction)ClickNearesrtoMeBtn:(id)sender{
    NSLog(@"ClickNearesrtoMeBtn");
    
//    AppDelegate *delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    NSLog(@"KEY VALUE  %@",[delegate.sharedDefaults objectForKey:@"Food"]);
//    
//    pickerValue = [NSString stringWithFormat:@"%@",[distenceArray objectAtIndex:[pickerDistenceWheel selectedRowInComponent:0]]];
    
    /*if ([pickerValue isEqualToString:@"0.5"]) {
     
     pickerValue = @"<= 0.5";
     }*/
//    if ([pickerValue isEqualToString:@"Above 20.0"]) {
//        
//        pickerValue = @"> 20.0";
//        
//    }
//    else if([pickerValue isEqualToString:@"0.5"] || [pickerValue isEqualToString:@"1.0"] || [pickerValue isEqualToString:@"3.0"] || [pickerValue isEqualToString:@"4.0"] || [pickerValue isEqualToString:@"12.0"] || [pickerValue isEqualToString:@"13.0"] || [pickerValue isEqualToString:@"5.0"] || [pickerValue isEqualToString:@"10.0"] || [pickerValue isEqualToString:@"15.0"] || [pickerValue isEqualToString:@"17.0"] || [pickerValue isEqualToString:@"20.0"])
//    {
//        NSString *tempStr =[NSString stringWithFormat:@"<=%@",pickerValue];
//        pickerValue = [tempStr retain];
//    }
//    
//    appDelegate.SelectedRadius = pickerValue;
//    
//    NSLog(@"picker value  %@",pickerValue);
    
    pickerValue = @"> 20.0";
    
    //if ([pickerValue isEqualToString:@"> 20.0"]) {

    
    NearMeNow *objNearMENOW=[[NearMeNow alloc]initWithNibName:[Constant GetNibName:@"NearMeNow"] bundle:[NSBundle mainBundle]];
    objNearMENOW._pageName=_name;
    objNearMENOW.str_distance=pickerValue;
    
    [self.navigationController pushViewController:objNearMENOW animated:YES];
    [objNearMENOW release];
//}
/*else
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Select Distance" message:@"Above 20.0" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}*/

    
}
//---------------------------------------------------------------//

-(void)setCreateViewFrame{
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            self.view.frame=CGRectMake(0, 0, 320, 480);
            pickerDistenceWheel.frame = CGRectMake(85, 124, 150, 215);
            lblSetmaxDistnc.frame = CGRectMake(39, 47, 200, 20);
            lbl_or.frame = CGRectMake(155, 358, 50, 20);
            btnNearesttoMe.frame = CGRectMake(96, 384, 140, 20);
            vw_line.frame = CGRectMake(100, 400, 132, 1);
            btnSend.frame = CGRectMake(140,330, 45, 23);
            btnNearesttoMeImg.frame = CGRectMake(95, 5, 9, 10);
            backButton.frame =CGRectMake(8, 90, 50, 25);
            //toolBar.frame = CGRectMake(0, 387, 320, 48);
            NSLog(@"VALUE OF MORE  %d",appDelegate.ismore);
            if (appDelegate.ismore==YES) {
                //toolBar.frame = CGRectMake(-320, 373, 640, 58);
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                
            }
            else{
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
                //toolBar.frame = CGRectMake(0, 373, 640, 58);
            }
            

        }
        else{
            pickerDistenceWheel.frame = CGRectMake(80, 95, 150, 90);
            lblSetmaxDistnc.frame = CGRectMake(57, 36, 350, 20);
            btnNearesttoMe.frame = CGRectMake(278, 189, 150, 20);
            lbl_or.frame = CGRectMake(341, 165, 50, 20);
            vw_line.frame = CGRectMake(287, 205, 131, 1);
            btnSend.frame = CGRectMake(326, 135, 45, 20);
            btnNearesttoMeImg.frame = CGRectMake(121, 5, 9, 10);
            backButton.frame = CGRectMake(20, 85, 50, 25);
            if (appDelegate.ismore==YES) {
               toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
               toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            


        }
    }
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
//            
//            
    
    //    }
    
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    [self SetCustomNavBarFrame];
    [self setCreateViewFrame];
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component 
{
    return [distenceArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component 
{
    return [distenceArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row != 0)
		Row_number = row;

}
//////////////////JHUMA///////////////////////////////////

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.font = [UIFont boldSystemFontOfSize:21];
    label.text = [NSString stringWithFormat:@"%@",[distenceArray objectAtIndex:row]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [label autorelease];
    return label;
}


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

#pragma mark - Memory Clean Up


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   
    [lblSetmaxDistnc release];
    [pickerDistenceWheel release];
    [btnNearesttoMe release];
    [btnSend release];
    [distenceArray release];
    [toolBar release];
    [_hud release];
    _hud = nil;
    distenceArray= nil;
    self.lblSetmaxDistnc = nil;
    self.pickerDistenceWheel = nil;
    self.btnNearesttoMe = nil;
    self.btnSend = nil;
    //self.distenceArray = nil;
    
}


-(void)dealloc{
    [lblSetmaxDistnc release];
    [pickerDistenceWheel release];
    [btnNearesttoMe release];
    [btnSend release];
    [distenceArray release];
    [toolBar release];
    [_hud release];
  
    [super dealloc];


}

@end
