

#import "NearByMap.h"
//#import "MapRouteView.h"
#import "CSMapAnnotation.h"
//#import "RestaurantFinderAppDelegate.h"
//#import "DetailViewController.h"
#import <CoreLocation/CoreLocation.h>



@implementation NearByMap

@synthesize mapView   = _mapView;
@synthesize type;
@synthesize startingPoint;
NSString *loc;

#pragma mark - View lifecycle


- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)_array
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
//        appDel = (RestaurantFinderAppDelegate*) [[UIApplication sharedApplication] delegate];
//        
//        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
//        locationManager.delegate = self;
//        locationManager.distanceFilter = kCLDistanceFilterNone; 
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        [locationManager startMonitoringSignificantLocationChanges];
//        
//        [locationManager startUpdatingLocation];
        
        
        NSLog(@"ARRAY  %@",_array);
        
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_mapView];
        [_mapView setDelegate:self];
        
                
        int j = 0;
        
        
        for (int i =0; i<[_array count]; i++) {
            
            CLLocation *poiLoc;
            NSString *locStr;
            
           // [[_array objectAtIndex:i] valueForKey:@""];
            
            if ([[[_array objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] != 0.0 && [[[_array objectAtIndex:i] valueForKey:@"Longitude"] doubleValue] != 0.0) {
                
                poiLoc = [[CLLocation alloc] initWithLatitude:[[[_array objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] longitude:[[[_array objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]];
                
                locStr  = [NSString stringWithFormat:@"%@",[[_array objectAtIndex:i] valueForKey:@"PubName"]];
                
                
                CSMapAnnotation* annotation = nil;
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[poiLoc coordinate]
                                                           annotationType:CSMapAnnotationTypeStart
                                                                    title:locStr] autorelease];
                annotation._id = [NSString stringWithFormat:@"%d",j];
                NSLog(@"IDDDDD  %@",annotation._id);
                [_mapView addAnnotation:annotation];
                
                [self setCurrentLocation:poiLoc];

            }
            
            
        }
                
        

    }
    return self;
}

-(void) setFrameOfView:(CGRect)frame
{
    self.frame = frame;
    [_mapView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}



- (void)setCurrentLocation:(CLLocation *)location {
    
    MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
    
    region.center = location.coordinate;
    
    region.span.longitudeDelta = 0.60f;//0.045f;
    region.span.latitudeDelta  = 0.60f;//0.045f;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	NSLog(@"annotation    %@",annotation);
   
	
	if([annotation isKindOfClass:[CSMapAnnotation class]])
	{
		// determine the type of annotation, and produce the correct type of annotation view for it.
		CSMapAnnotation* csAnnotation = (CSMapAnnotation*)annotation;
		if(csAnnotation.annotationType == CSMapAnnotationTypeStart || 
		   csAnnotation.annotationType == CSMapAnnotationTypeEnd)
		{
			
			NSString* identifier = @"Pin";
			
			MKPinAnnotationView* pin = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
			
			if(nil == pin)
			{
				pin = [[[MKPinAnnotationView alloc] initWithAnnotation:csAnnotation reuseIdentifier:identifier] autorelease];
				
			}
			
			[pin setPinColor:(csAnnotation.annotationType == CSMapAnnotationTypeEnd) ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed];
			NSLog(@"111111");
			if(csAnnotation.annotationType == CSMapAnnotationTypeStart)
			{
				NSLog(@"222222");
				pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
				pin.canShowCallout = YES;
				pin.enabled = YES;
                //pin.animatesDrop = YES;
				
			}
        
			annotationView = pin;
        
		}
		
		[annotationView setEnabled:YES];
		[annotationView setCanShowCallout:YES];
		
		
	}
	
	
	return annotationView;
	
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{	
	CSMapAnnotation* annotation = (CSMapAnnotation*)[view annotation];
	
	NSLog(@"TAAAppp    %@",annotation._id);
    
    //float statLat = 22.5776840;
    //float statLong = 88.4183484;
        
//    MapRouteView *ptr = [[MapRouteView alloc] initWithNibName:@"MapRouteView" bundle:[NSBundle mainBundle]];
//    ptr._storeLat = [NSString stringWithFormat:@"%@",[[[[appDel.placeDetailsArray valueForKey:@"result"] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"]];
//    ptr._storeLong = [NSString stringWithFormat:@"%@",[[[[appDel.placeDetailsArray valueForKey:@"result"] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"]];
//    ptr._storeName = [[appDel.placeDetailsArray valueForKey:@"result"]  valueForKey:@"name"];
//    ptr._storeImg = [[appDel.placeDetailsArray valueForKey:@"result"]  valueForKey:@"icon"];
//    [dealObj.navigationController pushViewController:ptr animated:YES];
//    [ptr release];
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc
{
    
    [_mapView release];
    [type release];
    [startingPoint release];
    [super dealloc];
}




@end
