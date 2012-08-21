

#import "NearByMap.h"
#import "MapRouteView.h"
#import "CSMapAnnotation.h"
#import <CoreLocation/CoreLocation.h>

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395
#define ZOOM_LEVEL 6



@interface NearByMap (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end

@implementation NearByMap

@synthesize mapView   = _mapView;
@synthesize type;
@synthesize startingPoint;
@synthesize superClass;
NSString *loc;

#pragma mark - View lifecycle

#pragma mark -
#pragma mark Map conversion methods

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:_mapView centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [_mapView setRegion:region animated:animated];
}


- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)_array withController:(UIViewController *) _viewController
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        locationArray = _array;
        [locationArray retain];
        superClass = _viewController;
        //        
        //        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        //        locationManager.delegate = self;
        //        locationManager.distanceFilter = kCLDistanceFilterNone; 
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //        [locationManager startMonitoringSignificantLocationChanges];
        //        
        //        [locationManager startUpdatingLocation];
        
        
        //NSLog(@"ARRAY  %@",_array);
        
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _mapView.showsUserLocation = YES;
        [self addSubview:_mapView];
        [_mapView setDelegate:self];
        
        
        //int j = 0;
        
        //[locationArray removeAllObjects];
        for (int i =0; i<[_array count]; i++) {
            
            CLLocation *poiLoc;
            NSString *locStr;
            
            // [[_array objectAtIndex:i] valueForKey:@""];
            
            if ([[[_array objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] != 0.0 && [[[_array objectAtIndex:i] valueForKey:@"Longitude"] doubleValue] != 0.0) {
                
                poiLoc = [[CLLocation alloc] initWithLatitude:[[[_array objectAtIndex:i] valueForKey:@"Latitude"] doubleValue] longitude:[[[_array objectAtIndex:i] valueForKey:@"Longitude"] doubleValue]];
                
                if ([[[_array objectAtIndex:i] valueForKey:@"PhoneNumber"] length] != 0) {
                    
                    locStr  = [NSString stringWithFormat:@"%@/%@",[[_array objectAtIndex:i] valueForKey:@"PubName"],[[_array objectAtIndex:i] valueForKey:@"PhoneNumber"]];
                }
                else
                    locStr  = [NSString stringWithFormat:@"%@",[[_array objectAtIndex:i] valueForKey:@"PubName"]];
                
                
                if ([[_array objectAtIndex:i] valueForKey:@"venuePhoto"]) {
                    
                    CSMapAnnotation* annotation = nil;
                    annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[poiLoc coordinate] annotationType:CSMapAnnotationTypeEnd title:locStr] autorelease];
                    annotation._id = [NSString stringWithFormat:@"%d",i];
                    //NSLog(@"IDDDDD  %@",annotation._id);
                    [_mapView addAnnotation:annotation];
                    
                }
                if(![[_array objectAtIndex:i] valueForKey:@"venuePhoto"])
                {
                    CSMapAnnotation* annotation = nil;
                    annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[poiLoc coordinate] annotationType:CSMapAnnotationTypeStart title:locStr] autorelease];
                    annotation._id = [NSString stringWithFormat:@"%d",i];
                    //NSLog(@"IDDDDD  %@",annotation._id);
                    [_mapView addAnnotation:annotation];
                }
                
                
                //[locationArray addObject:annotation];
                
                /*if ([[[_array objectAtIndex:i] valueForKey:@"PubName"] isEqualToString:@"Beluga"]) {
                 
                 NSLog(@"DISNATNCE   %@",[[_array objectAtIndex:i] valueForKey:@"PubDistance"]);
                 CSMapAnnotation* annotation = nil;
                 annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[poiLoc coordinate]
                 annotationType:CSMapAnnotationTypeStart
                 title:locStr] autorelease];
                 annotation._id = [NSString stringWithFormat:@"%d",i];
                 //NSLog(@"IDDDDD  %@",annotation._id);
                 [_mapView addAnnotation:annotation];
                 //[locationArray addObject:annotation];
                 }*/
                
                
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
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /*CLLocationCoordinate2D zoomLocation;
     zoomLocation.latitude = 39.281516;
     zoomLocation.longitude= -76.580806;
     // 2
     MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
     // 3
     MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
     // 4
     [_mapView setRegion:adjustedRegion animated:YES];*/
    
    double Latitude = 53.5341405;
    double Longitude = -2.2846582;
    //CLLocationCoordinate2D centerCoord = { Latitude, Longitude };
    [self setCenterCoordinate:app.currentPoint.coordinate zoomLevel:ZOOM_LEVEL animated:NO];
    
    /*MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
     region.center = app.currentPoint.coordinate;
     
     //region.center = location.coordinate;
     region.span.longitudeDelta = 0.02f;//0.045f;
     region.span.latitudeDelta  = 0.02f;//0.045f;
     
     //[self.mapView setRegion:region animated:YES];
     [self.mapView regionThatFits:region];*/
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
			NSLog(@"111111   %d",(csAnnotation.annotationType == CSMapAnnotationTypeEnd));
			//if(csAnnotation.annotationType == CSMapAnnotationTypeStart)
			{
				NSLog(@"222222");
				pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
				pin.canShowCallout = YES;
				pin.enabled = YES;
                pin.animatesDrop = YES;
				
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
    
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate ];
	CSMapAnnotation* annotation = (CSMapAnnotation*)[view annotation];
	
    //  NSString *latitude = @"51.5001524";
    //  NSString *longitude = @"-0.1262362";
    
	NSLog(@"TAAAppp    %@  ",annotation._id);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f&saddr=%f,%f&dirflg=d&doflg=ptm",[[[locationArray objectAtIndex:annotation._id.intValue] valueForKey:@"Latitude"] doubleValue],[[[locationArray objectAtIndex:annotation._id.intValue] valueForKey:@"Longitude"] doubleValue],app.currentPoint.coordinate.latitude,app.currentPoint.coordinate.longitude]]];
    //http://maps.google.com/maps?saddr=London+UK&daddr=Birmingham+UK&dirflg=r
    
    /* MapRouteView *ptr = [[MapRouteView alloc] initWithNibName:@"MapRouteView" bundle:[NSBundle mainBundle]];
     ptr._storeLat = [[locationArray objectAtIndex:annotation._id.intValue] valueForKey:@"Latitude"];
     ptr._storeLong = [[locationArray objectAtIndex:annotation._id.intValue] valueForKey:@"Longitude"];
     ptr._storeName = [[locationArray objectAtIndex:annotation._id.intValue] valueForKey:@"PubName"];
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ptr];
     [superClass presentModalViewController:nav animated:YES];
     [ptr release];
     [nav release];*/
    
    
    
    
    
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
