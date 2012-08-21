//
//  AppDelegate.h
//  PubAndBar
//
//  Created by Alok K Goyal on 05/04/12.
//  Copyright (c) 2012 A G Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <sqlite3.h>
#import "DBHandeler.h"
#import "SaveHomeInfo.h"
#import <CoreLocation/CoreLocation.h>
#import "Appirater.h"
//#import "Home.h"


@class ViewController;
@class Home;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,CLLocationManagerDelegate>{
    
    UITabBarController *tabBarController;
    UINavigationController *navController;
    UIViewController *homeView;
    UIViewController *currentView;
   
    DBHandeler *PubandBar_DB;
       BOOL issportsEvent;
    NSUserDefaults *sharedDefaults;
    CLLocation	*currentPoint;
    NSString *SelectedRadius;


    //------------------mb28-05-12--------------------------//
    NSMutableDictionary *allImageDist;
    Home *viewController_home;
    
    UIInterfaceOrientation *orientation;
    BOOL ismore;
    BOOL isback;
    BOOL Isvenue;
     NSUserDefaults *Savedata;
    NSUserDefaults *SaveSignIn;
    
    NSString *mapRouteLine;
    BOOL IscurrentLocation;
    BOOL IsNonsubscribed;

    
}
@property (nonatomic,assign) BOOL IsNonsubscribed;
@property (nonatomic,assign)BOOL IscurrentLocation;
@property (nonatomic, retain)NSUserDefaults *SaveSignIn;
@property (nonatomic, retain)NSUserDefaults *Savedata;
@property (nonatomic,assign)BOOL Isvenue;
@property (nonatomic,assign)BOOL isback;
@property (nonatomic,assign)BOOL ismore;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property(nonatomic,retain)UIViewController *homeView;
@property(nonatomic,retain)UIViewController *currentView;
@property(nonatomic,retain)UINavigationController *navController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) NSString *mapRouteLine;


@property (nonatomic , retain) DBHandeler *PubandBar_DB;
@property (nonatomic , retain)NSUserDefaults *sharedDefaults;
@property (nonatomic , retain)    CLLocation	*currentPoint;
@property (nonatomic , retain)NSString *SelectedRadius;
//------------------mb28-05-12--------------------------//
@property (strong, nonatomic) Home *viewController_home;
@property (nonatomic, retain) NSMutableDictionary *allImageDist;
//@property (nonatomic, retain) UIInterfaceOrientation *orientation;

-(BOOL) callingXML4Route:(NSString *)urlX;



@end
