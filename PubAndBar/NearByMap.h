

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


//@class RestaurantFinderAppDelegate;
//@class DealDetailsViewController;
//@class DetailViewController;


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
   
}


@property (nonatomic, retain) MKMapView* mapView;
@property (nonatomic, retain) NSString *type;
@property (nonatomic,retain) CLLocation *startingPoint;


- (void)setCurrentLocation:(CLLocation *)location;
- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)_array;
-(void) setFrameOfView:(CGRect)frame;




@end
