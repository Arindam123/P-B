//
//  AppDelegate.m
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "SFCustomNavigationBar.h"
#import "Global.h"
#import "FacebookController.h"
#import "XML4Route.h"
#import "DBFunctionality4Update.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navController;
@synthesize homeView;
@synthesize currentView;
@synthesize tabBarController;
@synthesize PubandBar_DB;
@synthesize sharedDefaults;
@synthesize currentPoint;
@synthesize SelectedRadius;
@synthesize isback,ismore,Isvenue;
@synthesize Savedata;
@synthesize SaveSignIn;
@synthesize mapRouteLine;

//----------------------mb-28-05-12---------------//
@synthesize allImageDist;
@synthesize viewController_home;
@synthesize IscurrentLocation;
@synthesize IsNonsubscribed;
//--------//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    Savedata =[NSUserDefaults standardUserDefaults];
    SaveSignIn =[NSUserDefaults standardUserDefaults];
    
    if (GET_DEFAUL_VALUE(CurrentLocation) == nil)
        SAVE_AS_DEFAULT(CurrentLocation, @"YES");
    
    if (GET_DEFAUL_VALUE(ShowsResultIN) == nil)
        SAVE_AS_DEFAULT(ShowsResultIN, @"Miles");
    
    if (GET_DEFAUL_VALUE(SaveCacheToSeeHistory) == nil)
        SAVE_AS_DEFAULT(SaveCacheToSeeHistory,@"YES");
    
    if (GET_DEFAUL_VALUE(PubsShowsIn) == nil)
        SAVE_AS_DEFAULT(PubsShowsIn,@"LIST");
    
    if (GET_DEFAUL_VALUE(ShowNumberOfPubs) == nil) 
        SAVE_AS_DEFAULT(ShowNumberOfPubs,@"50");
    
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; 
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startMonitoringSignificantLocationChanges];
    
    [locationManager startUpdatingLocation];
    
    //@synchronized(self.PubandBar_DB)
   // {
        self.PubandBar_DB = [DBHandeler initWithDBName:@"PubandBar_DB.sqlite"];
        if([self.PubandBar_DB open] == NO)
        {
            [self.PubandBar_DB close];
        }
    //}
    
    
    
    sharedDefaults = [NSUserDefaults standardUserDefaults];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1];
    
    //-----------------------mb-28-05-12-----------------------//
    int def=[[sharedDefaults valueForKey:@"ApplicationRunning"]intValue];
    if (def!=1) {
        _viewController = [[[ViewController alloc] initWithNibName:[Constant GetNibName:@"ViewController"] bundle:nil] autorelease];
         self.navController = [[UINavigationController alloc] initWithRootViewController:_viewController];
    }
    else
    {
        viewController_home = [[[Home alloc] initWithNibName:[Constant GetNibName:@"Home"] bundle:nil] autorelease];
        self.navController = [[UINavigationController alloc] initWithRootViewController:viewController_home];//[SFCustomNavigationBar navigationControllerWithRootViewController:viewController_home];
    }
   
    //navController = [[UINavigationController alloc]initWithRootViewController:_viewController];
    //[[navController navigationBar] setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    navController.navigationBarHidden = YES;
    
	[self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   
    
   // [Appirater appEnteredForeground:YES];
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[FacebookController sharedInstance].facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    
    return [[FacebookController sharedInstance].facebook handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [NSThread detachNewThreadSelector:@selector(myThreadMainMethod:) toTarget:self withObject:nil];

    [[FacebookController sharedInstance].facebook extendAccessTokenIfNeeded];
    
    
}

-(void) myThreadMainMethod:(id) sender
{
    [[DBFunctionality4Update sharedInstance] UpdatePubDistance];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - LocationManager Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //NSLog(@"newLocationnewLocation %f  %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    //NSLog(@"oldLocation %f  %f",oldLocation.coordinate.latitude,oldLocation.coordinate.longitude);
    
	
	//currentPoint = [newLocation retain];
    CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[[NSString stringWithFormat:@"38.552486"] doubleValue] longitude:[[NSString stringWithFormat:@"-0.177948"] doubleValue]] autorelease];
    
    currentPoint = [loc retain];
    
    //38.552486,-0.177948
    
    IscurrentLocation=YES;
    //NSLog(@"appDel.currentPoint %@",currentPoint);
	//[manager stopUpdatingLocation];
    
	
	/*MKCoordinateRegion region;	
     region.span.longitudeDelta =0.219727;// .0001;;
     region.span.latitudeDelta = 0.221574;// .007;;
     
     region.center.latitude = [appDel.currentPoint coordinate].latitude;
     region.center.longitude = [appDel.currentPoint coordinate].longitude;
     [_mapView setRegion:region];*/
	
	
}

-(BOOL) callingXML4Route:(NSString *)urlX
{
	NSURL *url= [[NSURL alloc] initWithString:urlX];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	XML4Route *parser = (XML4Route*)[[XML4Route alloc] initXMLParser];
	[xmlParser setDelegate:parser];
	BOOL success = [xmlParser parse];
    NSLog(@"%d",[xmlParser parse]);
	
	
	return success;
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error 
{
	
	[manager stopUpdatingLocation];
    
    IscurrentLocation=NO;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pub and Bar Network" message:@"Please enable Location Services from your iPhone Settings to use this search feature. Only 'Text Search' can be used without location enabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

@end
