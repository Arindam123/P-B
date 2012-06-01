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


@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navController;
@synthesize homeView;
@synthesize currentView;
@synthesize tabBarController;
@synthesize PubandBar_DB;
@synthesize issportsEvent;
@synthesize sharedDefaults;
@synthesize currentPoint;
@synthesize SelectedRadius;

//----------------------mb-28-05-12---------------//
@synthesize allImageDist;
@synthesize viewController_home;
//--------//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; 
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startMonitoringSignificantLocationChanges];
    
    [locationManager startUpdatingLocation];
    
    self.PubandBar_DB = [DBHandeler initWithDBName:@"PubandBar_DB.sqlite"];
    if([self.PubandBar_DB open] == NO)
    {
        [self.PubandBar_DB close];
    }
    
    sharedDefaults = [NSUserDefaults standardUserDefaults];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //-----------------------mb-28-05-12-----------------------//
    int def=[[sharedDefaults valueForKey:@"ApplicationRunning"]intValue];
    if (def!=1) {
        _viewController = [[[ViewController alloc] initWithNibName:[Constant GetNibName:@"ViewController"] bundle:nil] autorelease];
        [sharedDefaults setObject:@"1" forKey:@"ApplicationRunning"];
         self.navController = [SFCustomNavigationBar navigationControllerWithRootViewController:_viewController];
    }
    else
    {
        viewController_home = [[[Home alloc] initWithNibName:[Constant GetNibName:@"Home"] bundle:nil] autorelease];
        self.navController = [SFCustomNavigationBar navigationControllerWithRootViewController:viewController_home];
    }
   
    //navController = [[UINavigationController alloc]initWithRootViewController:_viewController];
    //[[navController navigationBar] setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[Constant GetImageName:@"TopBar"]]]];
    navController.navigationBarHidden = NO;
    
	[self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];
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
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
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
    
	
	currentPoint = [newLocation retain];
    NSLog(@"appDel.currentPoint %@",currentPoint);
	[manager stopUpdatingLocation];
    
	
	/*MKCoordinateRegion region;	
     region.span.longitudeDelta =0.219727;// .0001;;
     region.span.latitudeDelta = 0.221574;// .007;;
     
     region.center.latitude = [appDel.currentPoint coordinate].latitude;
     region.center.longitude = [appDel.currentPoint coordinate].longitude;
     [_mapView setRegion:region];*/
	
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error 
{
	
	[manager stopUpdatingLocation];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have denied this app access to your devices location and cannot use this feature." message:@"Go to your devices settings menu then General > Location Services >InsiderApp and set to on to restore use of this feature. " delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

@end
