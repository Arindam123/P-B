//
//  Home.m
//  PubAndBar
//
//  Created by Alok K Goyal on 06/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "Home.h"
#import "RealAle.h"
#import "TextSearch.h"
#import "FunctionRoom.h"
#import <QuartzCore/QuartzCore.h>
#import "ServerConnection.h"
#import "DBFunctionality.h"
#import "JSON.h"
#import "InternetValidation.h"
#import "DBFunctionality4Update.h"
#import "DBFunctionality4Delete.h"
#import "GooglePlusViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "MyProfileSetting.h"
#import "MyProfileSetting.h"
#import "FBViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "GooglePlusViewController.h"
#import "TwitterViewController.h"
#import "LinkedINViewController.h"
#import "URLRequestString.h"
#import "NearMeNow.h"
#import "UtilityClass.h"
#import "Catagory.h"
#import "EventCatagory.h"


@interface Home()

-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude;
-(void)ExcuteURLWithNameRefWithDate:(int)_RefNumber;
-(void) deletedDataCalling:(int)_callerNumber;
-(void) callingNonSubPubs:(int) _value;
-(void) callingUpdatedNonSubPubs:(int) _value;
//-(void)executeMethods:(void (^)(void))process completion:(void (^)(BOOL finished))completion;
-(void) getNonSubPubs:(int) _value withDate:(NSString *) _date;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)dataSourceDidFinishLoadingNewData;
@end


@implementation Home

@synthesize hometable;
@synthesize selectionArray;
@synthesize btnSignUp;
@synthesize line_vw;
@synthesize name;
@synthesize value;
@synthesize l;
@synthesize  oAuthLoginView;
@synthesize str_RefName;
@synthesize RefNo;
@synthesize hud = _hud;
@synthesize Arr_CheckValue;

@synthesize reloading=_reloading;

AppDelegate *delegate ;
int nonSubValue;




UIImageView *pushImg;
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
-(void) updateDB4Distance
{
    [[DBFunctionality4Update sharedInstance] UpdatePubDistance];            
    [[DBFunctionality4Update sharedInstance] UpdatePubDistance4NonSubPubs];
    [self performSelector: @selector(dismissHUD:)];
    DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
    Obj._name=@"Near me now!";
    [self.navigationController pushViewController:Obj animated:YES];
    [Obj release];
}
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
    
    delegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [delegate.sharedDefaults setObject:@"1" forKey:@"ApplicationRunning"];
    [delegate.sharedDefaults setObject:@"Completed" forKey:@"All"];

    
    

    RefNo=0;
    Arr_URL_Name=[[NSMutableArray alloc]initWithObjects:@"Events",@"ThemeNight",@"Real Ale",@"Sports on TV",@"Facilities",@"Food & Offers",nil];
    
    Arr_CheckValue=[[NSMutableArray alloc]initWithObjects:@"Events",@"ThemeNight",@"Real Ale",@"Sports on TV",@"Facilities",@"Food",nil];
    l=0;
     self.view.frame = CGRectMake(0, 0, 320, 395);
    //self.navigationController.navigationBarHidden=NO;
//    selectionArray = [[NSMutableArray alloc] initWithObjects:@".................Near Me Now!",@"Sports on TV",@"Events",@"Real Ale",@"Food & Offers",@"Facilities",@"Text Search",@"Function Rooms\nFind me one now!", nil];
    selectionArray = [[NSMutableArray alloc] initWithObjects:@"Near me now!",@"Sports on TV",@"Events",@"Real Ale",@"Food & Offers",@"Facilities",@"Text Search",@"Function Rooms", nil];
    //selectionArray = [[SaveHomeInfo GetMain_CatagoryInfo]retain];
    
   toolBar = [[Toolbar alloc]init];
    //toolBar.layer.borderWidth = 1.0f;
    //toolBar.layer.backgroundColor = [UIColor blackColor].CGColor;
    [self.view addSubview:toolBar];
    
    self.eventTextLbl.text = name;
    [self CreateHomeView];
    
    //[self reloadTableViewDataSource];

    //nonSubValue=1;
    //[self performSelector:@selector(callingNonSubPubs:) withObject:nil afterDelay:3.0];
    //[UtilityClass runAfterDelay:3.0 block:^{
        //[self getNonSubPubs:nonSubValue withDate:nil];

    //}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShiftTosearch:)name:@"Sign In Done"  object:nil]; 

}

-(void)CreateHomeView{
    hometable = [[UITableView alloc]init];
    hometable.delegate = self;
    hometable.dataSource = self;
    hometable.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
    hometable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:hometable];

    [self setHomeViewFrame];
    
    if (refreshHeaderView == nil) {
		refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - hometable.bounds.size.height, 320.0f, hometable.bounds.size.height)];
		refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		[hometable addSubview:refreshHeaderView];
		[refreshHeaderView release];
	}
   

}

-(void)setHomeViewFrame{
    if ([Constant isiPad]) {
        ;
    }
    else{
        if ([Constant isPotrait:self]) {
            hometable.frame = CGRectMake(5, 88, 310, 320);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(65, 363, 280, 30);
            line_vw.frame = CGRectMake(121, 383, 168, 1);
           
             toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];
            if (delegate.ismore==YES) {
                
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            
            else{
                
                toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
            

            
        }
        else{
            hometable.frame = CGRectMake(0, 78, 480, 170);
            hometable.scrollEnabled = YES;
            btnSignUp.frame = CGRectMake(130, 195, 420, 30);
            line_vw.frame = CGRectMake(256, 218, 168, 1);
            
            toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
            if (delegate.ismore==YES) {
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }
            else{
                toolBar.frame = CGRectMake(8.5, 261, 463, 53);
            }

            
            
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    deletedDataCall = NO;
    self.navigationController.navigationBarHidden=YES;
    //[navBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    [self AddNotification];
    
    NSOperationQueue* queue = [NSOperationQueue new];
    NSInvocationOperation* operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(myThreadMainMethod:) object:nil];
    //[operation addDependency:self];
    [queue addOperation:operation];
    [operation release];
    
    /*UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Do you want to download updated information?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alert.tag = 60;
    [alert  show];
    [alert  release];*/
    
    //[self performSelector:@selector(addMBHud)];
    //[self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:0.5];
    
    
    
    
}




- (void)ShiftTosearch:(NSNotification *)notification {
    sleep(1);
    Home *obj_Home=[[Home alloc]initWithNibName:[Constant GetNibName:@"Home"] bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj_Home animated:YES];
    [obj_Home release];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"callingServer" object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self performSelector:@selector(dismissHUD:)];

}


#pragma mark
#pragma mark Server Calling

-(void) callingServer
{    // && [InternetValidation hasConnectivity]
    if([InternetValidation  checkNetworkStatus])
    {
        [self ExcuteURLWithNameRef:0];
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


-(void) addingHud_callingServer
{
    sleep(3);
    if (![delegate.sharedDefaults objectForKey:@"All"])
    {
        [self ExcuteURLWithNameRef:self.RefNo]; 
    }
    else{
        [self ExcuteURLWithNameRefWithDate:self.RefNo]; 
        
    }
}

-(void) callingNonSubPubs:(int) _value
{
    if ([InternetValidation checkNetworkStatus]) {
        
        self.str_RefName = @"NonSubPubs";
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        [conn1 getNonSubPubs:nonSubValue withDate:nil];
        //[conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    else
    {
        [self performSelector:@selector(dismissHUD:)];
    }
    
}


-(void) callingUpdatedNonSubPubs:(int) _value
{
    if ([InternetValidation checkNetworkStatus]) {
        
        self.str_RefName = @"NonSubPubsUpdated";
        ServerConnection *conn1 = [[ServerConnection alloc] init];
        [conn1 setServerDelegate:self];
        [conn1 getNonSubPubs:nonSubValue withDate:[[DBFunctionality sharedInstance] GetlastupdateddatefromPubDetails]];
        //[conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
        [conn1 release];
    }
    else
    {
        [self performSelector:@selector(dismissHUD:)];
    }
    
}
#pragma mark
#pragma Non-SubPubs

-(void) getNonSubPubs:(int) _value withDate:(NSString *) _date
{
    if ([InternetValidation checkNetworkStatus]) {

        NSString *strUrl;
        
        if (_date == nil) {
            
            strUrl = [NSString stringWithFormat:@"%@?range=%d",NonSubscribing_Pub,_value];
            
        }
        else{
            strUrl = [NSString stringWithFormat:@"%@?range=%d&date=%@",NonSubscribing_Pub,_value,_date];
        }
        
        NSLog(@"URL %@",strUrl);
        NSURL *url = [NSURL URLWithString:strUrl];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDidFinishSelector:@selector(requestFinished:)];
        [request setDidFailSelector:@selector(requestFailed:)];
        [request performThrottling];
        [request setTimeOutSeconds:240.0];
        [request setCachePolicy:ASIUseDefaultCachePolicy];
        [request setDelegate:self];
        [request startSynchronous];
    }
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    //NSLog(@"NonSubPubsUpdated  %@",responseString);
    
    
    NSDictionary *json = [responseString JSONValue];
    
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
    
    NSMutableArray *Arr_events = [[[json valueForKey:@"nonSubscribers"] valueForKey:@"NonSub PubDetails"] retain];
    NSLog(@"%d",[Arr_events count]);
    
    
    
    if ([Arr_events count] != 0) {
        
        for (int i = 0; i < [Arr_events count]; i++) {
            
            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
            int pubid = [[[Arr_events objectAtIndex:i] valueForKey:@"pubID"] intValue];
            CLLocationDistance _distance = 0.0;
            
            
            if ([[Arr_events objectAtIndex:i] valueForKey:@"Lat"] != nil || [[Arr_events objectAtIndex:i] valueForKey:@"Lon"] != nil) 
                
                //_distance = [self calculateDistance:[[[Arr_events objectAtIndex:i] valueForKey:@"Lat"] doubleValue] andLongitude:[[[Arr_events objectAtIndex:i] valueForKey:@"Lon"] doubleValue]];
            
            
            [[DBFunctionality sharedInstance] InsertValue_NonSubPub_Info:pubid withName:[[Arr_events objectAtIndex:i] valueForKey:@"Venue Name"] distance:_distance latitude:[[Arr_events objectAtIndex:i] valueForKey:@"Lat"] longitude:[[Arr_events objectAtIndex:i] valueForKey:@"Lon"] postCode:[[Arr_events objectAtIndex:i] valueForKey:@"Post Code"] district:[[Arr_events objectAtIndex:i] valueForKey:@"Pub Dist"] city:[[Arr_events objectAtIndex:i] valueForKey:@"Pub City"] lastUpdatedDate:(NSString *)[NSDate date] phoneNo:[[Arr_events objectAtIndex:i] valueForKey:@"Pub Phone"]];//_distance/1000
        }
        [Arr_events release];
        
        nonSubValue++;
        NSLog(@"nonSubValue  %d",nonSubValue);
        if (nonSubValue <= 7) {
            
            [self getNonSubPubs:nonSubValue withDate:[[DBFunctionality sharedInstance] GetlastupdateddatefromPubDetails]];
        }
    }
    
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error  %@",[error localizedDescription]);
    

}


/*else if ([self.str_RefName isEqualToString:@"NonSubPubsUpdated"]) 
 {
 NSDictionary *json = [data_Response JSONValue];
 
 //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
 //        [alert show];
 //        [alert release];
 
 NSMutableArray *Arr_events = [[[json valueForKey:@"nonSubscribers"] valueForKey:@"NonSub PubDetails"] retain];
 NSLog(@"%d",[Arr_events count]);
 
 
 
 if ([Arr_events count] != 0) {
 
 for (int i = 0; i < [Arr_events count]; i++) {
 
 // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
 // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
 int pubid = [[[Arr_events objectAtIndex:i] valueForKey:@"pubID"] intValue];
 CLLocationDistance _distance = 0.0;
 
 
 if ([[Arr_events objectAtIndex:i] valueForKey:@"Lat"] != nil || [[Arr_events objectAtIndex:i] valueForKey:@"Lon"] != nil) 
 
 _distance = [self calculateDistance:[[[Arr_events objectAtIndex:i] valueForKey:@"Lat"] doubleValue] andLongitude:[[[Arr_events objectAtIndex:i] valueForKey:@"Lon"] doubleValue]];
 
 
 [[DBFunctionality sharedInstance] InsertValue_NonSubPub_Info:pubid withName:[[Arr_events objectAtIndex:i] valueForKey:@"Venue Name"] distance:_distance latitude:[[Arr_events objectAtIndex:i] valueForKey:@"Lat"] longitude:[[Arr_events objectAtIndex:i] valueForKey:@"Lon"] postCode:[[Arr_events objectAtIndex:i] valueForKey:@"Post Code"] district:[[Arr_events objectAtIndex:i] valueForKey:@"Pub Dist"] city:[[Arr_events objectAtIndex:i] valueForKey:@"Pub City"] lastUpdatedDate:(NSString *)[NSDate date] phoneNo:[[Arr_events objectAtIndex:i] valueForKey:@"Pub Phone"]];//_distance/1000
 }
 [Arr_events release];
 
 nonSubValue++;
 NSLog(@"nonSubValue  %d",nonSubValue);
 if (nonSubValue <= 7) {
 
 [self callingUpdatedNonSubPubs:nonSubValue];
 }
 else
 {
 [self performSelector:@selector(dismissHUD:)];
 
 }
 }
 
 //[self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"ThemeNight" waitUntilDone:YES];
 
 
 //  [self performSelector:@selector(dismissHUD:)];
 }*/



#pragma mark
#pragma mark AddNotification


-(void)AddNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInTwitter:)name:@"Twitter"  object:nil];  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInGooglePlus:)name:@"GooglePlus"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInLinkedin:)name:@"Linkedin"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInFacebook:)name:@"Facebook"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShareInMessage:)name:@"Message"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Settings:)name:@"Settings"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterSuccessfulConnection:)name:@"afterSuccessfulConnection"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterFailourConnection:)name:@"afterFailourConnection"  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(servercalling:)name:@"callingServer"  object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Added on Home" object:self];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    


}



