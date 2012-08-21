//
//  MapRouteView.h
//  HotelSearch
//
//  Created by Design Services on 16/08/10.
//  Copyright 2010 Isis Design. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
@class AppDelegate;


@interface MapRouteView : UIViewController <MKMapViewDelegate>{

	MKMapView* _mapView;
	
	// details view controller
	
	
	// dictionary of route views indexed by annotation
	NSMutableDictionary* _routeViews;
	NSString *type;
	NSString *vId;
	NSString *_storeName;
	NSString *_storeImg;
	NSString *_storeLat;
	NSString *_storeLong;
	NSString *_storeTime;
	NSString *_storeInfo;
	NSString *_storeFav;	
	NSString *_storeContact;
	
    UIActivityIndicatorView *spinner;
    NSTimer *loaderTimer;
	
	
	NSString *flg;
	
	AppDelegate *appDel;
	
	BOOL callingFrom;
	
}



- (NSMutableArray *) decodePolyline:(NSString *)encodedPoints;

@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *_storeName;
@property (nonatomic, retain) NSString *_storeLong;
@property (nonatomic, retain) NSString *_storeImg;
@property (nonatomic, retain) NSString *_storeLat;

@property BOOL callingFrom;




//@property (nonatomic, retain) ESPProjectAppDelegate *appDel;

@property (nonatomic, retain) NSString *flg;


@end
