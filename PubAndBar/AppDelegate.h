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
    
}
@property (nonatomic,assign)BOOL issportsEvent;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property(nonatomic,retain)UIViewController *homeView;
@property(nonatomic,retain)UIViewController *currentView;
@property(nonatomic,retain)UINavigationController *navController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic , retain)DBHandeler *PubandBar_DB;
@property (nonatomic , retain)NSUserDefaults *sharedDefaults;
@property (nonatomic , retain)    CLLocation	*currentPoint;
@property (nonatomic , retain)NSString *SelectedRadius;
//------------------mb28-05-12--------------------------//
@property (strong, nonatomic) Home *viewController_home;
@property (nonatomic, retain) NSMutableDictionary *allImageDist;


@end