-(void) applicationActive
{
    NSLog(@"applicationActive");
    
    UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Do you want to download updated information?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alert.tag = 60;
    [alert  show];
    [alert  release];
    
}







#pragma mark
#pragma mark Social Network Functions

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
    [obj release];
}

- (void)servercalling:(NSNotification *)notification
{
    
    [self performSelector:@selector(addMBHud)];
    [self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:0.5];
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


- (void)ShareInFacebook:(NSNotification *)notification {
    
    FBViewController *obj = [[FBViewController alloc] initWithNibName:@"FBViewController" bundle:nil];
    obj.shareText = @"Check out this great FREE app and search facility for finding pubs and bars” http://tinyurl.com/dxzhhto";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    [self presentModalViewController:nav animated:YES];
    [obj release];
    [nav release];
}





#pragma mark - EmailComposer Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{        
    [self.navigationController dismissModalViewControllerAnimated:YES];
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


#pragma mark
#pragma mark LinkedIN Delegates


-(void) loginViewDidFinish:(NSNotification*)notification
{
    // [oAuthLoginView release];
    // oAuthLoginView = nil;
    //[oAuthLoginView testApiForPostingMessage:nil];
}


#pragma mark
#pragma mark Facebook Delegates

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
     @"Check out this great FREE app and search facility for finding pubs and bars” http://itunes.apple.com/gb/app/pub-and-bar-network/id462704657?mt=8",@"message",
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


#pragma mark
#pragma mark Interface Orientation

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"Select !!!");
    
    
    [self SetCustomNavBarFrame];
    [self setHomeViewFrame];
    [hometable reloadData];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    orientation = interfaceOrientation;
    
        
    if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBar.png"]];

      //  toolBar.frame = CGRectMake(8, 340, 303, 53);
        
        
            if (delegate.ismore==YES) {
          
            toolBar.frame = CGRectMake(8.5, 421, 303, 53);
            }
        
        else{
          
              toolBar.frame = CGRectMake(8.5, 421, 303, 53);
        }

    
    
    }

    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"FootarBarL.png"]];
        if (delegate.ismore==YES) {
            toolBar.frame = CGRectMake(8.5, 261, 463, 53);
        }
        else{
            toolBar.frame = CGRectMake(8.5, 261, 463, 53);
        }
                   
        
        
    }
    
    /* CGPoint pointOrigin=CGPointMake(-320, 380);
     if(toolBar.frame.origin.x==pointOrigin.x)
     toolBar.frame = CGRectMake(-480, 240, 960, 48);
     else
     toolBar.frame = CGRectMake(0, 240, 960, 48);*/

    return YES;
}



#pragma mark
#pragma mark IBActions

-(IBAction)ClickSignUp:(id)sender{
    NSLog(@"ClickSignUp");
    
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.pubandbar-network.co.uk/Visitor/addVisitor.php"]]];
    
}


