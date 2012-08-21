

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

//@class RestaurantFinderAppDelegate;
//@class DealDetailsViewController;
//@class DetailViewController;
#define METERS_PER_MILE 1609.344


@interface NearByMap : UIView <CLLocationManagerDelegate,MKMapViewDelegate>{
    int indexPath4Array;
    MKMapView* _mapView;
	
	//RestaurantFinderAppDelegate *appDel;
	NSString *type;
	
	NSTimer *loaderTimer;
	UIActivityIndicatorView *spinner;
	//DetailViewController *dealObj;
	
	
	CLLocation *startingPoint;
    int arrayIndex;
    NSMutableArray *locationArray;
    AppDelegate *app;
    UIViewController *superClass;
}


@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) NSString *type;
@property (nonatomic,retain) CLLocation *startingPoint;
@property (nonatomic,retain) UIViewController *superClass;



- (void)setCurrentLocation:(CLLocation *)location;
- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)_array withController:(UIViewController *) _viewController;
-(void) setFrameOfView:(CGRect)frame;




@end