#pragma mark
#pragma mark TableView Delegates


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return [selectionArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;	
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger ICON_IMG_TAG = 1002;
    const NSInteger PUSH_IMAGE_TAG = 1003;
    const NSInteger MAINVIEW_VIEW_TAG = 1004;
    //const NSInteger NEARMENOW_VIEW_TAG = 1005;
    //const NSInteger FUNCTIONROOM_VIEW_TAG = 1006;


	UILabel *topLabel;
    UIImageView *iconImg;
    UIView *vw;
    //UILabel *nearmeNowLabel;
    //UILabel *functionRoomLabel;
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil)
	{
        
        cell =
		[[[UITableViewCell alloc]
		  initWithStyle:UITableViewCellStyleDefault
		  reuseIdentifier:CellIdentifier] autorelease]
		 ;
		
        
        UIView *vw1 =[[UIView alloc]initWithFrame:CGRectMake(6, 0, 310, 2)];
        vw1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        vw1.backgroundColor=[UIColor colorWithRed:98.0/255.0 green:111.0/255.0 blue:127.0/255.0 alpha:1];
        vw = [[[UIView alloc]init] autorelease];
        vw.frame =CGRectMake(0, 7, 320, 37);
        vw.tag = MAINVIEW_VIEW_TAG;
        vw.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  

        vw.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
        
        //if (indexPath.row == 0) {
        topLabel =
		[[UILabel alloc]initWithFrame:
         CGRectMake(100,0,170,37)]
        ;
            //topLabel.backgroundColor = [UIColor redColor];
        //}
        //else
		
        topLabel.lineBreakMode = UILineBreakModeWordWrap;
        topLabel.numberOfLines = 2;
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor whiteColor];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont boldSystemFontOfSize:16];
        [vw addSubview:topLabel];

        
        /*if (indexPath.row == 7) {
            topLabel.frame = CGRectMake(100, 0, 170, 24);
            topLabel.backgroundColor = [UIColor redColor];
            lbl_findme = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 90, 10)];
            lbl_findme.text = @"Find me one now!";
            lbl_findme.font = [UIFont boldSystemFontOfSize:10];
            [vw addSubview:lbl_findme];
            
        }*/
        
		
        
        iconImg = [[[UIImageView alloc]initWithFrame:CGRectMake(13, 7, 22, 22)]autorelease];
        iconImg.tag = ICON_IMG_TAG;
        //iconImg.autoresizingMask =UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if (orientation == UIInterfaceOrientationPortrait || orientation ==UIInterfaceOrientationPortraitUpsideDown) {
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrow.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"Runner.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"Note.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlass.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIcon.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlass.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIcon.png"];
            }
            
        }
        else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==UIInterfaceOrientationLandscapeRight) {
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrowL.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"RunnerL.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"NoteL.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlassL.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIconL.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlassL.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIconL.png"];
            }
            
        }
        
        
        [vw addSubview:iconImg];
        
        pushImg = [[[UIImageView alloc]initWithFrame:CGRectMake(280, 15, 10, 10)]autorelease];
        pushImg.tag = PUSH_IMAGE_TAG;
        pushImg.image=[UIImage imageNamed:@"right_iPhone"];
        pushImg.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; 
        [vw addSubview:pushImg];
        
        [cell.contentView addSubview:vw];
        [cell.contentView addSubview:vw1];           

        
    }
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		iconImg = (UIImageView *)[cell viewWithTag:ICON_IMG_TAG];
        pushImg=(UIImageView*)[cell viewWithTag:PUSH_IMAGE_TAG];
        vw = (UIView *)[cell viewWithTag:MAINVIEW_VIEW_TAG];
        
        
        
        /*else if (indexPath.row == 7) {
            if(self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
            topLabel.frame = CGRectMake(100, 0, 170, 24);
            //lbl_findme.frame = CGRectMake(120, 25, 90, 10);
            }
            else{
                topLabel.frame = CGRectMake(100, 0, 170, 24);
                //lbl_findme.frame = CGRectMake(120, 25, 90, 10);
            }
            
        }*/
      
        
        /*if ([indexPath row] == 0) {
            
            nearmeNowLabel = (UILabel *)[cell viewWithTag:NEARMENOW_VIEW_TAG];

        }
        if ([indexPath row] == 7) {
            
            functionRoomLabel = (UILabel *)[cell viewWithTag:FUNCTIONROOM_VIEW_TAG];

        }*/
       /* for (UILabel *label in [vw subviews]) {
            if([label isKindOfClass:[UILabel class]]){
                if (label.tag == NEARMENOW_VIEW_TAG) {
                    NSLog(@"Success");
                }
            }
        }*/

       
        
        if (orientation == UIInterfaceOrientationPortrait || orientation ==UIInterfaceOrientationPortraitUpsideDown){
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrow.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"Runner.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"Note.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlass.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIcon.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlass.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIcon.png"];
            }
            
        }
        else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation ==UIInterfaceOrientationLandscapeRight) {
            [iconImg setFrame:CGRectMake(13, 7, 19, 26)];
            if(indexPath.row==0){
                iconImg.image=[UIImage imageNamed:@"LocationArrowL.png"];
            }
            else if(indexPath.row==1){
                iconImg.image=[UIImage imageNamed:@"RunnerL.png"];
            }
            else if(indexPath.row==2){
                iconImg.image=[UIImage imageNamed:@"NoteL.png"];
            }
            else if(indexPath.row==3){
                iconImg.image=[UIImage imageNamed:@"BeerGlassL.png"];
            }
            else if(indexPath.row==4){
                iconImg.image=[UIImage imageNamed:@"ForkIconL.png"];
            }
            else if(indexPath.row==5){
                iconImg.image=[UIImage imageNamed:@"RightButtonL.png"];
            }
            else if(indexPath.row==6){
                iconImg.image=[UIImage imageNamed:@"MagnifyGlassL.png"];
            }
            else if(indexPath.row==7){
                iconImg.image=[UIImage imageNamed:@"BarrierIconL.png"];
            }
            
        }
        
	}
    @try {
        topLabel.text = [selectionArray objectAtIndex:indexPath.row];
        NSLog(@"ROW first  %d",[indexPath row]);
        if ([indexPath row] == 0) {
            NSLog(@"ROW  %d",[indexPath row]);

            //nearmeNowLabel.text = @".........................";

        }
        if ([indexPath row] == 7) {
            
            //functionRoomLabel.text = @"Find me one now!";
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBackGround.png"]]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    /*[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   if([InternetValidation checkNetworkStatus])
    {
        if (indexPath.row == 1) {
            deletedDataCall = NO;
            [self performSelector:@selector(addMBHud)];
            [self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"Sports on TV" waitUntilDone:YES];
//            DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
//            Obj._name=@"Sports on TV";
//            [self.navigationController pushViewController:Obj animated:YES];
//            [Obj release];
        }
        if (indexPath.row == 2) {
            deletedDataCall = NO;
            [self performSelector:@selector(addMBHud)];
            [self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"Events" waitUntilDone:YES];
            
        }
        if (indexPath.row == 3) {
            deletedDataCall = NO;
            
            [self performSelector:@selector(addMBHud)];
            [self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"Real Ale" waitUntilDone:YES];
        }
        if (indexPath.row == 4) {
            deletedDataCall = NO;
            
            [self performSelector:@selector(addMBHud)];
            [self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"Food & Offers" waitUntilDone:YES];
        }
        if (indexPath.row == 5) {
            deletedDataCall = NO;
            
            [self performSelector:@selector(addMBHud)];
            [self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"Facilities" waitUntilDone:YES];
        }
    }
    else
    {
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Internet Connection is Unavailable." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 30;
        [alert  show];
        [alert  release];
    }
    
    if (![delegate.sharedDefaults objectForKey:@"All"]) {
        
        //[self performSelector:@selector(doneLoadingTableViewData)];
        UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Due to connection failure data download is unfinished.Download will start." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
        alert.tag = 20;
        [alert  show];
        [alert  release];
        
        
    }
    if (indexPath.row == 0) {
        [self performSelector: @selector(addMBHud)];
        [self performSelector: @selector(updateDB4Distance) withObject:nil afterDelay:1.0];
        
    }
    if(indexPath.row==6){
        TextSearch *obj_text = [[TextSearch alloc]initWithNibName:[Constant GetNibName:@"TextSearch"] bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj_text animated:YES];
        [obj_text release];
        
    }
    if(indexPath.row==7){
        FunctionRoom *obj_functionroom = [[FunctionRoom alloc]initWithNibName:[Constant GetNibName:@"FunctionRoom"] bundle:[NSBundle mainBundle]];
        obj_functionroom.pageName=name;
        
        [self.navigationController pushViewController:obj_functionroom animated:YES];
        [obj_functionroom release];
        
    }*/
    
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (![delegate.sharedDefaults objectForKey:@"All"]) {
            
            [self performSelector:@selector(doneLoadingTableViewData)];
            UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:@"Due to connection failure data download is unfinished.Download will start." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
            alert.tag = 20;
            [alert  show];
            [alert  release];
            
            
        }
        else{
            name = [[NSString alloc]init];
            name = [selectionArray objectAtIndex:indexPath.row];
            
            if(delegate.IscurrentLocation==YES){
            
            
            
            if(indexPath.row==3){
                RealAle *obj_ele= [[RealAle alloc]initWithNibName:[Constant GetNibName:@"RealAle"] bundle:[NSBundle mainBundle] withString:name];
                obj_ele.realale=name;
                [self.navigationController pushViewController:obj_ele animated:YES];
                [obj_ele release];
                /* DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
                 Obj._name=name;
                 [self.navigationController pushViewController:Obj animated:YES];
                 [Obj release];*/
            }
            else if(indexPath.row==6){
                TextSearch *obj_text = [[TextSearch alloc]initWithNibName:[Constant GetNibName:@"TextSearch"] bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:obj_text animated:YES];
                [obj_text release];
                
            }
            else if(indexPath.row==7){
                FunctionRoom *obj_functionroom = [[FunctionRoom alloc]initWithNibName:[Constant GetNibName:@"FunctionRoom"] bundle:[NSBundle mainBundle]];
                obj_functionroom.pageName=name;
                
                [self.navigationController pushViewController:obj_functionroom animated:YES];
                [obj_functionroom release];
                
            }
            /*else if(indexPath.row == 0)
            {
                [self performSelector:@selector(addMBHud)];
                [self performSelector:@selector(updateDB4Distance) withObject:nil afterDelay:0.5];
            }*/
           
            else if(indexPath.row==0){
            
                self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                _hud.labelText = @"Fetching Data.";
                    
                [UtilityClass runAfterDelay:0.5 block:^{
                    
                    NearMeNow *objNearMENOW=[[NearMeNow alloc]initWithNibName:[Constant GetNibName:@"NearMeNow"] bundle:[NSBundle mainBundle]];
                    objNearMENOW._pageName=name;
                    //objNearMENOW.str_distance=pickerValue;
                    
                    [self.navigationController pushViewController:objNearMENOW animated:YES];
                    [objNearMENOW release];
                }];
                

              }
            else if((indexPath.row==1)||(indexPath.row==4)||(indexPath.row==5)){
                Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
                obj_catagory.Name = name;
               // obj_catagory.searchRadius = pickerValue;
                [self.navigationController pushViewController:obj_catagory animated:YES];
                [obj_catagory release];
                
            }
            else if(indexPath.row==2){
                EventCatagory *obj_event = [[EventCatagory alloc]initWithNibName:[Constant GetNibName:@"EventCatagory"] bundle:[NSBundle mainBundle] withString:name];
                obj_event.strPagename=name;
                [self.navigationController pushViewController:obj_event animated:YES];
                [ obj_event release];
                
            }


            
            
            else{
                DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
                Obj._name=name;
                [self.navigationController pushViewController:Obj animated:YES];
                [Obj release];
                
             }
           }
            else{
                
                
                
                if(indexPath.row==6){
                    TextSearch *obj_text = [[TextSearch alloc]initWithNibName:[Constant GetNibName:@"TextSearch"] bundle:[NSBundle mainBundle]];
                    [self.navigationController pushViewController:obj_text animated:YES];
                    [obj_text release];
                    
                }
                else{
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Pub and Bar Network" message:@"Please enable Location Services from your iPhone Settings to use this search feature. Only 'Text Search' can be used without location enabled." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                }

            }
        }
       
}



-(void)JSONStartWithName:(NSString*)_RefName
{
    
    if (![delegate.sharedDefaults objectForKey:@"All"])
    {
        if([_RefName isEqualToString:@"Events"])
        {
            if (![delegate.sharedDefaults objectForKey:@"Events"])
            {
                self.str_RefName =[NSString stringWithFormat:@"Events"];
                
                //   [self performSelector:@selector(addMBHud)];
                
                ServerConnection *conn1 = [[ServerConnection alloc] init];
                [conn1 setServerDelegate:self];
                [conn1 geteventsData:nil];
                [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
                [conn1 release];
                
                // [self performSelector:@selector(onStartPressed)];
            }
        }   
        else if([_RefName isEqualToString:@"ThemeNight"])
        {
            //if (![delegate.sharedDefaults objectForKey:@"Events"])
            //{
            self.str_RefName =[NSString stringWithFormat:@"ThemeNight"];
            
            //   [self performSelector:@selector(addMBHud)];
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 getThmeNightData:nil];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            //}
        }
        else if([_RefName isEqualToString:@"Real Ale"])
        {
            
            self.str_RefName =[NSString stringWithFormat:@"Real Ale"];
            
            if (![delegate.sharedDefaults objectForKey:@"Real Ale"]) {
                
                // [self performSelector:@selector(addMBHud)];
                
                ServerConnection *conn1 = [[ServerConnection alloc] init];
                [conn1 setServerDelegate:self];
                [conn1 getRealAleData:nil];
                [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
                [conn1 release];
                // [self performSelector:@selector(onStartPressed)];
                
            }
            
        }
        
        else if([_RefName isEqualToString:@"Sports on TV"])
        {
            self.str_RefName =[NSString stringWithFormat:@"Sports on TV"];
            /*Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
             obj_catagory.Name = _name;
             obj_catagory.searchRadius = pickerValue;
             [self.navigationController pushViewController:obj_catagory animated:YES];
             [obj_catagory release];*/
            
            if (![delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
                //  [self performSelector:@selector(addMBHud)];
                ServerConnection *conn1 = [[ServerConnection alloc] init];
                [conn1 setServerDelegate:self];
                [conn1 getSportsData:nil];
                [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
                [conn1 release];
                //[self performSelector:@selector(onStartPressed)];
                
            }
        }
        
        
        else if([_RefName isEqualToString:@"Facilities"])
        {
            
            self.str_RefName =[NSString stringWithFormat:@"Facilities"];
            //---------------------------mb 5-45 -----------------------------//
            
            if (![delegate.sharedDefaults objectForKey:@"Facilities"]) {
                
                //   [self performSelector:@selector(addMBHud)];
                
                ServerConnection *conn1 = [[ServerConnection alloc] init];
                [conn1 setServerDelegate:self];
                [conn1 getEventsData:nil];
                [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
                [conn1 release];
                // [self performSelector:@selector(onStartPressed)];
                
            }
        }
        
        else if([_RefName isEqualToString:@"Food & Offers"])
        { 
            self.str_RefName =[NSString stringWithFormat:@"Food & Offers"];
            if (![delegate.sharedDefaults objectForKey:@"Food"])
            {
                // [self performSelector:@selector(addMBHud)];
                ServerConnection *conn1 = [[ServerConnection alloc] init];
                [conn1 setServerDelegate:self];
                [conn1 getFoodandOffersData:nil];
                [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
                [conn1 release];
                //[self performSelector:@selector(onStartPressed)];
                
            }
            
        }
    }
    //Biswa
    else{
        if([_RefName isEqualToString:@"Events"])
        {
            //if (![delegate.sharedDefaults objectForKey:@"Events"])
            //{
            self.str_RefName =[NSString stringWithFormat:@"Events"];
            /*[delegate.sharedDefaults setObject:@"1" forKey:@"Events"];
             self.RefNo+=1;
             [self ExcuteURLWithNameRefWithDate:self.RefNo]; */
            
            NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            //[dateFormat setLocale:[NSLocale currentLocale]];
            NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]]];
            
            NSDateFormatter *dateFormat2 = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormat2 setDateFormat:@"dd-MM-yyyy HH:mm"];
            
            NSString *dateString = [dateFormat2 stringFromDate:tempDate];
            NSLog(@"DATE  %@",dateString);
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 geteventsData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];//
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            //}
        } 
        else if([_RefName isEqualToString:@"ThemeNight"])
        {
            //if (![delegate.sharedDefaults objectForKey:@"Events"])
            //{
            self.str_RefName =[NSString stringWithFormat:@"ThemeNight"];
            
            //   [self performSelector:@selector(addMBHud)];
            //[delegate.sharedDefaults setObject:@"1" forKey:@"ThemeNight"];
            //self.RefNo+=1;
            //[self ExcuteURLWithNameRefWithDate:self.RefNo]; 
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 getThmeNightData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];//
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            //}
        }
        else if([_RefName isEqualToString:@"Real Ale"])
        {
            
            self.str_RefName =[NSString stringWithFormat:@"Real Ale"];
            
            //if (![delegate.sharedDefaults objectForKey:@"Real Ale"]) {
            
            // [self performSelector:@selector(addMBHud)];
            /* [delegate.sharedDefaults setObject:@"1" forKey:@"Real Ale"];
             self.RefNo+=1;
             [self ExcuteURLWithNameRefWithDate:self.RefNo]; */
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 getRealAleData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            // }
            
        }
        
        else if([_RefName isEqualToString:@"Sports on TV"])
        {
            self.str_RefName =[NSString stringWithFormat:@"Sports on TV"];
            /*Catagory *obj_catagory = [[Catagory alloc]initWithNibName:[Constant GetNibName:@"Catagory"] bundle:[NSBundle mainBundle]];
             obj_catagory.Name = _name;
             obj_catagory.searchRadius = pickerValue;
             [self.navigationController pushViewController:obj_catagory animated:YES];
             [obj_catagory release];*/
            
            // if (![delegate.sharedDefaults objectForKey:@"Sports on TV"]) {
            //  [self performSelector:@selector(addMBHud)];
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 getSportsData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            //}
        }
        
        
        else if([_RefName isEqualToString:@"Facilities"])
        {
            
            self.str_RefName =[NSString stringWithFormat:@"Facilities"];
            //---------------------------mb 5-45 -----------------------------//
            
            //if (![delegate.sharedDefaults objectForKey:@"Facilities"]) {
            
            //   [self performSelector:@selector(addMBHud)];
            //[delegate.sharedDefaults setObject:@"1" forKey:@"Facilities"];
            //self.RefNo+=1;
            //[self ExcuteURLWithNameRefWithDate:self.RefNo]; 
            
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 getEventsData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            //}
        }
        
        else if([_RefName isEqualToString:@"Food & Offers"])
        { 
            self.str_RefName =[NSString stringWithFormat:@"Food & Offers"];
            //if (![delegate.sharedDefaults objectForKey:@"Food"])
            //{
            // [self performSelector:@selector(addMBHud)];
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 getFoodandOffersData:[[DBFunctionality sharedInstance]GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
            //}
            
        }
    }        
    
        
}


#pragma mark
#pragma mark Receive From Server And Insert Into DB

/*
-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    
    
    
    NSLog(@"RESPONSE  %@",data_Response);
    NSLog(@"%@",self.str_RefName );
    
    //NSLog(@"pickervalue 11 %@",pickerValue);
    
    if (!deletedDataCall) {
        
        
        if ([self.str_RefName isEqualToString:@"NonSubPubs"]) 
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"nonSubscribers"] valueForKey:@"NonSub PubDetails"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                    // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                    int pubid = [[[Arr_events objectAtIndex:i] valueForKey:@"pubID"] intValue];
                    CLLocationDistance _distance = 0.0;
                    
                    
                    if ([[Arr_events objectAtIndex:i] valueForKey:@"Lat"] != nil || [[Arr_events objectAtIndex:i] valueForKey:@"Lon"] != nil) 
                        
                        _distance = [self calculateDistance:[[[Arr_events objectAtIndex:i] valueForKey:@"Lat"] doubleValue] andLongitude:[[[Arr_events objectAtIndex:i] valueForKey:@"Lon"] doubleValue]];
                    
                    
                    [[DBFunctionality sharedInstance] InsertValue_NonSubPub_Info:pubid withName:[[Arr_events objectAtIndex:i] valueForKey:@"Venue Name"] distance:_distance latitude:[[Arr_events objectAtIndex:i] valueForKey:@"Lat"] longitude:[[Arr_events objectAtIndex:i] valueForKey:@"Lon"] postCode:[[Arr_events objectAtIndex:i] valueForKey:@"Post Code"] district:[[Arr_events objectAtIndex:i] valueForKey:@"Pub Dist"] city:[[Arr_events objectAtIndex:i] valueForKey:@"Pub City"] lastUpdatedDate:(NSString *)[NSDate date] phoneNo:[[Arr_events objectAtIndex:i] valueForKey:@"Pub Phone"]];//_distance/1000
                }
            }
            [Arr_events release];
            nonSubValue++;
            NSLog(@"nonSubValue  %d",nonSubValue);
            if (nonSubValue <= 7) {
                
                [self callingNonSubPubs:nonSubValue];
            }
            else
            {
                 [self performSelector:@selector(dismissHUD:)];

            }
            //[self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"ThemeNight" waitUntilDone:YES];
            
            
            //  [self performSelector:@selector(dismissHUD:)];
        }
        
        
        if ([self.str_RefName isEqualToString:@"Events"]) 
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"Events"];
            [delegate.sharedDefaults synchronize];
            [self performSelector:@selector(JSONStartWithName:) withObject:@"ThemeNight"];
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                    NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                    //NSLog(@"%@",Str_Event);
                    NSString *EventTypeID;
                    
                    if ([Str_Event isEqualToString:@"RegularEvent"])
                        EventTypeID = @"1";
                    else if([Str_Event isEqualToString:@"OneOffEvent"])
                        EventTypeID = @"2";
                    
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                        NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            CLLocationDistance _distance = 0.0;
                            
                            
                            if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil) 
                                _distance = [self calculateDistance:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            //_distance = [Constant GetDistanceFromPub: longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"]];
                            //NSLog(@"%f",_distance);
                            //_distance = 2;
                            //[[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance];
                            
                            // NSLog(@"%@",[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]);
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"createDate"] eventDay:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDay"] expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"expiryDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            [Arr_events release];
            
            
            //[self performSelectorOnMainThread:@selector(JSONStartWithName:) withObject:@"ThemeNight" waitUntilDone:YES];
           
            
            //  [self performSelector:@selector(dismissHUD:)];
        }
        
       else if ([self.str_RefName isEqualToString:@"ThemeNight"]) 
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"ThemeNight"];
            [delegate.sharedDefaults synchronize];
            
            [self deletedDataCalling:0];
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                    NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                    //NSLog(@"%@",Str_Event);
                    NSString *EventTypeID;
                    
                     if([Str_Event isEqualToString:@"ThemeNight"])
                        EventTypeID = @"3";
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                        NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            CLLocationDistance _distance = 0.0;
                            
                            
                            if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil) 
                                _distance = [self calculateDistance:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            //_distance = [Constant GetDistanceFromPub: longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"]];
                            //NSLog(@"%f",_distance);
                            //_distance = 2;
                            //[[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance];
                            
                            // NSLog(@"%@",[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]);
                            NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
                            [dateFormat setDateFormat:@"yyyy-MM-dd"];
                            //[dateFormat setLocale:[NSLocale currentLocale]];
                            NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]]];
                            
                            NSDateFormatter *dateFormat2 = [[[NSDateFormatter alloc] init] autorelease];
                            [dateFormat2 setDateFormat:@"EEE"];
                            
                            NSString *dateString = [[dateFormat2 stringFromDate:tempDate] uppercaseString]; 
                            
                            NSLog(@"%@",dateString);
                            
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"] eventDay:dateString expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            [Arr_events release];
            
            
            //[self performSelector:@selector(dismissHUD:)];
        }
        
        else if([self.str_RefName  isEqualToString:@"Food & Offers"])
        {
            //SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Food & Offers" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *foodAndOfferArray = [[[json valueForKey:@"Details"] valueForKey:@"Food & Offers Details"] retain];
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"Food"];
            [delegate.sharedDefaults synchronize];
            [self deletedDataCalling:5];
            
            //[parser release];
            
            //-----------------------------mb-----------------------------//
            if ([foodAndOfferArray count]!=0)
            {
                //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
                for (int i = 0; i<[foodAndOfferArray count]; i++)
                {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Food_Type:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] withName:[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food and Offers Type"]];
                    
                    NSMutableArray *pubInfoArray = [[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Pub Information"] retain];
                    
                    for (int j = 0; j<[pubInfoArray count]; j++)
                    {
                        
                        //NSLog(@"%@",currentPoint);
                        //NSLog(@"Lat  %f   Long  %f",currentPoint.coordinate.latitude,currentPoint.coordinate.longitude);
                        //appDelegate.currentPoint.coordinate.latitude
                        //appDelegate.currentPoint.coordinate.longitude
                        
                        //    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] doubleValue]];
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Food_Detail:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withFoodID:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] pubDistance:0.0];//distance/1000
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:j] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:j] valueForKey:@"venuePhoto"]];//distance/1000
                    }
                    //NSLog(@"pubInfoArray   %@",pubInfoArray);
                    [pubInfoArray release];
                }
                //   [self performSelector:@selector(dismissHUD:)];
            }
            [foodAndOfferArray release];
            
            //else
             {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Food and Offers" message:@"NO Data Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             //[alert show];
             [alert release];
             }*/
            
            
        /*}
        
        
        else if([self.str_RefName isEqualToString:@"Real Ale"])
        {
            //SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Real Ale" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *realAleArray = [[[json valueForKey:@"Details"] valueForKey:@"Brewery Details"] retain];
            //[parser release];
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"Real Ale"];
            [delegate.sharedDefaults synchronize];
            [self deletedDataCalling:4];
            
            if ([realAleArray count] !=0) {
                
                for (int i = 0; i<[realAleArray count]; i++) {
                    
                    
                    
                    NSMutableArray *beerDetailsArray = [[[realAleArray objectAtIndex:i] valueForKey:@"Beer Details"] retain];
                    
                    for (int j = 0; j<[beerDetailsArray count]; j++) {
                        
                        
                        NSMutableArray *pubDetailsArray = [[[beerDetailsArray objectAtIndex:j] valueForKey:@"Pub Information"] retain];
                        
                        
                        for (int k = 0; k< [pubDetailsArray count]; k++) {
                            
                            
                            //      double distance = [self calculateDistance:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            
                            [[DBFunctionality sharedInstance] InsertValue_RealAle_Type:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withName:[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Name"] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] pubDistance:0.0];//distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Beer_Detail:[[[beerDetailsArray objectAtIndex:j] valueForKey:@"Beer ID"] intValue] withBreweryID:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withBeerName:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Ale Name"] withBeerCategory:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Category"] pubDistance:0.0];//distance/1000
                            
                            
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubDetailsArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000 
                        }
                        [pubDetailsArray release];
                    }
                    
                    [beerDetailsArray release];
                }
                
                
            }
            [realAleArray release];
            
            else
             {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"RealAle" message:@"NO Data Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             //[alert show];
             [alert release];
             }*/
            
            
       /* }
        
        //----------------------mb-25/05/12/5-45p.m.------------------------//
        else if([self.str_RefName  isEqualToString:@"Facilities"])
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Facilities" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *AmenitiesArray = [[[json valueForKey:@"Details"] valueForKey:@"Amenities Details"] retain];
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"Facilities"]; 
            [delegate.sharedDefaults synchronize];
            [self deletedDataCalling:6];
            
            if ([AmenitiesArray count] != 0) {
                
                for (int i = 0; i<[AmenitiesArray count]; i++) {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Amenities_Type:i+1 withName:[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]];
                    
                    NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Facility Details"] retain];
                    //NSLog(@"facilityDetailsArray  %d",[facilityDetailsArray count]);
                    
                    for (int j = 0; j<[facilityDetailsArray count]; j++) {
                        
                        NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                        //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                        
                        for (int k=0; k<[pubInfoArray count]; k++) {
                            
                            
                            
                            //     double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            
                            
                            
                            [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                        }
                        
                        [pubInfoArray release];
                    }
                    [facilityDetailsArray release];
                }
            }
            [AmenitiesArray release];
            
            
            
            //[self performSelector:@selector(dismissHUD:)];
            
        }
        //-----------------------------5-45------------------------//
        
        //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
        
        else if([self.str_RefName  isEqualToString:@"Sports on TV"])
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Sports on TV" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *sportsArray = [[[json valueForKey:@"Details"] valueForKey:@"Sports Details"] retain];
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"Sports on TV"];  
            [delegate.sharedDefaults synchronize];
            [self deletedDataCalling:3];
            
            if ([sportsArray count] != 0) {
                
                for (int i = 0; i<[sportsArray count]; i++) {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Sports_Type:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] withName:[[sportsArray objectAtIndex:i] valueForKey:@"Category Name"]];
                    
                    NSMutableArray *sportDetailsArray = [[[sportsArray objectAtIndex:i] valueForKey:@"event"] retain];
                    NSLog(@"sportDetailsArray  %d",[sportDetailsArray count]);
                    
                    for (int j = 0; j<[sportDetailsArray count]; j++) {
                        
                        NSMutableArray *pubInfoArray=[[[sportDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                        //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                        
                        //                        if ([pubInfoArray count] == 35) {
                        //                            
                        //                            NSLog(@"Problem");
                        //                        }
                        
                        for (int k=0; k<[pubInfoArray count]; k++) {
                            
                            
                            //   double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            
                            
                            [[DBFunctionality sharedInstance] InsertValue_Sports_Detail:[[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventID"] intValue] sport_TypeID:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] event_Name:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventName"] event_Description:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventDescription"] event_Date:[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"] event_Channel:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Channel"] reservation:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Reservation"] sound:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Sound"] hd:[[sportDetailsArray objectAtIndex:j] valueForKey:@"HD"] threeD:[[sportDetailsArray objectAtIndex:j] valueForKey:@"threeD"] screen:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Screen"] PubID:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withPubDistance:0.0 event_Time:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Time"] event_Type:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Type"]];//distance/1000
                            
                            //NSLog(@"DATESHOW   %@",[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"]);
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                        }
                        
                        [pubInfoArray release];
                    }
                    [sportDetailsArray release];
                }
            }
            
            [sportsArray release];
            
            //[self performSelector:@selector(dismissHUD:)];
            
            
        }
        
        
        self.RefNo+=1;
         if (![delegate.sharedDefaults objectForKey:@"All"]) {
         
         [self ExcuteURLWithNameRef:self.RefNo]; 
         
         }
         else{
         [self ExcuteURLWithNameRefWithDate:self.RefNo]; 
         
         }
         
         if (self.RefNo == 6) {
         RefNo=0;
         [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
         [[DBFunctionality4Update sharedInstance] UpdatePubDistance];
         [self deletedDataCalling:0];
         }*/
   /* }
    
    else{
        
        if ([deletedEventString isEqualToString:@"EventsDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                [self deletedDataCalling:1];

                
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteRegularEvents:[[json valueForKey:@"Details"] valueForKey:@"Non Active Events"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    
                }
                //[Arr_events release];
                
                //sleep(2);
                //[self deletedDataCalling:1];
                
                //  [self performSelector:@selector(dismissHUD:)];
                
            }
        }
        
        else if ([deletedEventString isEqualToString:@"ThemeNightDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                [self deletedDataCalling:2];

                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteThemenightEvents:[[json valueForKey:@"Details"] valueForKey:@"Active Theme"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    
                }
                
                //[Arr_events release];
                //sleep(2);
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"OneOffDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteOneOffEvents:[[json valueForKey:@"Details"] valueForKey:@"Non Active Events"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    [[DBFunctionality4Delete sharedInstance] deleteExpiredEvents];

                }
                //[Arr_events release];
                //sleep(2);
                //[self deletedDataCalling:3];
                //  [self performSelector:@selector(dismissHUD:)];
                [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance4Events];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance];

                
                [self performSelector:@selector(dismissHUD:)];
                DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
                Obj._name=@"Events";
                [self.navigationController pushViewController:Obj animated:YES];
                [Obj release];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"SportsDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    NSMutableArray *sportsIDArray = [[NSMutableArray alloc] init];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"sportID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteSports:pubid andEventID:EventId];
                                
                                [sportsIDArray addObject:[NSString stringWithFormat:@"%d",EventId]];
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    [[DBFunctionality4Delete sharedInstance] deleteExpiredSportsEvent];

                    [[DBFunctionality4Delete sharedInstance] deleteSports:sportsIDArray];
                }
                [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance4Sports];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance];

                
                [self performSelector:@selector(dismissHUD:)];
                
                DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
                Obj._name=@"Sports on TV";
                [self.navigationController pushViewController:Obj animated:YES];
                [Obj release];
                
                //[Arr_events release];
                //sleep(2);
                //[self deletedDataCalling:4];
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"RealAleDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteRealAle:[[json valueForKey:@"Details"] valueForKey:@"Non Active Ales"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteRealAle:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                }
                [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance4RealAle];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance];

                
                [self performSelector:@selector(dismissHUD:)];
                RealAle *obj_ele= [[RealAle alloc]initWithNibName:[Constant GetNibName:@"RealAle"] bundle:[NSBundle mainBundle] withString:name];
                obj_ele.realale=@"Real Ale";
                [self.navigationController pushViewController:obj_ele animated:YES];
                [obj_ele release];
                //[Arr_events release];
                //sleep(2);
                //[self deletedDataCalling:5];
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"FoodDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Food Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FoodID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteFoods:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    //[Arr_events release];
                }
                
                //[Arr_events release];
                //sleep(2);
                //[self deletedDataCalling:6];
                //deletedDataCall = NO;
                //[self performSelector:@selector(doneLoadingTableViewData)];	
                //  [self performSelector:@selector(dismissHUD:)];
                [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance4Foods];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance];

                
                [self performSelector:@selector(dismissHUD:)];
                DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
                Obj._name=@"Food & Offers";
                [self.navigationController pushViewController:Obj animated:YES];
                [Obj release];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"FacilityDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Facility Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    int EventTypeID;
                    if ([[[Arr_events objectAtIndex:0] valueForKey:@"Event Name"] isEqualToString:@"Facility"])
                        EventTypeID = 1;
                    else if([[[Arr_events objectAtIndex:1] valueForKey:@"Event Name"] isEqualToString:@"Style"])
                        EventTypeID = 2;
                    else if([[[Arr_events objectAtIndex:2] valueForKey:@"Event Name"] isEqualToString:@"Features"])
                        EventTypeID = 3;
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        //NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        //NSString *EventTypeID;
                        
                        
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FacilityID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteFacilities:pubid andEventID:EventId:EventTypeID];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    //[Arr_events release];
                }
                
                //[Arr_events release];
                //sleep(2);
                //deletedDataCall = NO;
                //[self performSelector:@selector(doneLoadingTableViewData)];	
                //  [self performSelector:@selector(dismissHUD:)];
                [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance4Facilities];
                [[DBFunctionality4Update sharedInstance] UpdatePubDistance];

                
                [self performSelector:@selector(dismissHUD:)];
                DistenceWheel *Obj = [[DistenceWheel alloc]initWithNibName:[Constant GetNibName:@"DistenceWheel"] bundle:[NSBundle mainBundle]];
                Obj._name=@"Facilities";
                [self.navigationController pushViewController:Obj animated:YES];
                [Obj release];
            }
        }
    }
    
    //[self performSelector:@selector(dismissHUD:)];
    
}*/




-(void)afterSuccessfulConnection:(NSString*)data_Response
{	
    
    
    
    //NSLog(@"RESPONSE  %@",data_Response);
    //NSLog(@"%@",self.str_RefName );
    
    //NSLog(@"pickervalue 11 %@",pickerValue);
    
    if (!deletedDataCall) {
        
        if ([self.str_RefName isEqualToString:@"Events"]) 
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                    NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                    //NSLog(@"%@",Str_Event);
                    NSString *EventTypeID;
                    
                    if ([Str_Event isEqualToString:@"RegularEvent"])
                        EventTypeID = @"1";
                    else if([Str_Event isEqualToString:@"OneOffEvent"])
                        EventTypeID = @"2";
                    else if([Str_Event isEqualToString:@"ThemeNight"])
                        EventTypeID = @"3";
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                        NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            CLLocationDistance _distance = 0.0;
                            
                            
                            if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil) 
                            {
                                 //_distance = [self calculateDistance:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            }
                               
                           
                            
                            // NSLog(@"%@",[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]);
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"createDate"] eventDay:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDay"] expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"expiryDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            [Arr_events release];
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"Events"];
            [delegate.sharedDefaults synchronize];
            
            //  [self performSelector:@selector(dismissHUD:)];
        }
        
        if ([self.str_RefName isEqualToString:@"ThemeNight"]) 
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Events" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
            NSLog(@"%d",[Arr_events count]);
            
            if ([Arr_events count] != 0) {
                
                for (int i = 0; i < [Arr_events count]; i++) {
                    
                    //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                    NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                    //NSLog(@"%@",Str_Event);
                    NSString *EventTypeID;
                    
                    if ([Str_Event isEqualToString:@"RegularEvent"])
                        EventTypeID = @"1";
                    else if([Str_Event isEqualToString:@"OneOffEvent"])
                        EventTypeID = @"2";
                    else if([Str_Event isEqualToString:@"ThemeNight"])
                        EventTypeID = @"3";
                    
                    NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                    //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                    
                    for (int j = 0; j < [Arr_EventDetails count]; j++) {
                        
                        int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                        NSString *Str_EventName = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Name"];
                        // NSLog(@"%d",EventId);
                        //NSLog(@"%@",Str_EventName);
                        
                        NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                        //NSLog(@"%d",[Arr_PubInfo count]);
                        
                        for (int k = 0; k < [Arr_PubInfo count]; k++) {
                            
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                            // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                            int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                            CLLocationDistance _distance = 0.0;
                            
                            
                            if ([[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] != nil || [[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] != nil){ 
                                //_distance = [self calculateDistance:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            }
                            //_distance = [Constant GetDistanceFromPub: longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"]];
                            //NSLog(@"%f",_distance);
                            //_distance = 2;
                            //[[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:_distance];
                            
                            // NSLog(@"%@",[[Arr_EventDetails objectAtIndex:j] valueForKey:@"creationDate"]);
                            NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
                            [dateFormat setDateFormat:@"yyyy-MM-dd"];
                            //[dateFormat setLocale:[NSLocale currentLocale]];
                            NSDate *tempDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]]];
                            
                            NSDateFormatter *dateFormat2 = [[[NSDateFormatter alloc] init] autorelease];
                            [dateFormat2 setDateFormat:@"EEE"];
                            
                            NSString *dateString = [[dateFormat2 stringFromDate:tempDate] uppercaseString]; 
                            
                            //NSLog(@"%@",dateString);
                            
                            [[DBFunctionality sharedInstance] InsertIntoEventDetailsWithEventID:EventId Name:Str_EventName EventTypeID:EventTypeID PubID:pubid PubDistance:0.0 creationdate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"] eventDay:dateString expiryDate:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"eventDate"]];//_distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:pubid withName:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Latitude"]  longitude:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[Arr_PubInfo objectAtIndex:k] valueForKey:@"venuePhoto"]];//_distance/1000
                            
                        }
                    }
                }
            }
            [Arr_events release];
            
            [delegate.sharedDefaults setObject:@"1" forKey:@"ThemeNight"];
            [delegate.sharedDefaults synchronize];
            
            //  [self performSelector:@selector(dismissHUD:)];
        }
        
        else if([self.str_RefName  isEqualToString:@"Food & Offers"])
        {
            //SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Food & Offers" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *foodAndOfferArray = [[[json valueForKey:@"Details"] valueForKey:@"Food & Offers Details"] retain];
            //[parser release];
            
            //-----------------------------mb-----------------------------//
            if ([foodAndOfferArray count]!=0)
            {
                //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
                for (int i = 0; i<[foodAndOfferArray count]; i++)
                {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Food_Type:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] withName:[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food and Offers Type"]];
                    
                    NSMutableArray *pubInfoArray = [[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Pub Information"] retain];
                    
                    for (int j = 0; j<[pubInfoArray count]; j++)
                    {
                        
                        //NSLog(@"%@",currentPoint);
                        //NSLog(@"Lat  %f   Long  %f",currentPoint.coordinate.latitude,currentPoint.coordinate.longitude);
                        //appDelegate.currentPoint.coordinate.latitude
                        //appDelegate.currentPoint.coordinate.longitude
                        
                        //    double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] doubleValue]];
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Food_Detail:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withFoodID:[[[foodAndOfferArray objectAtIndex:i] valueForKey:@"Food Id"] intValue] pubDistance:0.0];//distance/1000
                        
                        
                        [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:j] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:j] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:j] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:j] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:j] valueForKey:@"venuePhoto"]];//distance/1000
                    }
                    //NSLog(@"pubInfoArray   %@",pubInfoArray);
                    [pubInfoArray release];
                }
                //   [self performSelector:@selector(dismissHUD:)];
            }
            [foodAndOfferArray release];
            
            /*else
             {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Food and Offers" message:@"NO Data Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             //[alert show];
             [alert release];
             }*/
            [delegate.sharedDefaults setObject:@"1" forKey:@"Food"];
            [delegate.sharedDefaults synchronize];
            
        }
        
        
        else if([self.str_RefName isEqualToString:@"Real Ale"])
        {
            //SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Real Ale" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *realAleArray = [[[json valueForKey:@"Details"] valueForKey:@"Brewery Details"] retain];
            //[parser release];
            
            if ([realAleArray count] !=0) {
                
                for (int i = 0; i<[realAleArray count]; i++) {
                    
                    
                    
                    NSMutableArray *beerDetailsArray = [[[realAleArray objectAtIndex:i] valueForKey:@"Beer Details"] retain];
                    
                    for (int j = 0; j<[beerDetailsArray count]; j++) {
                        
                        
                        NSMutableArray *pubDetailsArray = [[[beerDetailsArray objectAtIndex:j] valueForKey:@"Pub Information"] retain];
                        
                        
                        for (int k = 0; k< [pubDetailsArray count]; k++) {
                            
                            
                            //      double distance = [self calculateDistance:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            
                            [[DBFunctionality sharedInstance] InsertValue_RealAle_Type:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withName:[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Name"] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] pubDistance:0.0];//distance/1000
                            
                            [[DBFunctionality sharedInstance] InsertValue_Beer_Detail:[[[beerDetailsArray objectAtIndex:j] valueForKey:@"Beer ID"] intValue] withBreweryID:[[[realAleArray objectAtIndex:i] valueForKey:@"Brewery Id"] intValue] withPubID:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withBeerName:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Ale Name"] withBeerCategory:[[beerDetailsArray objectAtIndex:j] valueForKey:@"Category"] pubDistance:0.0];//distance/1000
                            
                            
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubDetailsArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubDetailsArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubDetailsArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000 
                        }
                        [pubDetailsArray release];
                    }
                    
                    [beerDetailsArray release];
                }
                
                
            }
            [realAleArray release];
            
            /*else
             {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"RealAle" message:@"NO Data Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             //[alert show];
             [alert release];
             }*/
            [delegate.sharedDefaults setObject:@"1" forKey:@"Real Ale"];
            [delegate.sharedDefaults synchronize];
            
        }
        
        //----------------------mb-25/05/12/5-45p.m.------------------------//
        else if([self.str_RefName  isEqualToString:@"Facilities"])
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Facilities" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *AmenitiesArray = [[[json valueForKey:@"Details"] valueForKey:@"Amenities Details"] retain];
            
            if ([AmenitiesArray count] != 0) {
                
                for (int i = 0; i<[AmenitiesArray count]; i++) {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Amenities_Type:i+1 withName:[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]];
                    
                    //NSLog(@"facilityDetailsArray  %d",[facilityDetailsArray count]);
                    
                    if ([[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"] isEqualToString:@"Facilities"]) {
                        NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Facility Details"] retain];
                        
                        NSLog(@"Ammenity name  %@",[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]);
                        for (int j = 0; j<[facilityDetailsArray count]; j++) {
                            
                            NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                            //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                            
                            for (int k=0; k<[pubInfoArray count]; k++) {
                                
                                
                                
                                //     double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                                
                                
                                
                                [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Facility Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                                
                                [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                            }
                            
                            [pubInfoArray release];
                        }
                        [facilityDetailsArray release];
                        
                    }
                    
                    
                    if ([[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"] isEqualToString:@"Style(s)"]) {
                        
                        NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Style Details"] retain];
                        NSLog(@"Ammenity name  %@",[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]);
                        
                        for (int j = 0; j<[facilityDetailsArray count]; j++) {
                            
                            NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                            //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                            
                            for (int k=0; k<[pubInfoArray count]; k++) {
                                
                                
                                
                                //     double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                                
                                
                                
                                [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Style ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Style Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                                
                                [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                            }
                            
                            [pubInfoArray release];
                        }
                        [facilityDetailsArray release];
                    }
                    
                    if ([[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"] isEqualToString:@"Features"]) {
                        
                        NSMutableArray *facilityDetailsArray = [[[AmenitiesArray objectAtIndex:i] valueForKey:@"Features Details"] retain];
                        
                        
                        NSLog(@"Ammenity name  %@",[[AmenitiesArray objectAtIndex:i] valueForKey:@"Amenity Name"]);
                        
                        for (int j = 0; j<[facilityDetailsArray count]; j++) {
                            
                            NSMutableArray *pubInfoArray=[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                            //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                            
                            for (int k=0; k<[pubInfoArray count]; k++) {
                                
                                
                                
                                //     double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                                
                                
                                
                                [[DBFunctionality sharedInstance]InsertValue_Amenities_Detail:i+1  ammenity_TypeID:[[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Features ID"]intValue] facility_Name:[[facilityDetailsArray objectAtIndex:j]valueForKey:@"Features Name"] PubID:[[[pubInfoArray objectAtIndex:k]valueForKey:@"pubId"]intValue] withPubDistance:0.0 ];//distance/1000
                                
                                [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                            }
                            
                            [pubInfoArray release];
                        }
                        [facilityDetailsArray release];
                    }
                    
                    
                }
            }
            [AmenitiesArray release];
            
            
            
            //[self performSelector:@selector(dismissHUD:)];
            [delegate.sharedDefaults setObject:@"1" forKey:@"Facilities"]; 
            [delegate.sharedDefaults synchronize];
            
        }
        //-----------------------------5-45------------------------//
        
        //NSLog(@"ARRAY   %d",[foodAndOfferArray count]);
        
        else if([self.str_RefName  isEqualToString:@"Sports on TV"])
        {
            NSDictionary *json = [data_Response JSONValue];
            
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message for Sports on TV" message:timeString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //        [alert show];
            //        [alert release];
            
            NSMutableArray *sportsArray = [[[json valueForKey:@"Details"] valueForKey:@"Sports Details"] retain];
            
            if ([sportsArray count] != 0) {
                
                for (int i = 0; i<[sportsArray count]; i++) {
                    
                    [[DBFunctionality sharedInstance] InsertValue_Sports_Type:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] withName:[[sportsArray objectAtIndex:i] valueForKey:@"Category Name"]];
                    
                    NSMutableArray *sportDetailsArray = [[[sportsArray objectAtIndex:i] valueForKey:@"event"] retain];
                    //NSLog(@"sportDetailsArray  %d",[sportDetailsArray count]);
                    
                    for (int j = 0; j<[sportDetailsArray count]; j++) {
                        
                        NSMutableArray *pubInfoArray=[[[sportDetailsArray objectAtIndex:j]valueForKey:@"Pub Information"]retain];
                        //NSLog(@"pubInfoArray  %d",[pubInfoArray count]);
                        
                        //                        if ([pubInfoArray count] == 35) {
                        //                            
                        //                            NSLog(@"Problem");
                        //                        }
                        
                        for (int k=0; k<[pubInfoArray count]; k++) {
                            
                            
                            //   double distance = [self calculateDistance:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] doubleValue] andLongitude:[[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] doubleValue]];
                            
                            
                            [[DBFunctionality sharedInstance] InsertValue_Sports_Detail:[[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventID"] intValue] sport_TypeID:[[[sportsArray objectAtIndex:i] valueForKey:@"SportsID"] intValue] event_Name:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventName"] event_Description:[[sportDetailsArray objectAtIndex:j] valueForKey:@"eventDescription"] event_Date:[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"] event_Channel:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Channel"] reservation:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Reservation"] sound:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Sound"] hd:[[sportDetailsArray objectAtIndex:j] valueForKey:@"HD"] threeD:[[sportDetailsArray objectAtIndex:j] valueForKey:@"threeD"] screen:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Screen"] PubID:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withPubDistance:0.0 event_Time:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Time"] event_Type:[[sportDetailsArray objectAtIndex:j] valueForKey:@"Type"]];//distance/1000
                            
                            //NSLog(@"DATESHOW   %@",[[sportDetailsArray objectAtIndex:j] valueForKey:@"DateShow"]);
                            
                            [[DBFunctionality sharedInstance] InsertValue_Pub_Info:[[[pubInfoArray objectAtIndex:k] valueForKey:@"pubId"] intValue] withName:[[pubInfoArray objectAtIndex:k] valueForKey:@"Name"] distance:0.0 latitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Latitude"] longitude:[[pubInfoArray objectAtIndex:k] valueForKey:@"Longitude"] postCode:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubPostcode"] district:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubDistrict"] city:[[pubInfoArray objectAtIndex:k] valueForKey:@"pubCity"] lastUpdatedDate:(NSString *)[NSDate date] pubPhoto:[[pubInfoArray objectAtIndex:k] valueForKey:@"venuePhoto"]];//distance/1000
                        }
                        
                        [pubInfoArray release];
                    }
                    [sportDetailsArray release];
                }
            }
            
            [sportsArray release];
            
            //[self performSelector:@selector(dismissHUD:)];
            [delegate.sharedDefaults setObject:@"1" forKey:@"Sports on TV"];  
            [delegate.sharedDefaults synchronize];
            
        }
        
        
        
        self.RefNo+=1;
        if (![delegate.sharedDefaults objectForKey:@"All"]) {
            
            [self ExcuteURLWithNameRef:self.RefNo]; 
            
        }
        else{
            [self ExcuteURLWithNameRefWithDate:self.RefNo]; 
            
        }
        
        if (self.RefNo == 6) {
            RefNo=0;
            //[[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
            //[[DBFunctionality4Update sharedInstance] UpdatePubDistance];
            [self deletedDataCalling:0];
        }
    }
    
    else{
        
        if ([deletedEventString isEqualToString:@"EventsDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteRegularEvents:[[json valueForKey:@"Details"] valueForKey:@"Non Active Events"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    
                }
                //[Arr_events release];
                
                //sleep(2);
                [self deletedDataCalling:1];
                
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"ThemeNightDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteThemenightEvents:[[json valueForKey:@"Details"] valueForKey:@"Active Theme"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    
                }
                
                //[Arr_events release];
                //sleep(2);
                [self deletedDataCalling:2];
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"OneOffDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteOneOffEvents:[[json valueForKey:@"Details"] valueForKey:@"Non Active Events"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteEvents:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                }
                //[Arr_events release];
                //sleep(2);
                [self deletedDataCalling:3];
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"SportsDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    NSMutableArray *sportsIDArray = [[NSMutableArray alloc] init];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"sportID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteSports:pubid andEventID:EventId];
                                
                                [sportsIDArray addObject:[NSString stringWithFormat:@"%d",EventId]];
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    
                    [[DBFunctionality4Delete sharedInstance] deleteSports:sportsIDArray];
                }
                //[Arr_events release];
                //sleep(2);
                [self deletedDataCalling:4];
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"RealAleDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Event Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    [[DBFunctionality4Delete sharedInstance] deleteRealAle:[[json valueForKey:@"Details"] valueForKey:@"Non Active Ales"]];
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"EventID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteRealAle:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                }
                //[Arr_events release];
                //sleep(2);
                [self deletedDataCalling:5];
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"FoodDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Food Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        NSString *EventTypeID;
                        
                        if ([Str_Event isEqualToString:@"RegularEvent"])
                            EventTypeID = @"1";
                        else if([Str_Event isEqualToString:@"OneOffEvent"])
                            EventTypeID = @"2";
                        else if([Str_Event isEqualToString:@"ThemeNight"])
                            EventTypeID = @"3";
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FoodID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                
                                [[DBFunctionality4Delete sharedInstance] deleteFoods:pubid andEventID:EventId];
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    //[Arr_events release];
                }
                
                //[Arr_events release];
                //sleep(2);
                [self deletedDataCalling:6];
                //deletedDataCall = NO;
                //[self performSelector:@selector(doneLoadingTableViewData)];	
                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
        
        else if ([deletedEventString isEqualToString:@"FacilityDeleted"]) {
            
            {
                NSDictionary *json = [data_Response JSONValue];
                
                
                NSMutableArray *Arr_events = [[[json valueForKey:@"Details"] valueForKey:@"Facility Details"] retain];
                NSLog(@"%d",[Arr_events count]);
                
                if ([Arr_events count] != 0) {
                    
                    int EventTypeID;
                    if ([[[Arr_events objectAtIndex:0] valueForKey:@"Event Name"] isEqualToString:@"Facility"])
                        EventTypeID = 1;
                    else if([[[Arr_events objectAtIndex:1] valueForKey:@"Event Name"] isEqualToString:@"Style"])
                        EventTypeID = 2;
                    else if([[[Arr_events objectAtIndex:2] valueForKey:@"Event Name"] isEqualToString:@"Features"])
                        EventTypeID = 3;
                    
                    for (int i = 0; i < [Arr_events count]; i++) {
                        
                        //NSLog(@"%@",[[Arr_events objectAtIndex:i] valueForKey:@"Event Name"]);
                        //NSString *Str_Event = [[Arr_events objectAtIndex:i] valueForKey:@"Event Name"];
                        //NSLog(@"%@",Str_Event);
                        //NSString *EventTypeID;
                        
                        
                        
                        NSMutableArray *Arr_EventDetails = [[Arr_events objectAtIndex:i] valueForKey:@"Event Details"];
                        //NSLog(@"Arr_EventDetails : %d",[Arr_EventDetails count]);
                        
                        for (int j = 0; j < [Arr_EventDetails count]; j++) {
                            
                            int EventId = [[[Arr_EventDetails objectAtIndex:j] valueForKey:@"FacilityID"] intValue];
                            // NSLog(@"%d",EventId);
                            //NSLog(@"%@",Str_EventName);
                            
                            NSMutableArray *Arr_PubInfo = [[Arr_EventDetails objectAtIndex:j] valueForKey:@"Pub Information"];
                            //NSLog(@"%d",[Arr_PubInfo count]);
                            
                            for (int k = 0; k < [Arr_PubInfo count]; k++) {
                                
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"]);
                                // NSLog(@"%@",[[Arr_PubInfo objectAtIndex:k] valueForKey:@"latitude"]);
                                int pubid = [[[Arr_PubInfo objectAtIndex:k] valueForKey:@"pubId"] intValue];
                                [[DBFunctionality4Delete sharedInstance] deleteFacilities:pubid andEventID:EventId facilityID:EventTypeID];
                                
                                
                                
                            }
                            //[Arr_PubInfo release];
                        }
                        //[Arr_EventDetails release];
                    }
                    //[Arr_events release];
                }
                
                //[Arr_events release];
                //sleep(2);
                deletedDataCall = NO;
                [[DBFunctionality4Delete sharedInstance] deleteExpiredEvents];
                [[DBFunctionality4Delete sharedInstance] deleteExpiredSportsEvent];
                
                [[DBFunctionality sharedInstance] UpdatelastUadeField_PubDetails];
                [NSThread detachNewThreadSelector:@selector(myThreadMainMethod:) toTarget:self withObject:nil];

                //[[DBFunctionality4Update sharedInstance] UpdatePubDistance4Events];
               // [[DBFunctionality4Update sharedInstance] UpdatePubDistance4Sports];
                //[[DBFunctionality4Update sharedInstance] UpdatePubDistance4RealAle];
                //[[DBFunctionality4Update sharedInstance] UpdatePubDistance4Foods];
                //[[DBFunctionality4Update sharedInstance] UpdatePubDistance4Facilities];
                [self getNonSubPubs:1 withDate:[[DBFunctionality sharedInstance] GetlastupdateddatefromPubDetails]];
                [self performSelector:@selector(doneLoadingTableViewData)];	
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"callingServerFinished" object:self];

                //  [self performSelector:@selector(dismissHUD:)];
            }
        }
    }
    
    //[self performSelector:@selector(dismissHUD:)];
    
}



-(void) deletedDataCalling:(int)_callerNumber
{
    deletedDataCall = YES;
    
    if (_callerNumber == 0) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"EventsDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteEventsData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
    }
    if (_callerNumber == 1) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"ThemeNightDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteThemeNightData:[[DBFunctionality sharedInstance] GetlastupdateddatefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 2) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"OneOffDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteOneOffData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 3) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"SportsDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteSportsData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 4) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"RealAleDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteRealAleData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 5) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"FoodDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteFoodData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    if (_callerNumber == 6) {
        
        if([InternetValidation  checkNetworkStatus])
        {
            deletedEventString = @"FacilityDeleted";
            ServerConnection *conn1 = [[ServerConnection alloc] init];
            [conn1 setServerDelegate:self];
            [conn1 deleteFacilityData:[[DBFunctionality sharedInstance] GetlastupdatedDateandTimefromPubDetails]];
            [conn1 passInformationFromTheClass:self afterSuccessfulConnection:@selector(afterSuccessfulConnection:) afterFailourConnection:@selector(afterFailourConnection:)];
            [conn1 release];
        }
        else{
            NSLog(@"CONNECTION ERROR");
        }
        
        
    }
    
}

-(void)afterFailourConnection:(id)msg
{
    NSLog(@"MESSAGE  %@",msg);
    //[self callingNonSubPubs:nonSubValue];

    //[self performSelector:@selector(dismissHUD:)];
    [self performSelector:@selector(doneLoadingTableViewData)];	
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"callingServerFinished" object:self];
    UIAlertView   *alert =[[UIAlertView  alloc] initWithTitle:@"Pub & Bar Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = 10;
    [alert  show];
    [alert  release];
    
}


-(void)ExcuteURLWithNameRef:(int)_RefNumber
{
    
    if (![delegate.sharedDefaults objectForKey:@"All"])
    {
        if(_RefNumber<6)
        {
            NSLog(@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]);
            NSLog(@"%@",[Arr_CheckValue  objectAtIndex:_RefNumber]);
            
            
            if([self isValueCointainInDB:[NSString stringWithFormat:@"%@",[Arr_CheckValue  objectAtIndex:_RefNumber]]])
                
            {
                self.RefNo+=1;
                [self ExcuteURLWithNameRef:self.RefNo];
            }
            else
                
            {
                
                [self JSONStartWithName:[NSString stringWithFormat:@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]]];
            }  
            
        }
        else
        {
            
            //[Arr_URL_Name release];
            //[Arr_CheckValue release];
            //[self performSelector:@selector(dismissHUD:)];
            //[self performSelector:@selector(doneLoadingTableViewData)];	
            [delegate.sharedDefaults setObject:@"Completed" forKey:@"All"];
            [delegate.sharedDefaults synchronize];
            
        }
    }
    else{
        [self JSONStartWithName:[NSString stringWithFormat:@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]]];
        
    }
    
    
}



-(void)ExcuteURLWithNameRefWithDate:(int)_RefNumber
{
    if(_RefNumber<6)
    {
        NSLog(@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]);
        NSLog(@"%@",[Arr_CheckValue  objectAtIndex:_RefNumber]);
        
        
        
        
        [self JSONStartWithName:[NSString stringWithFormat:@"%@",[Arr_URL_Name  objectAtIndex:_RefNumber]]];
        
    }
    else
    {
        
        
        //[self performSelector:@selector(dismissHUD:)];
        //[self performSelector:@selector(doneLoadingTableViewData)];	
        //[delegate.sharedDefaults setObject:@"Completed" forKey:@"All"];
        //[delegate.sharedDefaults synchronize];
        
    } 
    
}


-(BOOL)isValueCointainInDB:(NSString*)_str_Name
{
    BOOL isBDPresent;
    
    if ([delegate.sharedDefaults objectForKey:_str_Name])
        isBDPresent=YES;
    else
        isBDPresent=NO;    
    
    return isBDPresent;
    
}

#pragma mark
#pragma mark AlertView Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10 ||alertView.tag == 30) {

        if (buttonIndex == 0) {
           
            //[self performSelector:@selector(addMBHud)];
            //[self performSelector:@selector(doneLoadingTableViewData)];	
            [self performSelector:@selector(dismissHUD:)];

        }
        else{
            //[self performSelector:@selector(dismissHUD:)];
            //[self performSelector:@selector(doneLoadingTableViewData)];	


        }
    }
    if (alertView.tag == 20) {
        if (buttonIndex == 0) {

            [self performSelector:@selector(callingServer)];
        }
    }
    if (alertView.tag == 60) {
        
        if (buttonIndex == 0) {
            
            [self performSelector:@selector(refreshButtonAction)];

        }
        else{
            //[NSThread detachNewThreadSelector:@selector(myThreadMainMethod:) toTarget:self withObject:nil];
            NSOperationQueue* queue = [NSOperationQueue new];
            NSInvocationOperation* operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(myThreadMainMethod:) object:nil];
            //[operation addDependency:self];
            [queue addOperation:operation];
            [operation release];

        }
    }
}

-(void) myThreadMainMethod:(id) sender
{
    [[DBFunctionality4Update sharedInstance] UpdatePubDistance];
    
}



#pragma mark-
#pragma mark-addMBHud
-(void) addMBHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    if (![delegate.sharedDefaults objectForKey:@"All"]) {
        
        _hud.labelText = @"Please wait.";
        _hud.detailsLabelText = @"Downloading data for first time.";
    }
    else{
        _hud.labelText = @"Please wait...";
        _hud.detailsLabelText = @"Downloading updated data since your last visit...";

    }
    
    
}
#pragma mark Dismiss Hud

- (void)dismissHUD:(id)arg {
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
}


#pragma mark
#pragma mark PullTableViewRefresh Delegates


- (void)reloadTableViewDataSource{
	
	//[self performSelector:@selector(addMBHud)];
    [self performSelector:@selector(callingServer)];
    //self.navigationController.view.userInteractionEnabled = NO;
    
}



- (void)doneLoadingTableViewData{
    
    //self.navigationController.view.userInteractionEnabled = YES;
	[self dataSourceDidFinishLoadingNewData];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
    
    
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
		_reloading = YES;
		[self performSelector:@selector(reloadTableViewDataSource) withObject:nil afterDelay:0.2];
		[refreshHeaderView setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		hometable.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
}


- (void)dataSourceDidFinishLoadingNewData{
	
    //[self performSelector:@selector(dismissHUD:)];
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[hometable setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
	[refreshHeaderView setCurrentDate];  //  should check if data reload was successful 
}

#pragma mark
#pragma mark Calculate Distance

-(double) calculateDistance :(double)_latitude andLongitude:(double)_longitude
{
    //NSString *latitude = @"51.5001524";
    //NSString *longitude = @"-0.1262362";
    //delegate.currentPoint.coordinate.latitude
    //delegate.currentPoint.coordinate.longitude
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:delegate.currentPoint.coordinate.latitude   longitude:delegate.currentPoint.coordinate.longitude];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:_latitude longitude:_longitude];
    
    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    [location1 release];
    [location2 release];
    
    return distance;
}

#pragma mark
#pragma mark Memory Handler

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.hometable = nil;
    self.btnSignUp = nil;
    self.selectionArray = nil;
    self.line_vw = nil;
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Sign In Done" object:nil];

    [Arr_URL_Name release];
    [Arr_CheckValue release];
    [hometable release];
    [btnSignUp release];
    [selectionArray release];
    [line_vw release];
    [toolBar release];
    [super dealloc];

}
@end
